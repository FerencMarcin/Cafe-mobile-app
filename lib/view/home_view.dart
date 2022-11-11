import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthService _authManager = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu głowne'),
        actions: [
          IconButton(
            onPressed: (){
              _authManager.logout();
            },
            icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Text('Ekran głowny')
      ),
    );
  }
}