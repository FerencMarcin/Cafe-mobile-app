import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/login_service.dart';
import 'package:cafe_mobile_app/view/startViewManager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends GetxController {
  late final LoginService _loginService;
  late final AuthService _authService;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authService = Get.find();
  }

  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return '${prefs.getString('userFirstname')} ${prefs.getString('userLastname')}';
  }

}