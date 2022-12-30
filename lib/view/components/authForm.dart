import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AuthForm {
  static TextFormField emailInputFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
        labelText: 'Adres e-mail',
        labelStyle: TextStyle(
            color: AppColors.darkGoldenrodMap[800]
        ),
        prefixIcon: Icon(Icons.person_outline, color: AppColors.darkGoldenrodMap[400]),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Należy podać adres email';
        }
        if(EmailValidator.validate(value)) {
          return null;
        } else {
          return 'Podaj poprawny adres email';
        }
      },
    );
  }

  static TextFormField passwordFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Hasło',
        labelStyle: TextStyle(
            color: AppColors.darkGoldenrodMap[800]
        ),
        prefixIcon: Icon(Icons.password_outlined, color: AppColors.darkGoldenrodMap[400]),
      ),
      validator: (value) {
        return (value == null || value.isEmpty)
            ? 'Należy podać hasło'
            : null;
      },
    );
  }




}