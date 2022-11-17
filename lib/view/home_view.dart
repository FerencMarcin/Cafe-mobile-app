import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'appBar/appBar_view.dart';
import 'navigation/navigationDrawer_view.dart';

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
      appBar: AppBarView(appBarTitle: 'Strona główna'),
      drawer: NavigationDrawer(),
      body: Center(
        child: Text('Ekran głowny')
      ),
    );
  }
}