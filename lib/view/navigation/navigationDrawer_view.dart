import 'package:cafe_mobile_app/viewModel/user_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/auth_service.dart';
import '../../theme/colors.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  final AuthService _authManager = Get.find();
  final UserViewModel _userViewModel = Get.put(UserViewModel());

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
    color: AppColors.darkGoldenrodMap[300],
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top
      ),
      child: Column(
        children: [
          const Icon(
            Icons.account_circle_outlined,
            size: 80, color: AppColors.floralWhite,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder(
                future: _userViewModel.getUsername(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data==null ? 'brak danych' : snapshot.data!,
                      style: TextStyle(fontSize: 20.0, color: AppColors.floralWhiteMap[100]),
                    );
                  } else {
                    return const Text('Ładowanie...',
                      style: TextStyle(fontSize: 20.0, color: AppColors.floralWhite),
                    );
                  }
                }
            )
          ),
        ],
      )
  );

  ListTile sideMenuItem(String route, String label, Icon labelIcon, BuildContext context) {
    return ListTile(
      leading: labelIcon,
      title: Text(label, style: unselectedRouteStyle),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }

  Widget navItems(BuildContext context) => Wrap(
    runSpacing: 10.0,
    children: [
      ListTile(
        leading:
          (Get.currentRoute == '/home') ?
          Icon(Icons.home_outlined, color: AppColors.darkGoldenrodMap[600], size: 35.0,)
          : const Icon(Icons.home_outlined, size: 32.0),
        title:
          (Get.currentRoute == '/home') ?
          Text('Strona główna', style: selectedRouteStyle)
          : Text('Strona główna', style: unselectedRouteStyle),
        onTap: () => {
          if (Get.currentRoute != '/home') {
            Navigator.pushNamed(context, '/home')
          }
        }
      ),
      sideMenuItem('/aboutUs', 'O nas', const Icon(Icons.info_outline_rounded), context),
      sideMenuItem('/menu', 'Menu', const Icon(Icons.menu_book_outlined), context),
      sideMenuItem('/vouchers', 'Talony', const Icon(Icons.local_offer_outlined), context),
      const Divider(color: Colors.black54),
      sideMenuItem('/userOrders', 'Moje zamówienia', const Icon(Icons.list_alt_outlined), context),
      ListTile(
        leading: const Icon(Icons.table_restaurant_outlined),
        title: DropdownButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 1,
          value: 'Moje rezerwacje',
          items: const [
            DropdownMenuItem(value: 'Moje rezerwacje', child: Text('Moje rezerwacje')),
            DropdownMenuItem(value: 'Nowa rezerwacja', child: Text('Nowa rezerwacja'))
          ],
          onChanged: (value) {
            value == 'Moje rezerwacje' ? Navigator.pushNamed(context, '/userReservations')
                : Navigator.pushNamed(context, '/newReservation');
          },
        ),
      ),
      sideMenuItem('/userVouchers', 'Moje talony', const Icon(Icons.qr_code_2_outlined), context),
      const Divider(color: Colors.black54),
      sideMenuItem('/userProfile', 'Moje konto', const Icon(Icons.person_outline_rounded), context),
      ListTile(
        leading: const Icon(Icons.logout_outlined, size: 32.0),
        title: Text('Wyloguj się', style: unselectedRouteStyle),
        onTap: () => _authManager.logout(),
      ),
    ],
  );
}
