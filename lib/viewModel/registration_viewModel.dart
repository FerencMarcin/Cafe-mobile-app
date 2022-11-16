import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/model/login_request_model.dart';
import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/login_service.dart';
import 'package:cafe_mobile_app/service/registration_service.dart';
import 'package:get/get.dart';

import '../model/login_response_model.dart';

class RegistrationViewModel extends GetxController {
  late final RegistrationService _registrationService;
  late final LoginService _loginService;
  late final AuthService _authService;

  @override
  void onInit() {
    super.onInit();
    _registrationService = Get.put(RegistrationService());
    _loginService = Get.put(LoginService());
    _authService = Get.find();
  }

  Future<void> userRegistration(String email, String password, String firstName, String lastName, String number, String sex) async {
    final response = await _registrationService.fetchUserRegistration(email, password, firstName, lastName, number, sex);
    log('res:  $response'); //TODO delete this line

    if (response != null) {
      final responseData = jsonDecode(response);
      if(responseData != "A new user account has been created.") {
        Get.defaultDialog(
            title: 'Błąd rejestracji',
            middleText: responseData['error'],
            textConfirm: 'Wróć',
            onConfirm: () {
              Get.back();
            }
        );
      } else {
        Get.defaultDialog(
            title: 'Utworzono nowe konto',
            middleText: 'Twoje konto zostało utworzone',
            textConfirm: 'Przejdź do aplikacji',
            onConfirm: () async {
              final loginResponse = await _loginService.fetchUserLogin(email, password);
              if (loginResponse != null) {
                final loginResponseData = jsonDecode(loginResponse);
                log('login after register res: $loginResponseData');
                if(loginResponseData['error'] != null) {
                  Get.defaultDialog(
                      title: 'Błąd logowania, spróbuj ponownie',
                      middleText: loginResponseData['error'],
                      textConfirm: 'Wróć',
                      onConfirm: () {
                        Get.back();
                      }
                  );
                } else {
                  _authService.login(loginResponseData['accessToken']);
                }
              } else {
                Get.defaultDialog(
                    middleText: 'Niepoprawne dane',
                    textConfirm: 'Wróć',
                    onConfirm: () {
                      Get.back();
                    }
                );
              }
              Get.back();
            }
        );

      }
    } else {
      Get.defaultDialog(
          middleText: 'Niepoprawne dane',
          textConfirm: 'Wróć',
          onConfirm: () {
            Get.back();
          }
      );
    }
  }
}