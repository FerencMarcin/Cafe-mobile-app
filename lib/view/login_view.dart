import 'package:cafe_mobile_app/viewModel/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
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
              ),
              TextFormField(
                controller: passController,
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Należy podać hasło'
                      : null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: ElevatedButton(
                        onPressed: () {Navigator.pop(context);},
                        child: const Text('Anuluj')
                    ),
                  ),
                  ElevatedButton(
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
                      child: const Text('Zaloguj')
                  ),
                ],
              ),

              TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/resetPassword');
                  },
                  child: const Text('Nie pamiętam hasła?')
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Nie masz jeszcze konta?"),
                  TextButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/registration');
                      },
                      child: const Text('Zarejestruj się')
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
}
