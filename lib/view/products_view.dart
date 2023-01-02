import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/utils/errorAlert_view.dart';
import 'package:cafe_mobile_app/viewModel/products_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';
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
            height: 60,
            child: FutureBuilder(
              future: _productsViewModel.getCategories(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorAlertView(description: '');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return createCategoriesListView(context, snapshot);
                } else {
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
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const ErrorAlertView(description: '');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return createProductsListView(context, snapshot);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ) : Text('Wybierz kategorię',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600 ,color: AppColors.darkGoldenrodMap[700]),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget createCategoriesListView(BuildContext context, AsyncSnapshot<List> snapshot) {
    var values = snapshot.data;
    return values == null ? const Text('Wystąpił bład') : ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 12.0),
          child: categoryButton(values[index].name, values[index].id),
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
                        : Text(' ${values[index].price} zł', style: crossedPriceText)
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

  TextStyle crossedPriceText = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGoldenrodMap[500],
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColors.darkGoldenrodMap[900],
  );

  TextStyle specialOfferText = const TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w600 ,
      color: AppColors.projectRed
  );

  ElevatedButton categoryButton(String buttonLabel, int selectedCategory) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGoldenrodMap[100],
          minimumSize: const Size(150.0, 5.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          elevation: 6.0,
          shadowColor: AppColors.darkGoldenrodMap[100]
      ),
      child: Text(
          buttonLabel,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16.0)
      ),
      onPressed: () {
        setState(() {
          _selectedCategory = selectedCategory;
        });
      },
    );
  }


  BoxDecoration menuItemDecoration = BoxDecoration(

    border: Border.all(color: AppColors.burlyWood, width: 2),
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(5)
    ),
    color: AppColors.floralWhite,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 8,
        offset: const Offset(1, 3),
      ),
    ],
  );
}
