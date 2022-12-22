class TableModel {
  int? number;
  int? numberOfSeats;
  int? TableStatusId;

  TableModel({
    this.number, this.numberOfSeats, this.TableStatusId
  });

  factory TableModel.fromJSON(Map<String, dynamic> json) {
    return TableModel(
        number: json['number'],
        numberOfSeats: json['numberOfSeats'],
        TableStatusId: json['TableStatusId']
    );
  }
}