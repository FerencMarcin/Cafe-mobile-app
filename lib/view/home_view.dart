import 'package:cafe_mobile_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';

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
      drawer: Drawer(
        backgroundColor: AppColors.floralWhite,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.darkGoldenrodMap[700],
              ),
              child: Text(
                'Hej ...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('Strona główna'),
            ),
            ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text('O nas'),
            ),
            ListTile(
              leading: Icon(Icons.menu_book_outlined),
              title: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.local_offer_outlined),
              title: Text('Oferty specjalne'),
            ),
            Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: Icon(Icons.list_alt_outlined),
              title: Text('Moje zamówienia'),
            ),
            ListTile(
              leading: Icon(Icons.qr_code_2_outlined),
              title: Text('Talony'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Divider(
                color: Colors.black54,
              )
            ),
            ListTile(
              leading: Icon(Icons.person_outline_rounded),
              title: Text('Moje konto'),
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Wyloguj się'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Ekran głowny')
      ),
    );
  }
}