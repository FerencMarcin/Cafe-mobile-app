import 'package:cafe_mobile_app/viewModel/login_viewModel.dart';
import 'package:cafe_mobile_app/viewModel/registration_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'appBar/appBar_view.dart';

enum AuthMode {login, register}
const List<String> sexList = <String>["Mężczyzna", "Kobieta"];

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  final LoginViewModel _loginViewModel = Get.put(LoginViewModel());
  final RegistrationViewModel _registrationViewModel = Get.put(RegistrationViewModel());

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String selectedSex = sexList.first;
  AuthMode _formType = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(appBarTitle: _formType == AuthMode.login ? 'Logowanie' : 'Rejestracja'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: _formType == AuthMode.login ? loginForm() : registrationForm(),
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
          ),
          TextButton(
            onPressed: () async {
              setState(() {
                _formType = AuthMode.register;
              });
            },
            child: Text('Zarejestruj się')
          )
        ],
      ),
    );
  }

  Form registrationForm(){
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Adres email',
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Należy podać adres email'
                  : null;
            },
          ),
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              labelText: 'Imie',
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Należy podać imie'
                  : null;
            },
          ),
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(
              labelText: 'Nazwisko',
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Należy podać nazwisko'
                  : null;
            },
          ),
          TextFormField(
            controller: numberController,
            decoration: const InputDecoration(
              labelText: 'Numer telefonu',
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Należy podać numer telefonu'
                  : null;
            },
          ),
          TextFormField(
            controller: passController,
            decoration: const InputDecoration(
              labelText: 'Hasło',
            ),
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Należy podać hasło'
                  : null;
            },
          ),
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
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await _registrationViewModel.userRegistration(
                    emailController.text.trim(),
                    passController.text,
                    firstNameController.text,
                    lastNameController.text,
                    numberController.text,
                    selectedSex);
                }
              },
              child: Text('Zarejestruj')
          ),
          TextButton(
              onPressed: () async {
                setState(() {
                  _formType = AuthMode.login;
                });
              },
              child: Text('Zaloguj się')
          )
        ],
      ),
    );
  }
}
