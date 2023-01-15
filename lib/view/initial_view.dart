import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/view/utils/errorAlert_view.dart';
import 'package:cafe_mobile_app/view/utils/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'startViewManager.dart';

class InitialView extends StatelessWidget {
  InitialView({Key? key}) : super(key: key);
  final AuthService _authManager = Get.put(AuthService());

  Future<void> init() async { _authManager.checkAuthStatus(); }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        } else {
          if (snapshot.hasError) {
            return ErrorAlertView(description: snapshot.error.toString());
          } else {
            return const StartView();
          }
        }
      }
    );
  }
}
