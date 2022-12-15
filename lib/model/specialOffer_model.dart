class SpecialOfferModel {
  int? id;
  double? value;
  String? startDate;
  String? endDate;
  int? ProductId;

  SpecialOfferModel({
    this.id, this.value, this.startDate, this.endDate, this.ProductId
  });

  factory SpecialOfferModel.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferModel(
      id: json['id'],
      value: json['value'].toDouble(),
      startDate: json['start_date'],
      endDate: json['end_date'],
      ProductId: json['ProductId'],
    );
  }

}