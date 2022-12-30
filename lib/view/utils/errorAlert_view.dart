import 'dart:ui';
import 'package:flutter/material.dart';

class ErrorAlertView extends StatelessWidget {
  const ErrorAlertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: AlertDialog(
        title: const Text('Błąd'),
        content: const Text('Napotkano błąd'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Wróć'),
            onPressed: () {
              Navigator.pop((context));
              Navigator.pushNamed(context, '/start');
            },
          )
        ]
      ),
    );
  }
}
