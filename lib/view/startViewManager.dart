import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view.dart';
import 'auth_view.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _authManager = Get.find();

    return Obx(() {
      if (_authManager.isLogged.value) {
        return HomeView();
      } else {
        return AuthView();
      }
      return _authManager.isLogged.value ? AuthView() : HomeView();
    });
  }
}
