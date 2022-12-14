import 'dart:convert';
import 'package:cafe_mobile_app/model/category_model.dart';
import 'package:cafe_mobile_app/model/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductsViewModel extends GetxController {

  Future<List<CategoryModel>> getCategories() async {
    const String getCategoriesUrl = 'http://10.0.2.2:3001/categories/';
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
    String getProductsByCategoryUrl = 'http://10.0.2.2:3001/products/category/';
    var urlProducts = Uri.parse('$getProductsByCategoryUrl$selectedCategory');
    http.Response response = await http.get(urlProducts);
    if (response.statusCode == 200) {
      var parsedProductList = json.decode(response.body);
      List<ProductModel> products = <ProductModel>[];
      parsedProductList.forEach((product) {
        ProductModel parsedProduct = ProductModel.fromJSON(product);
        if(parsedProduct.ProductStatusId == 1) {
          products.add(ProductModel.fromJSON(product));
        }
      });
      return products;
    } else {
      throw Exception('Nie udało się załadować menu dla tej kategorii');
    }
  }
}