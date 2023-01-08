import 'package:cafe_mobile_app/model/reservation_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/table_model.dart';
import '../service/interceptor/dioClient.dart';
import '../service/time_service.dart';

class ReservationsViewModel {
  final DioClient _dioClient = Get.put(DioClient());
  final TimeService _timeService = Get.put(TimeService());

  final String tablesUrl = '${dotenv.env['BASE_URL']!}/tables';
  final String reservationUrl = '${dotenv.env['BASE_URL']!}/reservations';
  final String reservationsByStatusIdUrl = '${dotenv.env['BASE_URL']!}/reservations/reservationstatus';
  final String userReservationsUrl = '${dotenv.env['BASE_URL']!}/reservations/client';

  Future<List<TableModel>> getReservations(String selectedDate) async {

    final tables = await _dioClient.dioClient.get('$tablesUrl/');
    final reservations = await _dioClient.dioClient.get('$reservationsByStatusIdUrl/1');
    List<TableModel> tablesList = <TableModel>[];
    if (reservations.statusCode == 200 && tables.statusCode == 200) {
      tables.data.forEach((table) => {
        tablesList.add(TableModel.fromJSON(table)),
      });
      reservations.data.forEach((reservation) {
        var reservationDateTime = DateTime.parse(reservation['date']);
        String reservationDate = DateFormat('yyyy-MM-dd').format(reservationDateTime);
        if(selectedDate == reservationDate) {
          var reservedTable = tablesList.firstWhere((element) => element.number == reservation['TableId']);
          reservedTable.TableStatusId = 2;
          tablesList[tablesList.indexWhere((table) => table.number == reservation['TableId'])] = reservedTable;
        }
      });
      return tablesList;
    } else {
      throw Exception('Nie udało się załadować rezerwacji');
    }
  }

  Future<List<ReservationModel>> getUserReservations(String sortType, bool onlyActive) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if(userId != null) {
      final reservations = await _dioClient.dioClient.get('$userReservationsUrl/$userId');
      List<ReservationModel> reservationsList = <ReservationModel>[];
      if(reservations.statusCode == 200) {
        reservations.data.forEach((reservation) {
          var reservationDateTime = DateTime.parse(reservation['date']);
          final format = DateFormat('yyyy-MM-dd HH:mm');
          final formattedDateTime = _timeService.convertUtcToLocalTime(format, reservationDateTime);
          reservation['date'] = formattedDateTime;
          if(onlyActive && (reservation['ReservationStatusId'] == 1)) {
            reservationsList.add(ReservationModel.fromJSON(reservation));
          } else if (!onlyActive) {
            reservationsList.add(ReservationModel.fromJSON(reservation));
          }
        });
      }
      if (sortType == "date_desc") {
        reservationsList.sort((a,b) => b.date!.compareTo(a.date!));
      } else {
        reservationsList.sort((a,b) => a.date!.compareTo(b.date!));
      }
      return reservationsList;
    } else {
      throw Exception('Błąd podczas pobierania rezerwacji');
    }

  }

  Future<String> createReservations(String selectedDate, String selectedTime, int tableNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if (userId != null) {
      var data = {
        "date":  "$selectedDate $selectedTime",
        "TableId": tableNumber,
        "ClientId": userId,
        "ReservationStatusId": 1
      };
      try {
        final response = await _dioClient.dioClient.post(
          '$reservationUrl/', data: data,
        );
        if(response.statusCode == 404) {
          if (response.data['message'].toString().contains('ma już aktywną Rezerwację')) {
            return 'Posiadasz już jedną aktywna rezerwację, anuluj ja przed złożeniem nowej';
          } else {
            return response.data['message'];
          }
        } else if (response.statusCode == 200){
          return "Dodano nową rezerwację";
        } else {
          return "Wystąpił błąd";
        }
      } catch (exception) {
        return 'Wystąpił błąd serwera';
      }

    } else {
       return "Błąd podczas dodawania rezerwacji";
    }
  }

  Future<String> cancelReservations(int reservationId) async {
    final reservation = await _dioClient.dioClient.get('$reservationUrl/$reservationId');
    if(reservation.statusCode == 200) {
      reservation.data['ReservationStatusId'] = 2;
      final cancellation = await _dioClient.dioClient.put(
          '$reservationUrl/$reservationId',
          data: reservation.data
      );
      if(cancellation.statusCode == 200) {
        return("Anulowano rezerwację");
      }
      return "Błąd podczas anulowania rezerwacji";
    } else {
      return "Błąd podczas anulowania rezerwacji";
    }
  }
}