class OrderDetailModel {
  int? id;
  double? unitPrice;
  int? quantity;
  int? isCoupon;
  int? ProductId;
  String? UserCouponId;

  OrderDetailModel({
    this.id, this.unitPrice, this.quantity, this.ProductId, this.UserCouponId
  });

  factory OrderDetailModel.fromJSON(Map<String, dynamic> json) {
    return OrderDetailModel(
        id: json['id'],
        unitPrice: json['transaction_price'],
        quantity: json['quantity'],
        ProductId: json['ProductId'],
        UserCouponId: json['UserCouponId']
    );
  }
}