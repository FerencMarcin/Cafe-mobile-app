import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../model/registration_request_model.dart';

class RegistrationViewModel {
  final String registerUrl = 'http://10.0.2.2:3001/users/register';

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
      log(responseData.toString());
      throw responseData['error'];
    } else {
      return 'Konto zostało utworzone pomyślnie';
    }
  }
}