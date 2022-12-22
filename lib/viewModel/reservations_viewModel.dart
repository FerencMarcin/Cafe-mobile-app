import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/table_model.dart';
import '../service/interceptor/dioClient.dart';

class ReservationsViewModel {
  final DioClient _dioClient = Get.put(DioClient());

  Future<List<TableModel>> getReservations(String selectedDate) async {
    final tables = await _dioClient.dioClient.get('http://10.0.2.2:3001/tables/');
    final reservations = await _dioClient.dioClient.get('http://10.0.2.2:3001/reservations/reservationstatus/1');
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
      final response = await _dioClient.dioClient.post(
          'http://10.0.2.2:3001/reservations/', data: data,
      );
      if(response.statusCode == 404) {
        return response.data['message'];
      } else if (response.statusCode == 200){
        return "Dodano nową rezerwację";
      } else {
        return "Wystąpił błąd";
      }
    } else {
       return "Błąd podczas dodawania rezerwacji";
    }
  }
}