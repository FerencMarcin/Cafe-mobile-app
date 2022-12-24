import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/login_service.dart';
import 'package:cafe_mobile_app/view/startViewManager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends GetxController {
  late final LoginService _loginService;
  late final AuthService _authService;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authService = Get.find();
  }

  Future<void> userLogin(String email, String password) async {
    final response = await _loginService.fetchUserLogin(email, password);
    //Todo delete
    log('res:  ${response.body}');

    if (response != null) {
      final responseData = jsonDecode(response.body);
      if(responseData['error'] != null) {
        Get.defaultDialog(
            title: 'Błąd logowania',
            middleText: responseData['error'],
            textConfirm: 'Wróć',
            onConfirm: () {
              Get.back();
            }
        );
      } else {
        //LoginResponseModel loggedInUser = LoginResponseModel(roleId: responseData['roleId'], token: responseData['token']);

        _authService.saveRefreshToken(response);
        _authService.login(responseData['accessToken']);
        Get.to(() => const StartView());
      }
    } else {
      Get.defaultDialog(
        middleText: 'Niepoprawne dane logowania',
        textConfirm: 'Wróć',
        onConfirm: () {
          Get.back();
        }
      );
    }
  }

  Future<dynamic> resetPassword(String email) async {
    final String resetPasswordUrl = 'http://10.0.2.2:3001/auth/requestpasswordreset';
    var url = Uri.parse(resetPasswordUrl);
    final http.Response response = await http.post(url, body: {"email": email});
    log(response.body.toString());
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<String> changePassword(String resetCode, String email, String password) async {
    final String resetPasswordUrl = 'http://10.0.2.2:3001/auth//resetpassword';
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