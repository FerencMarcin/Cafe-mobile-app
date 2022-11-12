import 'package:cafe_mobile_app/viewModel/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthMode {login, register}

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  final LoginViewModel _loginViewModel = Get.put(LoginViewModel());

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final AuthMode _formType = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: _formType == AuthMode.login ? loginForm() : registerForm(),
      ),
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
          )
        ],
      ),
    );
  }

  Form registerForm(){
    return Form(
      child: Column(),
    );
  }
}
