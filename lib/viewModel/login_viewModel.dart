import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/model/login_request_model.dart';
import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/login_service.dart';
import 'package:get/get.dart';

import '../model/login_response_model.dart';

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
    log('res:  $response');

    if (response != null) {
      final responseData = jsonDecode(response);
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
        _authService.login(responseData['accessToken']);
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
}