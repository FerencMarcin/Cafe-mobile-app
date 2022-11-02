import 'package:cafe_mobile_app/repository/repository.dart';
import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../RegisterPage.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  const LoginForm({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepository;

  _LoginFormState(this.userRepository);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login failed."),
              backgroundColor: AppColors.projectRed,
            )
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Center(
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
                            controller: _emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Adres E-mail',
                            ),
                            autocorrect: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_outlined
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Hasło',
                            ),
                            autocorrect: false,
                            obscureText: true,
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
                        onPressed: _onLoginButtonPressed,
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
          );
        },
      ),
    );
  }
}

