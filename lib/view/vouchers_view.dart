import 'dart:developer';

import 'package:cafe_mobile_app/viewModel/user_viewModel.dart';
import 'package:cafe_mobile_app/viewModel/voucher_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class VouchersView extends StatefulWidget {
  const VouchersView({Key? key}) : super(key: key);

  @override
  State<VouchersView> createState() => _VouchersViewState();
}

class _VouchersViewState extends State<VouchersView> {
  final UserViewModel _userViewModel = Get.put(UserViewModel());
  final VoucherViewModel _voucherViewModel = Get.put(VoucherViewModel());
  String sortType = 'asc';
  int? points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Katalog talonów'),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Spacer(),
                sectionTitle('Twoje punkty: '),
                FutureBuilder(
                  future: _userViewModel.getUserPoints(),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      log(snapshot.error.toString());
                      log('error mes');
                      return Text('Wystąpił bład');
                      //TODO show erro view
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        points = int.tryParse(snapshot.data.toString());
                        return Text(points.toString());
                      }
                      return Text('Wystąpił bład');
                    } else {
                      //TODO LOADING VIEW
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                Spacer()
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text("Sortowanie: ", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 1,
                    value: sortType,
                    items: const [
                      DropdownMenuItem(value: 'asc', child: Text('Cena rosnąco')),
                      DropdownMenuItem(value: 'desc', child: Text('Cena malejąco')),
                    ],
                    onChanged: (value) {setState(() {sortType = value!;});},
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 600.0,
              child: FutureBuilder(
                future: _voucherViewModel.getVouchers(sortType),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    log(snapshot.error.toString());
                    log('error mes');
                    //TODO show erro view
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return createVouchersListView(context, snapshot);
                  } else {
                    //TODO LOADING VIEW
                    return const CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        )
    );
  }

  Widget createVouchersListView(BuildContext context, AsyncSnapshot<List> snapshot) {
    var values = snapshot.data;
    return values == null
        ? const Text("Lista kuponów obecnie nie jest dostępne")
        : values.isEmpty ? const Text("Obecnie nie mamy żadnych kuponów")
        : ListView.builder(
          itemCount: values.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    border: Border.all(color: AppColors.burlyWood)
                  ),
                  height: 120.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Icon(Icons.shopping_cart_outlined, size: 30.0, color: AppColors.aztecGold)],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text('Cena: ${values[index].pointPrice}'),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            values[index].pointPrice > points
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${values[index].pointPrice} punktów', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0, color: AppColors.projectRed)),
                              )
                              : Expanded(
                                child: Column (
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${values[index].pointPrice} punktów', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0, color: AppColors.projectGreen)),
                                    ),
                                    OutlinedButton(
                                      style: detailsButtonStyle,
                                      onPressed: () {},
                                      child: Text("Wybierz", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),

                      ],
                    ),
                  ),
                  // child: Column(
                  //   children: [
                  //     ListTile(
                  //         leading: const Icon(Icons.shopping_cart_outlined,
                  //             size: 30.0, color: AppColors.aztecGold),
                  //
                  //         title: Text('Data: ',
                  //             style: TextStyle(fontWeight: FontWeight.bold,
                  //                 color: AppColors.darkGoldenrodMap[900])),
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text('Cena: ${values[index].pointPrice}'),
                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(vertical: 3.0),
                  //               child: Text('Wartość:zł',
                  //                   style: TextStyle(color: AppColors.darkGoldenrodMap[900])),
                  //             ),
                  //             Text('Produktów: }',
                  //                 style: TextStyle(color: AppColors.darkGoldenrodMap[900])),
                  //             OutlinedButton(
                  //               style: detailsButtonStyle,
                  //               onPressed: () {},
                  //               child: Text("Wybierz", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  //             )
                  //           ],
                  //         ),
                  //         trailing: values[index].pointPrice > points
                  //             ? Text('${values[index].pointPrice} punktów', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0, color: AppColors.projectRed))
                  //             : Expanded(
                  //               child: Column (
                  //                 children: [
                  //                   Text('${values[index].pointPrice} punktów', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0, color: AppColors.projectGreen)),
                  //                   OutlinedButton(
                  //                     style: detailsButtonStyle,
                  //                     onPressed: () {},
                  //                     child: Text("Wybierz", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  //                   )
                  //                 ],
                  //               ),
                  //             )
                  //         // OutlinedButton(
                  //         //   style: detailsButtonStyle,
                  //         //   onPressed: () {},
                  //         //   child: Text("Szczegóły", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  //         // )
                  //     ),
                  //     const Divider()
                  //   ],
                  // ),
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
