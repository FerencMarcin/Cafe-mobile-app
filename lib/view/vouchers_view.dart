import 'dart:developer';

import 'package:cafe_mobile_app/view/utils/logoutAlert_view.dart';
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
  bool refresh = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Katalog talonów'),
        body: isError ? LogoutAlertView() : Column(
          children: [
            Row(
              children: [
                const Spacer(),
                sectionTitle('Twoje punkty: '),
                FutureBuilder(
                  future: _userViewModel.getUserPoints(),
                  initialData: 0,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      if(snapshot.error == 403) {
                        Navigator.pushNamed(context, '/start');
                      }
                      log(snapshot.error.toString() + 'blad wskazany w view');
                      log('error mes');
                      return const Text('Wystąpił bład -view');
                      //TODO show erro view
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      var value = snapshot.data;
                      if (value != null) {
                        points = int.tryParse(value.toString());
                        points ??= 0;
                        return Text(points.toString(), style: pointsTextStyle);
                      }
                      return const Text('Wystąpił bład');
                    } else {
                      //TODO LOADING VIEW
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      onPressed: (){
                        setState(() {
                          refresh = !refresh;
                        });
                      },
                      icon: const Icon(Icons.refresh_outlined)),
                )
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
                  if (snapshot.connectionState == ConnectionState.done && points != null) {
                    return createVouchersListView(context, snapshot);
                  } else {
                    //TODO LOADING VIEW
                    return const SizedBox(
                        height: 100.0,
                        child: CircularProgressIndicator()
                    );
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
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    border: Border.all(color: AppColors.burlyWood)
                  ),
                  height: 120.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60.0,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: AppColors.aztecGold)
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.qr_code_2_outlined, size: 40.0, color: AppColors.aztecGold),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text('${values[index].value}%', style: voucherValueTextStyle),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${values[index].couponName}', style: voucherNameTextStyle),
                              Text('Cena regularna ${values[index].productPrice}', style: voucherDescriptionTextStyle),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text('Cena z kuponem:', style: voucherDescriptionTextStyle),
                              ),
                              values[index].newProductPrice == 0.0
                                  ? Text('Gratis!', style: voucherNewPriceTextStyle)
                                  : Text('${values[index].newProductPrice} zł', style: voucherNewPriceTextStyle)
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            values[index].pointPrice > points
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${values[index].pointPrice} pkt', style: voucherPointPriceUnavailable),
                              )
                              : Expanded(
                                child: Column (
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${values[index].pointPrice} pkt', style: voucherPointPriceAvailable),
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
                )
            );
          }
        );
  }

  final TextStyle voucherNameTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: AppColors.darkGoldenrodMap[900]
  );

  final TextStyle voucherDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15.0,
      color: AppColors.darkGoldenrodMap[800]
  );

  final TextStyle voucherNewPriceTextStyle = const TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 17.0,
      color: AppColors.projectGreen
  );

  final TextStyle voucherPointPriceAvailable = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17.0,
      color: AppColors.projectGreen
  );

  final TextStyle voucherPointPriceUnavailable = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17.0,
      color: AppColors.projectRed
  );

  final TextStyle voucherValueTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
    fontStyle: FontStyle.italic,
    color: AppColors.projectGreen
  );

  final TextStyle pointsTextStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 25.0,
      fontStyle: FontStyle.italic,
      color: AppColors.projectGreen
  );

  final ButtonStyle detailsButtonStyle = OutlinedButton.styleFrom(
      textStyle: TextStyle(fontSize: 17.0, color: AppColors.darkGoldenrodMap[800]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 5.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );
}
