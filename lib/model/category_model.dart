class CategoryModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  // CategoryModel(this.id, this.name, this.createdAt, this.updatedAt);

  CategoryModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt
  });

  factory CategoryModel.fromJSON(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}