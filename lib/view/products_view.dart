import 'dart:developer';

import 'package:cafe_mobile_app/service/products_service.dart';
import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/viewModel/products_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';
import 'appBar/appBar_view.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  ProductsViewModel _productsViewModel = Get.put(ProductsViewModel());
  ProductsService _productsService = Get.put(ProductsService());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(appBarTitle: 'Menu'),
      body: Column(
        children: [
          sectionTitle('Kategorie'),

          //TODO it works fix service and viewmodel dependency

          Container(
            height: 50,
            child: FutureBuilder(
              future: _productsService.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  log('loading mess');
                  //TODO show loading view
                }
                if (snapshot.hasError) {
                  log('error mes');
                  //TODO show erro view
                }
                List<CategoryModel> categories = snapshot.data ?? [];
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    CategoryModel category = categories[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 5),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          )
                        ),
                        child: Text(
                          category.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)
                        ),
                        onPressed: () {  },
                      ),
                    );
                  });
              })
          )
        ],
      ),
    );
  }

  Padding sectionTitle(String title) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: AppColors.darkGoldenrod))
    );
  }
}
