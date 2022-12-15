class SpecialOfferModel {
  int? id;
  double? value;
  String? startDate;
  String? endDate;

  SpecialOfferModel({
    this.id, this.value, this.startDate, this.endDate
  });

  factory SpecialOfferModel.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferModel(
      id: json['id'],
      value: json['value'].toDouble(),
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }

}