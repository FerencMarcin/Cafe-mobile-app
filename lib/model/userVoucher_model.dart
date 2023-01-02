class UserVoucherModel {
  String? code;
  String? expirationDate;
  int? CouponId;
  int? UserCouponStatusId;

  UserVoucherModel({
    this.code, this.expirationDate, this.CouponId, this.UserCouponStatusId
  });

  factory UserVoucherModel.fromJSON(Map<String, dynamic> json) {
    return UserVoucherModel(
        code: json['code'],
        expirationDate: json['expirationDate'],
        CouponId: json['CouponId'],
        UserCouponStatusId: json['UserCouponStatusId']
    );
  }
}