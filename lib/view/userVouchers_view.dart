import 'dart:developer';

import 'package:cafe_mobile_app/view/utils/errorAlert_view.dart';
import 'package:cafe_mobile_app/view/utils/loading_view.dart';
import 'package:cafe_mobile_app/view/utils/logoutAlert_view.dart';
import 'package:cafe_mobile_app/viewModel/user_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import '../viewModel/voucher_viewModel.dart';
import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class UserVouchersView extends StatefulWidget {
  const UserVouchersView({Key? key}) : super(key: key);

  @override
  State<UserVouchersView> createState() => _UserVouchersViewState();
}

class _UserVouchersViewState extends State<UserVouchersView> {
  final VoucherViewModel _voucherViewModel = Get.put(VoucherViewModel());
  String _sortBy = 'date';
  bool _onlyActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: ''),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sectionTitle('Moje talony'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text("Sortowanie: ", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 1,
                    value: _sortBy,
                    items: const [
                      DropdownMenuItem(value: 'date', child: Text('Data')),
                      DropdownMenuItem(value: 'price', child: Text('Wartość')),
                    ],
                    onChanged: (value) {setState(() {_sortBy = value!;});},
                  ),
                  const Spacer(),
                  Text('Pokaż aktywne: ', style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  Switch(
                      inactiveThumbColor: AppColors.darkGoldenrodMap[900],
                      value: _onlyActive,
                      onChanged: (value) {setState(() {_onlyActive = value;});}
                  )
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 600.0,
              child: FutureBuilder(
                future: _voucherViewModel.getUserVouchers(_sortBy, _onlyActive),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    if(snapshot.error == 403){
                      return const LogoutAlertView();
                    } else {
                      return ErrorAlertView(description: snapshot.error.toString());
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return createOrdersListView(context, snapshot);
                  } else {
                    //TODO LOADING VIEW
                    //return const CircularProgressIndicator();
                    return const LoadingView();
                  }
                },
              ),
            )
          ],
        )
    );
  }

  Widget createOrdersListView(BuildContext context, AsyncSnapshot<List> snapshot) {
    var values = snapshot.data;
    return values == null
        ? const Text("Lista zamówień obecnie nie jest dostępne")
        : values.isEmpty
        ? const Text("Nie posiadasz żadnych zamówień")
        :  ListView.builder(
        itemCount: values.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,

        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(Icons.shopping_cart_outlined,
                          size: 30.0, color: AppColors.aztecGold),
                      title: Text('Data: ${values[index].date}',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: AppColors.darkGoldenrodMap[900])),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text('Wartość: ${values[index].value} zł',
                                style: TextStyle(color: AppColors.darkGoldenrodMap[900])),
                          ),
                          Text('Produktów: ${values[index].productsAmount}',
                              style: TextStyle(color: AppColors.darkGoldenrodMap[900]))
                        ],
                      ),
                      trailing: OutlinedButton(
                        style: detailsButtonStyle,
                        onPressed: () {
                          log('clicked');
                        },
                        child: Text("Szczegóły", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                      )
                  ),
                  const Divider()
                ],
              )
          );
        }
    );
  }

  final ButtonStyle detailsButtonStyle = OutlinedButton.styleFrom(
      textStyle: TextStyle(fontSize: 17.0, color: AppColors.darkGoldenrodMap[800]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 5.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );
}
