import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/auth_viewModel.dart';

class AppBarView extends StatelessWidget with PreferredSizeWidget{
  AppBarView({Key? key, required this.appBarTitle}) : super(key: key);
  final AuthViewModel _authViewModel = Get.find();
  final String appBarTitle;

  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(appBarTitle),
    actions: [
      Get.previousRoute != '/unauthenticated' ? IconButton(
          onPressed: (){
            _authViewModel.userLogout();
          },
          icon: const Icon(Icons.logout_outlined)
      ) : const SizedBox(width: 10)
    ],
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}