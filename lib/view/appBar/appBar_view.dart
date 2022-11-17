import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/login_viewModel.dart';

class AppBarView extends StatelessWidget with PreferredSizeWidget{
  AppBarView({Key? key, required this.appBarTitle}) : super(key: key);
  final LoginViewModel _loginViewModel = Get.find();
  final String appBarTitle;

  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(appBarTitle),
    actions: [
      IconButton(
          onPressed: (){
            _loginViewModel.userLogout();
          },
          icon: Icon(Icons.logout_outlined))
    ],
  );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}