import 'package:cafe_mobile_app/bloc/auth_bloc/auth.dart';
import 'package:cafe_mobile_app/bloc/login_bloc/login_bloc.dart';
import 'package:cafe_mobile_app/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginForm.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;
  LoginPage({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            userRepository: userRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)
          );
        },
        child: LoginForm(userRepository: userRepository),
      ),
    );
  }
}
