class UsersVoucherModel {
  int? id;
  String? code;
  String? expirationDate;
  String? couponName;
  double? productPrice;
  double? newProductPrice;
  int? daysUntilExpiration;
  int? CouponId;
  int? UserCouponStatusId;

  UsersVoucherModel({
    this.id, this.code, this.expirationDate, this.productPrice, this.newProductPrice, this.couponName, this.daysUntilExpiration, this.CouponId, this.UserCouponStatusId
  });

  factory UsersVoucherModel.fromJSON(Map<String, dynamic> json) {
    return UsersVoucherModel(
        id: json['id'],
        code: json['code'],
        CouponId: json['CouponId'],
        UserCouponStatusId: json['UserCouponStatusId']
    );
  }
}