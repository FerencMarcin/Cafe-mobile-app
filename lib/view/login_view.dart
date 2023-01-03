import 'package:cafe_mobile_app/viewModel/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'clipper/imageBorderClip.dart';
import 'components/authForm.dart';
import 'components/sectionTitle.dart';

const List<String> sexList = <String>["Mężczyzna", "Kobieta"];

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final AuthViewModel _authViewModel = Get.put(AuthViewModel());

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
                    height: 260.0,
                  ),
                ),
                ClipPath(
                  clipper: ImageBorderClip(),
                  child: Container(
                    height: 240.0,
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
              child: sectionTitle('Logowanie')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(
                  children: [
                    AuthForm.emailFormField(emailController),
                    AuthForm.passwordFormField(passController, 'Hasło'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {Navigator.pop(context);},
                        child: Text('Anuluj', style: buttonTextStyle)
                    ),
                  ),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
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
                      },
                      child: Text('Zaloguj', style: buttonTextStyle)
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/resetPassword');
                },
                child: Text('Nie pamiętam hasła?', style: textButtonLabelStyle)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nie masz jeszcze konta?", style: textStyle),
                TextButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/registration');
                    },
                    child: Text('Zarejestruj się', style: textButtonLabelStyle)
                )
              ],
            )
          ],
        ),
      ),
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
}
