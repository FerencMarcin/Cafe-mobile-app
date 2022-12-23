class OrderHeaderModel {
  int? id;
  String? date;
  double? value;
  int? productsAmount;
  int? OrderStatusId;
  int? PaymentId;

  OrderHeaderModel({
    this.id, this.date, this.value, this.productsAmount, this.OrderStatusId, this.PaymentId
  });

  factory OrderHeaderModel.fromJSON(Map<String, dynamic> json) {
    return OrderHeaderModel(
        id: json['id'],
        date: json['updatedAt'],
        value: json['finalPrice'].toDouble(),
        productsAmount: json['OrderDetails'].length,
        OrderStatusId: json['OrderStatusId'],
        PaymentId: json['PaymentId']
    );
  }
}