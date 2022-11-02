import 'package:bloc/bloc.dart';
import 'package:cafe_mobile_app/HomePage.dart';
import 'package:cafe_mobile_app/bloc/auth_bloc/auth.dart';
import 'package:cafe_mobile_app/repository/repository.dart';
import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/LoginPage.dart';
import 'package:cafe_mobile_app/view/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'StartPage.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace){
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    )
  );
}

class MyApp extends StatelessWidget {
  final String title = 'My cafe';
  final UserRepository userRepository;

  MyApp({Key? key, required this.userRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: AppColors.darkGoldenrodMap,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomeScreen(title: title);
          }
          if (state is AuthenticationUnauthenticated) {
            return StartScreen(title: title, userRepository: userRepository,);
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
              body: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.projectDarkBlue),
                        strokeWidth: 4.0,
                      ),
                    )
                  ],

                ),
              ),
            );
          }
          return Scaffold(
            body: Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.projectDarkBlue),
                      strokeWidth: 4.0,
                    ),
                  )
                ],

              ),
            ),
          );

        }
      )
    );
  }
}
