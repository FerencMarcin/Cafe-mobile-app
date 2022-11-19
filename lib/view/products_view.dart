import 'dart:developer';

import 'package:cafe_mobile_app/model/product_model.dart';
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

  int _productCategoryId = 0;


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
                    if ( categories != [] && _productCategoryId == 0) {
                      _productCategoryId = categories.first.id!;
                    }
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
                        onPressed: () {
                          setState(() {
                            _productCategoryId = category.id!;
                            log('set selected id $_productCategoryId ..........................................................');
                          });

                        },
                      ),
                    );
                  });
              })
          ),
          const Divider(),
          sectionTitle('Produkty'),
          Expanded(
              //height: 50,
              child: FutureBuilder(
                  future: _productsService.getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      log('loading mess');
                      //TODO show loading view
                    }
                    if (snapshot.hasError) {
                      log('error mes');
                      log(snapshot.error.toString());
                      //TODO show error view
                    }
                    List<ProductModel> products = snapshot.data ?? [];
                    log('products len: ${products.length}');
                    if (_productCategoryId == 0 ) {
                      return Text('Menu jest obecnie niedostępne');
                    }
                    return ListView.builder(

                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          log('jestem w budowaniu menu');
                          log('selected id ${_productCategoryId}');
                          log('product cat id: ${products[index].CategoryId}');
                          if(products[index].CategoryId == _productCategoryId) {
                            ProductModel product = products[index];
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
                                    product.name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16)
                                ),
                                onPressed: () {  },
                              ),
                            );
                          } else {
                            return SizedBox();
                          }

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
