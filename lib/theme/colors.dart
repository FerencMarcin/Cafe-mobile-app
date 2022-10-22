import 'package:flutter/material.dart';

@immutable
class AppColors {
  static const floralWhite = Color(0xfffffaf1);
  static const dutchWhite = Color(0xffedddb8);
  static const burlyWood = Color(0xffdcc080);
  static const aztecGold = Color(0xffcaa347);
  static const darkGoldenrod = Color(0xffb8860e);

  static const projectRed = Color(0xffeb3b5a);
  static const projectGreen = Color(0xff20bf6b);
  static const projectYellow = Color(0xfff7b731);
  static const projectLightBlue = Color(0xff45aaf2);
  static const projectDarkBlue = Color(0xff2d98da);

  static const MaterialColor darkGoldenrodMap = MaterialColor(
      0xffb8860e,
      <int, Color>{
      50: Color(0xffF5EEDD),
      100: Color(0xffEBDCBA),
      200: Color(0xffE1CB98),
      300: Color(0xffD6BA75),
      400: Color(0xffCCA953),
      500: Color(0xffC29730),
      600: Color(0xffb8860e),
      700: Color(0xff99700C),
      800: Color(0xff7B5909),
      900: Color(0xff5C4307),
      },
  );
}