import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/auth_service.dart';
import '../../theme/colors.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  final AuthService _authManager = Get.find();

  final TextStyle selectedRouteStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w900,
    color: AppColors.darkGoldenrod
  );

  final TextStyle unselectedRouteStyle = const TextStyle(
      fontSize: 16,
  );

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
        leading:
          (Get.currentRoute == '/home') ?
          Icon(Icons.home_outlined, color: AppColors.darkGoldenrodMap[600], size: 35,)
          : const Icon(Icons.home_outlined, size: 32),
        title:
          (Get.currentRoute == '/home') ?
          Text('Strona główna', style: selectedRouteStyle)
          : Text('Strona główna', style: unselectedRouteStyle),
        onTap: () => {if (Get.currentRoute != '/home') Get.offAllNamed('/home')}
      ),
      ListTile(
        leading: Icon(Icons.info_outline_rounded),
        title:
          (Get.currentRoute == '/aboutus') ?
          Text('O nas', style: selectedRouteStyle)
          : Text('O nas', style: unselectedRouteStyle),
      ),
      ListTile(
        leading: Icon(Icons.menu_book_outlined),
        title:
          (Get.currentRoute == '/menu') ?
          Text('Menu', style: selectedRouteStyle)
          : Text('Menu', style: unselectedRouteStyle),
        onTap: () => Get.offAllNamed('/menu'),
      ),
      ListTile(
        leading: Icon(Icons.local_offer_outlined),
        title:
          (Get.currentRoute == '/specialoffers') ?
          Text('Oferty specjalne', style: selectedRouteStyle)
          : Text('Oferty specjalne', style: unselectedRouteStyle),
      ),
      const Divider(
        color: Colors.black54,
      ),
      ListTile(
        leading: Icon(Icons.list_alt_outlined),
        title:
          (Get.currentRoute == '/myorders') ?
          Text('Moje zamówienia', style: selectedRouteStyle)
          : Text('Moje zamówienia', style: unselectedRouteStyle),
      ),
      ListTile(
        leading: Icon(Icons.qr_code_2_outlined),
        title:
          (Get.currentRoute == '/codes') ?
          Text('Talony', style: selectedRouteStyle)
          : Text('Talony', style: unselectedRouteStyle),
      ),
      const Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: Divider(
            color: Colors.black54,
          )
      ),
      ListTile(
        leading: const Icon(Icons.person_outline_rounded),
        title:
          (Get.currentRoute == '/profile') ?
          Text('Moje konto', style: selectedRouteStyle)
          : Text('Moje konto', style: unselectedRouteStyle),
      ),
      ListTile(
        leading: const Icon(Icons.logout_outlined, size: 32),
        title: Text('Wyloguj się', style: unselectedRouteStyle),
        onTap: () => _authManager.logout(),
      ),
    ],
  );
}
