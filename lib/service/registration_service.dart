import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/model/registration_request_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;


class RegistrationService{
  final String loginUrl = 'http://10.0.2.2:3001/users/register';

  Future<http.Response> fetchUserRegistration(String email, String password, String firstName, String lastName, String phoneNumber, String sex) async {
    RegistrationRequestModel newUser = RegistrationRequestModel(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      number: phoneNumber,
      sex: sex
    );
    var url = Uri.parse(loginUrl);

    http.Response res = await http.post(url, body: newUser.makeRegistrationRequest());
    return res;
    /*
    if(res.statusCode == HttpStatus.ok) {
      log('dobrze');
      final responseData = jsonDecode(res.body);
      if(responseData['error'] != null) {
        log('jest blad');
        return responseData['error'];
      }
      LoginResponseModel loggedInUser = LoginResponseModel(roleId: responseData['roleId'], token: responseData['token']);
      return loggedInUser;
    } else {
      log('oj');
      return jsonDecode(res.body)['error'];
      return null;
    }*/
  }
}