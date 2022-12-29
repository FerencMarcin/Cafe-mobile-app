import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/view/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewModel/auth_viewModel.dart';
import 'homePage_view.dart';
import 'login_view.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _authManager = Get.find();
    final AuthViewModel _authViewModel = Get.put(AuthViewModel());
    return Obx(() {
      if (_authManager.isLogged.value) {
        return HomePageView();
      } else {
        //return AuthView();
        return WelcomeView();
      }
      return _authManager.isLogged.value ? LoginView() : HomePageView();
    });
  }
}
