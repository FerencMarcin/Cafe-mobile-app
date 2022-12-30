import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/interceptor/dioClient.dart';

class UserViewModel extends GetxController {
  final DioClient _dioClient = Get.put(DioClient());

  final String userInfoUrl = '${dotenv.env['BASE_URL']!}/users';
  //TODO delete death code
  // late final LoginService _loginService;
  // late final AuthService _authService;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   _loginService = Get.put(LoginService());
  //   _authService = Get.put(AuthService());
  // }

  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return '${prefs.getString('userFirstname')} ${prefs.getString('userLastname')}';
  }

  Future<String> getUserPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if(userId == null) {
      return "Wystąpił błąd";
    }
    final response = await _dioClient.dioClient.get('$userInfoUrl/$userId');
    if(response.statusCode == 200) {
      prefs.setInt('userPoints', response.data['points']);
      return response.data['points'].toString();
    } else if (response.statusCode == 403) {
      throw 403;
    }
    return "Wystąpił błąd";
  }

}