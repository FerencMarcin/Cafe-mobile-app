import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import '../viewModel/auth_viewModel.dart';
import 'clipper/imageBorderClip.dart';
import 'components/authForm.dart';
import 'components/sectionTitle.dart';

const List<String> sexList = <String>["Mężczyzna", "Kobieta"];

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final AuthViewModel _authViewModel = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String selectedSex = sexList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper:ImageBorderClip(), //set our custom wave clipper
                  child:Container(
                    color: AppColors.burlyWood,
                    height: 160.0,
                  ),
                ),
                ClipPath(
                  clipper: ImageBorderClip(),
                  child: Container(
                    height: 140.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage("images/initPageImage.jpg"),
                          colorFilter: ColorFilter.mode(AppColors.photoFilter, BlendMode.modulate),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: sectionTitle('Rejestracja')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(
                  children: [
                    AuthForm.emailFormField(emailController),
                    AuthForm.firstNameFormField(firstNameController),
                    AuthForm.lastNameFormField(lastNameController),
                    AuthForm.phoneNumberFormField(numberController),
                    AuthForm.passwordFormFieldValidated(passController, 'Hasło'),
                    DropdownButton<String>(
                      value: selectedSex,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: AppColors.darkGoldenrod),
                      underline: Container(
                        height: 2,
                        color: AppColors.darkGoldenrodMap.shade900,
                      ),
                      onChanged: (String? newValue) {
                        setState(() => selectedSex = newValue!);
                      },
                      isExpanded: true,
                      items: sexList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () { Navigator.pop(context); },
                      child: Text('Anuluj', style: buttonTextStyle)
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            final response = await _authViewModel
                                .userRegistration(
                                emailController.text.trim(),
                                passController.text,
                                firstNameController.text,
                                lastNameController.text,
                                numberController.text,
                                selectedSex);
                            showSuccessGetDialog('Utworzono nowe konto', response, 'Przejdź do aplikacji');
                          } catch (exception) {
                            showErrorGetDialog('$exception');
                          }
                        }
                      },
                      child: Text('Zarejestruj', style: buttonTextStyle)
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Masz już konto?", style: textStyle),
                TextButton(
                    onPressed: () async {
                      if(Get.previousRoute == '/login') {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: Text('Zaloguj się', style: textButtonLabelStyle)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSuccessGetDialog(String title, String content, String buttonLabel) {
    Get.defaultDialog(
        title: title,
        middleText: content,
        textConfirm: buttonLabel,
        onConfirm: () async {
          try {
            await _authViewModel.userLogin(
                emailController.text.trim(),
                passController.text
            );
            if (!mounted) return;
            Navigator.pushNamed(context, '/start');
          } catch (exception) {
            showErrorGetDialog('$exception');
          }
        }
    );
  }

  void showErrorGetDialog(String content) {
    Get.defaultDialog(
        title: 'Wystąpił błąd',
        middleText: content,
        textConfirm: 'Wróć',
        onConfirm: () {
          Get.back();
        }
    );
  }

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(100.0, 40.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 5.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );

  final TextStyle buttonTextStyle = TextStyle(
      color: AppColors.darkGoldenrodMap[900],
      fontWeight: FontWeight.bold,
      fontSize: 17.0
  );

  final TextStyle textStyle = TextStyle(
      color: AppColors.darkGoldenrodMap[900],
      fontSize: 16.0
  );

  final TextStyle textButtonLabelStyle = TextStyle(
      color: AppColors.darkGoldenrodMap[700],
      fontSize: 17.0,
      fontWeight: FontWeight.bold
  );
}
