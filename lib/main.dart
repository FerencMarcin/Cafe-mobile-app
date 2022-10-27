import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/LoginPage.dart';
import 'package:cafe_mobile_app/view/RegisterPage.dart';
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
        primarySwatch: AppColors.darkGoldenrodMap,
      ),
      home: StartScreen(title: title),
      //home: LoginScreen(title: title),
      //home: RegistrationScreen(),
    );
  }
}
