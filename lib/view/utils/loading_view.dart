import 'package:flutter/material.dart';
import 'dart:ui';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: AlertDialog(
          title: const Text('Ładowanie ...'),
          content: Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 75.0),
            child: const CircularProgressIndicator()
          ),
      ),
    );
  }
}
