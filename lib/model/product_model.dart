import 'package:cafe_mobile_app/model/specialOffer_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? size;
  double? price;
  String? allergen;
  String? createdAt;
  String? updatedAt;
  int? CategoryId;
  int? ProductStatusId;
  SpecialOfferModel? specialOffer;
  //double specialPrice = 0.0;
  //
  // ProductModel(this.id, this.name, this.size, this.price, this.allergen,
  //     this.createdAt, this.updatedAt, this.CategoryId, this.ProductStatusId);
  //
  ProductModel({
    this.id, this.name, this.size, this.price, this.allergen,
    this.createdAt, this.updatedAt, this.CategoryId, this.ProductStatusId
  });

  factory ProductModel.fromJSON(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        size: json['size'],
        price: json['price'].toDouble(),
        allergen: json['allergen'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        CategoryId: json['CategoryId'],
        ProductStatusId: json['ProductStatusId'],
    );
  }

}