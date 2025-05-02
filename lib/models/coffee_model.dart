// To parse this JSON data, do
//
//     final coffee = coffeeFromJson(jsonString);

import 'dart:convert';

List<Coffee> coffeeFromJson(String str) =>
    List<Coffee>.from(json.decode(str).map((x) => Coffee.fromJson(x)));

// String coffeeToJson(List<Coffee> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coffee {
  final String? title;
  final String? description;
  final List<String>? ingredients;
  final String? image;
  final num? price;
  final int? id;
  int qty;
  String size;

  Coffee({
    this.title,
    this.description,
    this.ingredients,
    this.image,
    this.price,
    this.id,
    this.qty = 0,
    this.size = "M",
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      title: json["title"],
      description: json["description"],
      ingredients: List<String>.from(json["ingredients"]),
      image: json["image"],
      price: json["price"],
      id: json["id"],
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "title": title,
  //       "description": description,
  //       "ingredients": ingredients == null
  //           ? []
  //           : List<dynamic>.from(ingredients!.map((x) => x)),
  //       "image": image,
  //       "price": price,
  //       "id": id,
  //     };
}
