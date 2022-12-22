import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  Future<String> createReservations(String selectedDate, int tableNumber) async {
    log(selectedDate);
    log(tableNumber.toString());
    return "aaa";
    // if (reservations.statusCode == 200 && tables.statusCode == 200) {
    //
    //   return "Dodano rezerwację";
    // } else {
    //   throw Exception('Nie udało się załadować rezerwacji');
    // }
  }
}