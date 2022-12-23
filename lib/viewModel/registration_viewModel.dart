import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/login_service.dart';
//import 'package:cafe_mobile_app/service/registration_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/registration_request_model.dart';
import '../view/startViewManager.dart';

class RegistrationViewModel extends GetxController {
  //late final RegistrationService _registrationService;
  late final LoginService _loginService;
  late final AuthService _authService;

  @override
  void onInit() {
    super.onInit();
    //_registrationService = Get.put(RegistrationService());
    _loginService = Get.put(LoginService());
    _authService = Get.find();
  }
  final String registerUrl = 'http://10.0.2.2:3001/users/register';

  Future<void> userRegistration(String email, String password, String firstName, String lastName, String number, String sex) async {
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
    //final response = await _registrationService.fetchUserRegistration(email, password, firstName, lastName, number, sex);
    if (response != null) {
      final responseData = jsonDecode(response.body);
      if(response.statusCode != 200) {
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
                final loginResponseData = jsonDecode(loginResponse.body);
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
                  var cookies = loginResponse.headers['set-cookie'];
                  log(cookies!);
                  _authService.saveRefreshToken(loginResponse);
                  _authService.login(loginResponseData['accessToken']);
                  Get.to(() => const StartView());
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