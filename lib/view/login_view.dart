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
      appBar: AppBarView(appBarTitle: 'Logowanie'),
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
              TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/registration');
                  },
                  child: Text('Zarejestruj się')
              )
            ],
          ),
        ),
      ),
    );
  }
}
