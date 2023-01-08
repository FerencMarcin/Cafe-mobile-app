import 'package:cafe_mobile_app/view/utils/errorAlert_view.dart';
import 'package:cafe_mobile_app/view/utils/loading_view.dart';
import 'package:cafe_mobile_app/view/utils/logoutAlert_view.dart';
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
  String _sortBy = 'asc';
  bool _onlyActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: ''),
        body: Column(
          children: [
            sectionTitle('Moje talony'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text("Data ważności: ", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 1,
                    value: _sortBy,
                    items: const [
                      DropdownMenuItem(value: 'asc', child: Text('Rosnąco')),
                      DropdownMenuItem(value: 'desc', child: Text('Malejąco')),
                    ],
                    onChanged: (value) {setState(() {_sortBy = value!;});},
                  ),
                  const Spacer(),
                  Text('Tylko aktywne: ', style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
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
                    return createUserCouponsListView(context, snapshot);
                  } else {
                    return const LoadingView();
                  }
                },
              ),
            )
          ],
        )
    );
  }

  Widget createUserCouponsListView(BuildContext context, AsyncSnapshot<List> snapshot) {
    var values = snapshot.data;
    return values == null
        ? const Text("Lista Twoich kuponów nie jest dostępne")
        : values.isEmpty
        ? const Text("Nie posiadasz żadnych kuponów")
        :  ListView.builder(
        itemCount: values.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,

        itemBuilder: (BuildContext context, int index) {
          return values[index].UserCouponStatusId == 1 ? Padding(
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding (
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.qr_code_2_outlined, size: 40.0, color: AppColors.darkGoldenrod,),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kod: ${values[index].code}', style: voucherCodeTextStyle),
                                    Text('${values[index].couponName}', style: voucherNameTextStyle),
                                  ],
                                )

                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 170.0,
                                  decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(color: AppColors.aztecGold)
                                          )
                                      ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text('Cena regularna ${values[index].productPrice}', style: voucherDescriptionTextStyle),
                                      ),
                                      Text('Cena z kuponem:', style: voucherDescriptionTextStyle),
                                      values[index].newProductPrice == 0.0
                                          ? Text('Gratis!', style: voucherNewPriceTextStyle)
                                          : Text('${values[index].newProductPrice} zł', style: voucherNewPriceTextStyle)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Data ważności:', style: voucherDescriptionTextStyle),
                                      Text('${values[index].expirationDate}', style: voucherNameTextStyle),
                                      Row(
                                        children: [
                                          Text('Dni do wygaśnięcia: ', style: voucherDescriptionTextStyle),
                                          Text('${values[index].daysUntilExpiration}',
                                            style: values[index].daysUntilExpiration > 3 ? voucherDaysTextStyle : voucherDaysWarningTextStyle)
                                        ],
                                      )

                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ) : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    border: Border.all(color: AppColors.burlyWood)
                ),
                height: 70.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('N I E D O S T Ę P N Y', style: voucherUnavailableTextStyle),
                            Text('${values[index].couponName}', style: voucherNameTextStyle),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: OutlinedButton(
                                style: detailsButtonStyle,
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Kod niedostepny',
                                      middleText: 'Ten kupon został już wykorzystany lub stracił wazność',
                                      textConfirm: 'Wróć',
                                      onConfirm: () {
                                        Get.back();
                                      }
                                  );
                                },
                                child: const Icon(Icons.question_mark_outlined, color: AppColors.darkGoldenrod)
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
      color: AppColors.darkGoldenrodMap[800]
  );

  final TextStyle voucherCodeTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17.0,
      color: AppColors.darkGoldenrodMap[900]
  );

  final TextStyle voucherUnavailableTextStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15.0,
      color: AppColors.projectRed
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

  final TextStyle voucherDaysTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17.0,
      color: AppColors.projectGreen
  );

  final TextStyle voucherDaysWarningTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17.0,
      color: AppColors.projectRed
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
