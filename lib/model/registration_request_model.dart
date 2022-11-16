class RegistrationRequestModel {
  String? email;
  String? password;
  String? number;
  String? firstName;
  String? lastName;
  String? sex;

  RegistrationRequestModel({
    this.email,
    this.password,
    this.number,
    this.firstName,
    this.lastName,
    this.sex
  });

  Map<String, dynamic> makeRegistrationRequest() {
    final Map<String, dynamic> requestData = <String, dynamic>{};
    requestData['email'] = email;
    requestData['password'] = password;
    requestData['firstname'] = firstName;
    requestData['lastname'] = lastName;
    requestData['phoneNumber'] = number;
    requestData['sex'] = sex;
    return requestData;
  }

}