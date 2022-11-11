class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({
    this.email,
    this.password
  });

  Map<String, dynamic> makeLoginRequest() {
    final Map<String, dynamic> requestData = Map<String, dynamic>();
    requestData['email'] = this.email;
    requestData['password'] = this.password;
    return requestData;
  }
}