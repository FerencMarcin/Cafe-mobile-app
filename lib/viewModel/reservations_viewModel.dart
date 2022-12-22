import 'dart:convert';
import 'dart:developer';
import 'package:cafe_mobile_app/model/category_model.dart';
import 'package:cafe_mobile_app/model/product_model.dart';
import 'package:cafe_mobile_app/model/specialOffer_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/reservation_model.dart';
import '../model/table_model.dart';
import '../service/interceptor/dioClient.dart';

class ReservationsViewModel {
  final DioClient _dioClient = Get.put(DioClient());

  Future<List<TableModel>> getReservations() async {
    final tables = await _dioClient.dioClient.get('http://10.0.2.2:3001/tables/');
    final response = await _dioClient.dioClient.get('http://10.0.2.2:3001/reservations/reservationstatus/1');
    log(response.statusCode.toString());
    List<TableModel> tablesList = <TableModel>[];
    if (response.statusCode == 200 && tables.statusCode == 200) {
      log(tables.toString());
      //var r = jsonDecode(tables.data);
      tables.data.forEach((table) => {
        tablesList.add(TableModel.fromJSON(table)),
        log(TableModel.fromJSON(table).toString())
      });
      //log(r.toString());
      //tables.data
      //TableModel ta = TableModel.fromJSON(tables.data);
      //log("aaaaa" + ta.toString());

      //var parsedTables = jsonDecode(tables);
      // for(var i = 1; i <11; i++){
      //   tablesList.add(TableModel(number: i, numberOfSeats: 2, TableStatusId: 1));
      // }
      log("stoliki ladowanie");
      //var parsedCategoryList = json.decode(response);

      //parsedCategoryList.forEach((category) {

      //});
      return tablesList;
    } else {
      throw Exception('Nie udało się załadować rezerwacji');
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    const String getCategoriesUrl = 'http://10.0.2.2:3001/categories/notempty';
    var urlCategories = Uri.parse(getCategoriesUrl);
    http.Response response = await http.get(urlCategories);
    if (response.statusCode == 200) {
      var parsedCategoryList = json.decode(response.body);
      List<CategoryModel> categories = <CategoryModel>[];
      parsedCategoryList.forEach((category) {
        categories.add(CategoryModel.fromJSON(category));
      });
      return categories;
    } else {
      throw Exception('Nie udało się załadować menu');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(selectedCategory) async {
    String getProductsByCategoryUrl = 'http://10.0.2.2:3001/products/specialoffers';
    var urlProducts = Uri.parse(getProductsByCategoryUrl);
    http.Response response = await http.get(urlProducts);
    if (response.statusCode == 200) {
      var parsedProductList = json.decode(response.body);
      List<ProductModel> products = <ProductModel>[];
      parsedProductList.forEach((product) {
        if(product['CategoryId'] == selectedCategory) {
          ProductModel parsedProduct = ProductModel.fromJSON(product);
          product['SpecialOffers'].forEach((offer) {
            SpecialOfferModel parsedOffer = SpecialOfferModel.fromJSON(offer);
            var parsedStartDate = DateTime.parse(parsedOffer.startDate!);
            var parsedEndDate = DateTime.parse(parsedOffer.endDate!);
            DateTime now = DateTime.now();
            if((now.compareTo(parsedEndDate) < 0) && (now.compareTo(parsedStartDate) > 0)){
              parsedProduct.specialOffer = parsedOffer;
            }
          });
          if (parsedProduct.ProductStatusId == 1) {
            products.add(parsedProduct);
          }
        }
      });
      return products;
    } else {
      throw Exception('Nie udało się załadować menu dla tej kategorii');
    }
  }
}