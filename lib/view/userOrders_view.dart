import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';

class UserOrdersView extends StatefulWidget {
  const UserOrdersView({Key? key}) : super(key: key);

  @override
  State<UserOrdersView> createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends State<UserOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Moje zamówienia'),
        body: Container(
          child: Text("zamówienia"),
        )
    );
  }
}
