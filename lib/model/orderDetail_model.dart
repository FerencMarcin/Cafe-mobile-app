class OrderDetailModel {
  int? id;
  double? unitPrice;
  int? quantity;
  bool? isCoupon;
  int? ProductId;
  String? UserCouponId;
  String? productName;

  OrderDetailModel({
    this.id, this.unitPrice, this.quantity, this.isCoupon, this.ProductId, this.UserCouponId, this.productName
  });

  factory OrderDetailModel.fromJSON(Map<String, dynamic> json) {
    return OrderDetailModel(
        id: json['id'],
        unitPrice: json['transaction_price'].toDouble(),
        quantity: json['quantity'],
        isCoupon: json['isCoupon'],
        ProductId: json['ProductId'],
        UserCouponId: json['UserCouponId'],
        productName: json['Product']['name']
    );
  }
}