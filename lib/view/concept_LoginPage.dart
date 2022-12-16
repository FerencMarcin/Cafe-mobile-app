import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/concept_RegisterPage.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Logowanie'),),
      body: Center(
        child: Column(
          children: <Widget>[
            const Spacer(),
            const Expanded(
              flex: 1,
              child: Text("Logo")
            ),
            Expanded(
              flex: 3,
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 50),
                      child: Text(
                        "Logowanie",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGoldenrod,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wprowadź adres e-mail';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adres E-mail',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wprowadź hasło';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Hasło',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(AppColors.projectRed),
                      minimumSize: MaterialStatePropertyAll(Size(120,40)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Anuluj', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(AppColors.aztecGold),
                      minimumSize: MaterialStatePropertyAll(Size(120,40)),
                    ),
                    onPressed: () {
                      if (_loginFormKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logowanie...')),
                        );
                      }
                    },
                    child: const Text('Zaloguj', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
            Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 3,right: 5),
                  child: const Text("Nie masz jeszcze konta?"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationScreen())
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: AppColors.darkGoldenrod,
                          width: 1.0,
                        ))
                    ),
                    child: const Text(
                      "Zarejestruj się!",
                      style: TextStyle(color: AppColors.projectDarkBlue, fontWeight: FontWeight.bold),
                    ),
                  )
                ),
              ],
            )
          ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}