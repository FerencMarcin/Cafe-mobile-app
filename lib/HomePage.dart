import 'package:cafe_mobile_app/bloc/auth_bloc/auth.dart';
import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGoldenrod,
        title: Text("Witaj w aplikacji!"),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
            icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Text("Ekran główny po zalogowaniu"),
      ),
    );
  }
}