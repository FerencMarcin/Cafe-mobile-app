class ProductModel {
  int? id;
  String? name;
  String? size;
  double? price;
  String? allergen;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  int? statusId;

  ProductModel(this.id, this.name, this.size, this.price, this.allergen,
      this.createdAt, this.updatedAt, this.categoryId, this.statusId);

}