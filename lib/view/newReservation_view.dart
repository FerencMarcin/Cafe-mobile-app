import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class NewReservationView extends StatefulWidget {
  const NewReservationView({Key? key}) : super(key: key);

  @override
  State<NewReservationView> createState() => _NewReservationViewState();
}

class _NewReservationViewState extends State<NewReservationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Nowa rezerwacja'),
        body: Column(
          children: [
            sectionTitle('Data rezerwacji'),
          ],
        )
    );
  }
}