import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/auth_service.dart';
import '../../theme/colors.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  final AuthService _authManager = Get.find();

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: AppColors.floralWhite,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          navHeader(context),
          navItems(context),
        ],
      ),
    ),
  );

  Widget navHeader(BuildContext context) => Container(
    color: AppColors.darkGoldenrodMap[700],
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top
      ),
      child: Column(
        children: const [
          Icon(
            Icons.account_circle_outlined,
            size: 80,
            color: AppColors.floralWhite,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "imie i nazwisko",
              style: TextStyle(fontSize: 20, color: AppColors.floralWhite),
            ),
          ),
        ],
      )
  );

  Widget navItems(BuildContext context) => Wrap(
    runSpacing: 10,
    children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Strona główna'),
        onTap: () => Get.offAllNamed('/home'),
      ),
      const ListTile(
        leading: Icon(Icons.info_outline_rounded),
        title: Text('O nas'),
      ),
      const ListTile(
        leading: Icon(Icons.menu_book_outlined),
        title: Text('Menu'),
      ),
      const ListTile(
        leading: Icon(Icons.local_offer_outlined),
        title: Text('Oferty specjalne'),
      ),
      const Divider(
        color: Colors.black54,
      ),
      const ListTile(
        leading: Icon(Icons.list_alt_outlined),
        title: Text('Moje zamówienia'),
      ),
      const ListTile(
        leading: Icon(Icons.qr_code_2_outlined),
        title: Text('Talony'),
      ),
      const Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: Divider(
            color: Colors.black54,
          )
      ),
      const ListTile(
        leading: Icon(Icons.person_outline_rounded),
        title: Text('Moje konto'),
      ),
      ListTile(
        leading: const Icon(Icons.logout_outlined),
        title: const Text('Wyloguj się'),
        onTap: () => _authManager.logout(),
      ),
    ],
  );
}
