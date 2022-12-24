class VoucherModel {
  int? id;
  int? value;
  int? pointPrice;
  bool? isAvailable;
  int? ProductId;
  String? productName;
  double? productPrice;

  VoucherModel({
    this.id,
    this.value,
    this.pointPrice,
    this.isAvailable,
    this.ProductId,
    this.productName,
    this.productPrice
  });

  factory VoucherModel.fromJSON(Map<String, dynamic> json) {
    return VoucherModel(
        id: json['id'],
        value: json['value'],
        pointPrice: json['pointPrice'],
        isAvailable: json['isAvailable'],
        ProductId: json['ProductId']
    );
  }
}