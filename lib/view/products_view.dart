import 'dart:developer';

import 'package:cafe_mobile_app/service/products_service.dart';
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
          Scrollbar(
              child: TextButton(
            child: Text('tu będą kategorie'),
            onPressed: () {
              _productsViewModel.getCategories(context);
            },
          )),
          //TODO it works fix service and viewmodel dependency

          FutureBuilder(
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
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      CategoryModel category = categories[index];
                      return ListTile(
                        title: Text(category.name!),
                      );
                    });
              })


        ],
      ),
    );
  }
}
