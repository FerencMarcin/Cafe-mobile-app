import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/view/utils/error_view.dart';
import 'package:cafe_mobile_app/view/utils/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'startViewManager.dart';

class InitialView extends StatelessWidget {
  InitialView({Key? key}) : super(key: key);
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
          return LoadingView();
        } else {
          if (snapshot.hasError) {
            return ErrorView(snapshot: snapshot);
          } else {
            return StartView();
          }
        }
      }
    );
  }

  //TODO zobaczyć czy działa i usunąć
  Scaffold error_view(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(
      body: Center(
        child: Text('Błąd: ${snapshot.error}'),
      ),
    );
  }
}
