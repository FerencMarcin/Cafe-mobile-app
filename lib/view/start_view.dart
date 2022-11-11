import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value ? HomeView() : LoginView();
    });
  }
}
