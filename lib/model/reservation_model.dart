import 'package:cafe_mobile_app/model/table_model.dart';

class ReservationModel {
  int? id;
  String? date;
  int? ClientId;
  int? TableId;
  int? ReservationStatusId;
  TableModel? Table;

  ReservationModel({
    this.id, this.date, this.ClientId, this.TableId, this.ReservationStatusId
  });

  factory ReservationModel.fromJSON(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      date: json['date'],
      ClientId: json['ClientId'],
      TableId: json['TableId'],
      ReservationStatusId: json['ReservationStatusId']
    );
  }
}