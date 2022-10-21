import 'package:flutter/material.dart';

@immutable
class AppColors {
  static const floralWhite = Color(0x00fffaf1);
  static const dutchWhite = Color(0x00edddb8);
  static const burlywood = Color(0x00dcc080);
  static const aztecGold = Color(0x00caa347);
  static const darkGoldenrod = Color(0xb8860e);

  static final Map<int, Color> _darkGoldenrodMap = {
    50: const Color(0x00f3ebd7),
    100: const Color(0x00e7d7af),
    200: const Color(0x00dcc387),
    300: const Color(0x00d0ae5e),
    400: const Color(0x00c49a36),
    500: const Color(0x00b8860e),
  };

  static const MaterialColor myfav = MaterialColor(
      0xffb8860e,
      <int, Color>{
      50: Color(0xf3ebd7),
      100: Color(0xe7d7af),
      200: Color(0xdcc387),
      300: Color(0xd0ae5e),
      400: Color(0xc49a36),
      500: Color(0xb8860e),
      600: Color(0xb8860e),
      700: Color(0xb8860e),
      800: Color(0xb8860e),
      900: Color(0xb8860e),
      },
  );

  static final MaterialColor darkGoldenrodSwatch = MaterialColor(const Color(0x00fffaf1).value, _darkGoldenrodMap);
}