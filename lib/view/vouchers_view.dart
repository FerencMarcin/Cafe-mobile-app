import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';

class VouchersView extends StatefulWidget {
  const VouchersView({Key? key}) : super(key: key);

  @override
  State<VouchersView> createState() => _VouchersViewState();
}

class _VouchersViewState extends State<VouchersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Talony'),
        body: Container(
          child: Text("Talony"),
        )
    );
  }
}
