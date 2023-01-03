class UserModel {
  String? lastName;
  String? firstName;
  String? email;
  String? phone;
  String? sex;
  int? points;

  UserModel({
    this.lastName, this.firstName, this.email, this.phone, this.points, this.sex
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      lastName: json['lastname'],
      firstName: json['firstname'],
      email: json['email'],
      phone: json['phone'],
      sex: json['sex'],
      points: json['points']
    );
  }
}