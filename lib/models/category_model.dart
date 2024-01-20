// To parse this JSON data, do
//
//     final categoyModel = categoyModelFromJson(jsonString);

import 'dart:convert';

CategoyModel categoyModelFromJson(String str) =>
    CategoyModel.fromJson(json.decode(str));

class CategoyModel {
  List<Category> categories;

  CategoyModel({
    required this.categories,
  });

  factory CategoyModel.fromJson(Map<String, dynamic> json) => CategoyModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );
}
