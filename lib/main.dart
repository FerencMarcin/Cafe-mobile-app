import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/StartPage.dart';
import 'view/welcome_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'My cafe';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: AppColors.darkGoldenrodMap,
      ),
      home: WelcomeView(),
    );
  }
}
