import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class UserReservationsView extends StatefulWidget {
  const UserReservationsView({Key? key}) : super(key: key);

  @override
  State<UserReservationsView> createState() => _UserReservationsViewState();
}

class _UserReservationsViewState extends State<UserReservationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Rezerwacje'),
        body: Column(
          children: [
            sectionTitle('Rezerwacja'),
          ],
        )
    );
  }
}