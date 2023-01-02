import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AuthForm {
  static TextFormField emailFormField(TextEditingController controller) {
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
      obscureText: true,
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

  static TextFormField passwordFormFieldValidated(TextEditingController controller) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Hasło',
        labelStyle: TextStyle(
            color: AppColors.darkGoldenrodMap[800]
        ),
        prefixIcon: Icon(Icons.password_outlined, color: AppColors.darkGoldenrodMap[400]),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Należy podać hasło';
        }
        RegExp validPassword = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
        if (validPassword.hasMatch(value)) {
          if(value.length < 8) {
            return 'Hasło musi zawierać przynajmniej 8 znaków';
          }
          return null;
        } else {
          return 'Hasło musi zawierać małe i wielkie litery, cyfry i znaki';
        }
      },
    );
  }

  static TextFormField phoneNumberFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Numer telefonu',
        labelStyle: TextStyle(
            color: AppColors.darkGoldenrodMap[800]
        ),
        prefixIcon: Icon(Icons.phone_outlined, color: AppColors.darkGoldenrodMap[400]),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Należy podać numer telefonu';
        }
        if (value.length != 9) {
          return 'Podaj poprawny numer telefonu (np. 111222333)';
        }
      },
    );
  }

  static TextFormField firstNameFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Imie',
        labelStyle: TextStyle(
            color: AppColors.darkGoldenrodMap[800]
        ),
        prefixIcon: Icon(Icons.contact_page_outlined, color: AppColors.darkGoldenrodMap[400]),
      ),
      validator: (value) {
        return (value == null || value.isEmpty)
            ? 'Należy podać imie'
            : null;
      },
    );
  }

  static TextFormField lastNameFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Nazwisko',
        labelStyle: TextStyle(
            color: AppColors.darkGoldenrodMap[800]
        ),
        prefixIcon: Icon(Icons.contact_page_outlined, color: AppColors.darkGoldenrodMap[400]),
      ),
      validator: (value) {
        return (value == null || value.isEmpty)
            ? 'Należy podać nazwisko'
            : null;
      },
    );
  }




}