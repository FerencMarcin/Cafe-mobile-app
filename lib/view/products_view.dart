import 'dart:developer';
import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/viewModel/products_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductsViewModel _productsViewModel = Get.put(ProductsViewModel());
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(appBarTitle: 'Menu'),
      body: Column(
        children: [
          sectionTitle('Kategorie'),
          SizedBox(
            height: 50,
            child: FutureBuilder(
              future: _productsViewModel.getCategories(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  log('error mes');
                  //TODO show erro view
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return createCategoriesListView(context, snapshot);
                } else {
                  //TODO LOADING VIEW
                  return const CircularProgressIndicator();
                }
              },
            )
          ),
          const Divider(),
          sectionTitle('Produkty'),
          Expanded(
            child: _selectedCategory != 0 ? FutureBuilder(
              future: _productsViewModel.getProductsByCategory(_selectedCategory),
              // future: getProducts(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  log('error mes');
                  //TODO show erro view
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return createProductsListView(context, snapshot);
                } else {
                  //TODO LOADING VIEW
                  return const CircularProgressIndicator();
                }
              },
            ) : Text(
              'Wybierz kategorię',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600 ,color: AppColors.darkGoldenrodMap[900]),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget createCategoriesListView(BuildContext context, AsyncSnapshot<List> snapshot) {
    var values = snapshot.data!;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: values == null ? 0 : values.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(150.0, 5.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                )
            ),
            child: Text(
                values[index].name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)
            ),
            onPressed: () {
              setState(() {
                _selectedCategory = values[index].id;
              });
            },
          ),
        );
      }
    );
  }

  Widget createProductsListView(BuildContext context, AsyncSnapshot<List> snapshot) {
    var values = snapshot.data;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: values!.length,
      itemBuilder: (BuildContext context, int index) {
        return values.isNotEmpty ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child:  Container(
            height: 80,
            decoration: menuItemDecoration,
            child: values != [] ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(values[index].name, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500 ,color: AppColors.darkGoldenrodMap[900])),
                      const Spacer(),
                      values[index].specialOffer == null ?
                        Text('${values[index].price} zł', style: priceText)
                          : Text(' ${values[index].price} zł', style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGoldenrodMap[500],
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.darkGoldenrodMap[900],
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Text('Pojemność: ${values[index].size}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300 ,color: AppColors.darkGoldenrodMap[800]),),
                        const Spacer(),
                        values[index].specialOffer == null ?
                          const Text("")
                            : Text(
                                '${values[index].price - (values[index].price * 0.01 * values[index].specialOffer.value)} zł',
                                style: specialOfferText,
                              ),
                      ],
                    )
                  )
                ],
              ),
            ) : const Text("Menu obecnie nie jest dostępne"),
          ),
        )
            : const CircularProgressIndicator();
      }
    );
  }

  TextStyle priceText = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGoldenrodMap[900],
  );

  TextStyle specialOfferText = const TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w600 ,
      color: AppColors.projectRed
  );

  BoxDecoration menuItemDecoration = BoxDecoration(
    color: AppColors.darkGoldenrodMap[50],
    border: Border.all(color: AppColors.burlyWood, width: 2),
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(5)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 8,
        offset: const Offset(1, 3),
      ),
    ],
  );

  Padding sectionTitle(String title) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: AppColors.darkGoldenrod))
    );
  }
}
