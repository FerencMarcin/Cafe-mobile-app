class VoucherModel {
  int? id;
  int? value;
  int? pointPrice;
  bool? isAvailable;
  int? ProductId;
  String? couponName;
  double? productPrice;
  double? newProductPrice;

  VoucherModel({
    this.id,
    this.value,
    this.pointPrice,
    this.isAvailable,
    this.ProductId,
    this.couponName,
    this.productPrice,
    this.newProductPrice
  });

  factory VoucherModel.fromJSON(Map<String, dynamic> json) {
    return VoucherModel(
        id: json['id'],
        value: json['value'],
        pointPrice: json['pointPrice'],
        isAvailable: json['isAvailable'],
        ProductId: json['ProductId'],
        couponName: json['Product']['name'] + ' - ' + json['Product']['size'],
        productPrice: json['Product']['price'].toDouble(),
        newProductPrice: json['Product']['price'].toDouble() * (100-json['value']) / 100
    );
  }
}