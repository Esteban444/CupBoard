import 'dart:convert';

class Category {
  Category({
    this.idcategory,
    required this.name,
  });

  String? idcategory;
  String name;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        idcategory: json["idcategory"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Category updateCategory() => Category(idcategory: idcategory, name: name);
}
