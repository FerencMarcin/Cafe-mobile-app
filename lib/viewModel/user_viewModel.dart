import 'dart:developer';

import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/login_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/interceptor/dioClient.dart';

class UserViewModel extends GetxController {
  final DioClient _dioClient = Get.put(DioClient());
  late final LoginService _loginService;
  late final AuthService _authService;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authService = Get.put(AuthService());
  }

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
    final response = await _dioClient.dioClient.get('http://10.0.2.2:3001/users/$userId');
    if(response.statusCode == 200) {
      prefs.setInt('userPoints', response.data['points']);
      return response.data['points'].toString();
    } else if (response.statusCode == 403) {
      throw 403;
      log('error 403 wystapil');
      Get.defaultDialog(
              title: 'Sesja wygasła',
              middleText: 'Musisz zalogować się ponownie',
              textConfirm: 'Zaloguj',
              onConfirm: () async {
                Get.back();
                //_authService.logout();
                Get.toNamed('/start');
              }
          );
    }
    return "Wystąpił błąd";
  }

}