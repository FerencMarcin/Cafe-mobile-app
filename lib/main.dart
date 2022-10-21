import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'StartPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'My cafe';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: AppColors.myfav,
      ),
      home: StartScreen(title: title),
    );
  }
}
