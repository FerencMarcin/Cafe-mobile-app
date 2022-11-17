import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/auth_service.dart';
import 'navigation/navigationDrawer_view.dart';

class ProductsView extends StatelessWidget {
  ProductsView({Key? key}) : super(key: key);
  final AuthService _authManager = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
              onPressed: (){
                _authManager.logout();
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      drawer: NavigationDrawer(),
      body: Center(
          child: Text('Tu będzie menu')
      ),
    );
  }
}
