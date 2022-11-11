class LoginResponseModel {
  int? roleId;
  String? token;

  LoginResponseModel({
    this.roleId,
    this.token
  });

  LoginResponseModel.convertResponse(Map<String, dynamic> responseData) {
    roleId = responseData['token'];
    token = responseData['token'];
  }
}