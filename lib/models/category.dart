
import 'dart:convert';

CategoriesList categoriesFromJson(String str) => CategoriesList.fromJson(json.decode(str));

String categoriesToJson(CategoriesList data) => json.encode(data.toJson());

class CategoriesList {
  CategoriesList({
    this.categories,
  });

  List<Category> categories;

  factory CategoriesList.fromJson(Map<String, dynamic> json) => CategoriesList(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    idCategory: json["idCategory"],
    strCategory: json["strCategory"],
    strCategoryThumb: json["strCategoryThumb"],
    strCategoryDescription: json["strCategoryDescription"],
  );

  Map<String, dynamic> toJson() => {
    "idCategory": idCategory,
    "strCategory": strCategory,
    "strCategoryThumb": strCategoryThumb,
    "strCategoryDescription": strCategoryDescription,
  };
}
