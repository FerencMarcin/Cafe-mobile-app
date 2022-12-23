class RegistrationRequestModel {
  String? email;
  String? password;
  String? phoneNumber;
  String? firstname;
  String? lastname;
  String? sex;

  RegistrationRequestModel({
    this.email,
    this.password,
    this.phoneNumber,
    this.firstname,
    this.lastname,
    this.sex
  });

  Map<String, dynamic> makeRegistrationRequest() {
    final Map<String, dynamic> requestData = <String, dynamic>{};
    requestData['email'] = email;
    requestData['password'] = password;
    requestData['firstname'] = firstname;
    requestData['lastname'] = lastname;
    requestData['phoneNumber'] = phoneNumber;
    requestData['sex'] = sex;
    return requestData;
  }

}