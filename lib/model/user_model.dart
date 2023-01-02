class UserModel {
  String? lastName;
  String? firstName;
  String? email;
  String? phone;
  int? points;

  UserModel({
    this.lastName, this.firstName, this.email, this.phone, this.points
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      lastName: json['lastName'],
      firstName: json['firstName'],
      email: json['email'],
      phone: json['phone'],
      points: json['points']
    );
  }
}