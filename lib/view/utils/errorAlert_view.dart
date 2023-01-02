import 'dart:ui';
import 'package:flutter/material.dart';

class ErrorAlertView extends StatelessWidget {
  const ErrorAlertView({Key? key, required this.description}) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: AlertDialog(
        title: const Text('Błąd'),
        content: description != '' ? Text(description) : const Text('Napotkano błąd'),
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
