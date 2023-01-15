import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/auth_viewModel.dart';

class LogoutAlertView extends StatelessWidget {
  const LogoutAlertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthViewModel _authViewModel = Get.find();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: AlertDialog(
        title: const Text('Sesja wygasła'),
        content: const Text('Twoja sesja wygasła. Musisz zalogować się ponownie'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Zaloguj'),
            onPressed: () {
              Navigator.pop((context));
              _authViewModel.userLogout();
            },
          )
        ]
      ),
    );
  }
}
