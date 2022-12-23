import 'package:cafe_mobile_app/viewModel/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';

const List<String> sexList = <String>["Mężczyzna", "Kobieta"];

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final LoginViewModel _loginViewModel = Get.put(LoginViewModel());

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Należy podać adres email'
                      : null;
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
                  ElevatedButton(
                      onPressed: ()  {
                        Navigator.pop(context);
                      },
                      child: Text('Anuluj')
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await _loginViewModel.userLogin(
                              emailController.text.trim(),
                              passController.text
                          );
                        }
                      },
                      child: Text('Zaloguj')
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Nie masz jeszcze konta?"),
                  TextButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/registration');
                      },
                      child: Text('Zarejestruj się')
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
