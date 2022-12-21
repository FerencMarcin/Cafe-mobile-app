import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';

class UserVouchersView extends StatefulWidget {
  const UserVouchersView({Key? key}) : super(key: key);

  @override
  State<UserVouchersView> createState() => _UserVouchersViewState();
}

class _UserVouchersViewState extends State<UserVouchersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(appBarTitle: 'Moje talony'),
      body: Container(
        child: Text("Talony użytkownika"),
      )
    );
  }
}
