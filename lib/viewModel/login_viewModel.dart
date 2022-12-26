import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/login_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends GetxController {
  final LoginService _loginService = Get.put(LoginService());
  final AuthService _authService = Get.find();

  Future<void> userLogin(String email, String password) async {
    final response = await _loginService.fetchUserLogin(email, password);
    final responseData = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw responseData['error'];
    } else {
      _authService.saveRefreshToken(response);
      _authService.login(responseData['accessToken']);
    }
  }

  Future<dynamic> resetPassword(String email) async {
    const String resetPasswordUrl = 'http://10.0.2.2:3001/auth/requestpasswordreset';
    var url = Uri.parse(resetPasswordUrl);
    final http.Response response = await http.post(url, body: {"email": email});
    log(response.body.toString());
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<String> changePassword(String resetCode, String email, String password) async {
    const String resetPasswordUrl = 'http://10.0.2.2:3001/auth//resetpassword';
    var url = Uri.parse(resetPasswordUrl);
    final http.Response response = await http.post(url,
      body: {
        "password": password,
        "email": email,
        "resetCode": resetCode
      }
    );
    log(response.body.toString());
    final responseData = jsonDecode(response.body);
    if (responseData['error'] == null ) {
      return responseData['message'];
    } else {
      return responseData['error'];
    }
  }

  void userLogout() async {
    _authService.logout();
    Get.offAndToNamed('/start');
  }
}