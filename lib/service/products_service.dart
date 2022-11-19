import 'dart:convert';
import 'dart:developer';

import 'package:cafe_mobile_app/model/category_model.dart';
import 'package:cafe_mobile_app/model/login_request_model.dart';
import 'package:cafe_mobile_app/model/login_response_model.dart';
import 'package:cafe_mobile_app/model/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;


class ProductsService extends GetConnect {
  final String getActiveProductsUrl = 'http://10.0.2.2:3001/products/status/1';
  final String getCategoriesUrl = 'http://10.0.2.2:3001/categories/';

  Future<String?> getActiveProducts() async {
    var urlProducts = Uri.parse(getActiveProductsUrl);

    http.Response res = await http.get(urlProducts);
    return res.body;
    /*
    if(res.statusCode == HttpStatus.ok) {
      log('dobrze');
      final responseData = jsonDecode(res.body);
      if(responseData['error'] != null) {
        log('jest blad');
        return responseData['error'];
      }
      LoginResponseModel loggedInUser = LoginResponseModel(roleId: responseData['roleId'], token: responseData['token']);
      return loggedInUser;
    } else {
      log('oj');
      return jsonDecode(res.body)['error'];
      return null;
    }*/
  }
  //Todo pozbyć się _service - metode do view model
  Future<List<CategoryModel>> getCategories() async {
    log('1');
    List<CategoryModel> categories = <CategoryModel>[];
    var urlCategories = Uri.parse(getCategoriesUrl);
    http.Response response = await http.get(urlCategories);

    var data = jsonDecode(response.body);

    CategoryModel category;
    data.forEach((e) => {
      category = CategoryModel(e['id'], e['name'], e['createdAt'], e['updatedAt']),
      categories.add(category),
      log(e.toString())
    });

    return categories;
  }

  Future<List<ProductModel>> getProducts() async {
    log('2');
    List<ProductModel> products = <ProductModel>[];
    var urlActiveProducts = Uri.parse(getActiveProductsUrl);
    http.Response response = await http.get(urlActiveProducts);

    var data = jsonDecode(response.body);

    ProductModel product;
    data.forEach((newProduct) => {
      product = ProductModel(
          newProduct['id'],
          newProduct['name'],
          newProduct['size'],
          newProduct['price'].toDouble(),
          newProduct['allergen'],
          newProduct['createdAt'],
          newProduct['updatedAt'],
          newProduct['categoryId'],
          newProduct['statusId']),
      products.add(product),
      log(newProduct.toString())
    });

    return products;
  }
}