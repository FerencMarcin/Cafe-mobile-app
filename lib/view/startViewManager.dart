import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/view/welcome_view.dart';
import 'package:cafe_mobile_app/viewModel/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homePage_view.dart';
import 'auth_view.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AuthService _authManager = Get.find();
    LoginViewModel loginViewModel = Get.put(LoginViewModel());
    return Obx(() {
      if (_authManager.isLogged.value) {
        return HomePageView();
      } else {
        //return AuthView();
        return WelcomeView();
      }
      return _authManager.isLogged.value ? AuthView() : HomePageView();
    });
  }
}
