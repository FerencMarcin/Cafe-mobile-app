import 'dart:developer';

import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:cafe_mobile_app/service/tokenInterceprot_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';
import 'navigation/navigationDrawer_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  AuthService _authManager = Get.find();
  DioClient _test = Get.put(DioClient());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(appBarTitle: 'Strona główna'),
      drawer: NavigationDrawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await _test.dioC.get('http://10.0.2.2:3001/users/email/klient@gmail.com');
          //TODO refactor
          log("clicked");
        }, child: Text("ekran głowny"),)
      ),
    );
  }
}