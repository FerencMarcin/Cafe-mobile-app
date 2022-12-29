import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/login_request_model.dart';
import '../model/registration_request_model.dart';

class AuthViewModel extends GetxController {
  final AuthService _authService = Get.find();

  final String loginUrl = '${dotenv.env['BASE_URL']!}/users/login';
  final String registerUrl = '${dotenv.env['BASE_URL']!}/users/register';
  final String resetPasswordRequestUrl = '${dotenv.env['BASE_URL']!}/auth/requestpasswordreset';
  final String resetPasswordUrl = '${dotenv.env['BASE_URL']!}/auth/resetpassword';

  Future<void> userLogin(String email, String password) async {
    LoginRequestModel user = LoginRequestModel(email: email, password: password);
    var url = Uri.parse(loginUrl);

    final http.Response response = await http.post(url, body: user.makeLoginRequest());
    final responseData = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw responseData['error'];
    } else {
      _authService.saveRefreshToken(response);
      _authService.login(responseData['accessToken']);
    }
  }

  Future<String> userRegistration(String email, String password, String firstName, String lastName, String number, String sex) async {
    RegistrationRequestModel newUser = RegistrationRequestModel(
        email: email,
        password: password,
        firstname: firstName,
        lastname: lastName,
        phoneNumber: number,
        sex: sex
    );
    var url = Uri.parse(registerUrl);
    final http.Response response = await http.post(url, body: newUser.makeRegistrationRequest());
    final responseData = jsonDecode(response.body);
    if(response.statusCode != 200) {
      throw responseData['error'];
    } else {
      return 'Konto zostało utworzone pomyślnie';
    }
  }

  Future<dynamic> resetPassword(String email) async {
    var url = Uri.parse(resetPasswordRequestUrl);
    final http.Response response = await http.post(url, body: {"email": email});
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<String> changePassword(String resetCode, String email, String password) async {
    var url = Uri.parse(resetPasswordUrl);
    final http.Response response = await http.post(url,
      body: {
        "password": password,
        "email": email,
        "resetCode": resetCode
      }
    );
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