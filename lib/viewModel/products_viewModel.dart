import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/model/category_model.dart';
import 'package:cafe_mobile_app/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/products_service.dart';

class ProductsViewModel extends GetxController {
  late final ProductsService _productsService;
  List<CategoryModel> _activeCategories = <CategoryModel>[];
  List<ProductModel> _activeProducts = <ProductModel>[];

  @override
  void onInit() {
    super.onInit();
    _productsService = Get.put(ProductsService());
  }

  Future<Widget> getCategories(BuildContext context) async {

      return FutureBuilder(
        future: _productsService.getCategories(),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done) {
            log('loading mess');
            //TODO show loading view
          }
          if(snapshot.hasError) {
            log('error mes');
            //TODO show erro view
          }
          List<CategoryModel> categories = snapshot.data ?? [];
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return ListTile(
                title: Text(category.name!),
              );
            }
          );
        }
      );

  }

  Future<List<CategoryModel>> getCategor() async {
    List<CategoryModel> categories = <CategoryModel>[];
    final response = await _productsService.getCategories();
    /*
    if (response != null) {
      Map<String, dynamic> myMap = json.decode(response);
      myMap.forEach((key, value) {
        print('$key : $value');
      });
      log(myMap.toString());

    } else {
      Get.defaultDialog(
          middleText: 'Niepoprawne dane',
          textConfirm: 'Wróć',
          onConfirm: () {
            Get.back();
          }
      );
    }

     */
    return categories;
  }
}