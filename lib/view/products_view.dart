import 'package:cafe_mobile_app/viewModel/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/auth_service.dart';
import 'appBar/appBar_view.dart';
import 'navigation/navigationDrawer_view.dart';

class ProductsView extends StatelessWidget {
  ProductsView({Key? key}) : super(key: key);
  final LoginViewModel _loginViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(appBarTitle: 'Menu'),
      body: Center(
          child: Text('Tu będzie menu')
      ),
    );
  }
}
