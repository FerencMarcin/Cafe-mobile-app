import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'start_view.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({Key? key}) : super(key: key);
  final AuthService _authManager = Get.put(AuthService());

  Future<void> init() async {
    _authManager.checkAuthStatus();

    //TODO some other initializations
    await Future.delayed(const Duration(seconds: 3));
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading_view();
        } else {
          if (snapshot.hasError) {
            return error_view(snapshot);
          } else {
            return StartView();
          }
        }
      }
    );
  }

  Scaffold error_view(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(
      body: Center(
        //TODO create better error view
        child: Text('Błąd: ${snapshot.error}'),
      ),
    );
  }

  Scaffold loading_view() {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
            Text('Ładowanie...'),
          ],
        ),
      ),
    );
  }
}
