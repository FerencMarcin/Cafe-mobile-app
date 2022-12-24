import 'dart:developer';

import 'package:cafe_mobile_app/model/orderDetailsViewArguments_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/colors.dart';
import '../viewModel/orders_viewModel.dart';
import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrderDetailsViewArgumentsModel;
    final OrdersViewModel _ordersViewModel = Get.find();

    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Szczegóły zamówienia'),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sectionTitle('Zamówienie nr: ${args.orderId}'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text('Suma: ${args.orderValue} zł', style: TextStyle(
                      fontSize: 22.0,
                      color: AppColors.darkGoldenrodMap[800],
                      fontWeight: FontWeight.w900)
                  ),
                ],
              )
            ),
            const Divider(),
            SizedBox(
              height: 600.0,
              child: FutureBuilder(
                future: _ordersViewModel.getUserOrderDetails(args.orderId),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    log(snapshot.error.toString());
                    log('error mes');
                    //TODO show erro view
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return createOrderDetailsListView(context, snapshot);
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

  Widget createOrderDetailsListView(BuildContext context, AsyncSnapshot<List> snapshot) {
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
                      leading: Icon(values[index].isCoupon
                          ? Icons.qr_code_2_outlined
                          : Icons.sell_outlined,
                            size: 30.0, color: AppColors.aztecGold),
                      title: Text('${values[index].productName}',
                          style: detailTitleTextStyle),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text('Cena: ${values[index].unitPrice} zł',
                                style: detailTextTextStyle),
                          ),
                          Text('Ilość: ${values[index].quantity}',
                              style: detailTextTextStyle)
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wartość: ', style: detailTitleTextStyle),
                          values[index].isCoupon
                              ? Text('Kupon', style: TextStyle(color: AppColors.projectGreen))
                              : Text('${values[index].quantity * values[index].unitPrice}',
                                  style: detailTextTextStyle,)
                        ],
                      )
                  ),
                  const Divider()
                ],
              )
          );
        }
    );
  }

  static TextStyle detailTitleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.darkGoldenrodMap[900]
  );

  static TextStyle detailTextTextStyle = TextStyle(
      color: AppColors.darkGoldenrodMap[900]
  );
}
