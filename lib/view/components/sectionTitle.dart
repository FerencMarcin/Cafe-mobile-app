import 'package:flutter/material.dart';

import '../../theme/colors.dart';

Padding sectionTitle(String title) {
  return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(title, style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w800,
          color: AppColors.darkGoldenrodMap[900]))
  );
}