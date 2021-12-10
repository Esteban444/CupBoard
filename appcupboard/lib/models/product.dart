import 'dart:convert';

class Products {
  Products({
    this.idProduct,
    required this.idMark,
    required this.nameProduct,
    required this.barCode,
    this.trademark,
  });

  String? idProduct;
  String idMark;
  String nameProduct;
  String barCode;
  Trademark? trademark;

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        idProduct: json["idProduct"],
        idMark: json["idMark"],
        nameProduct: json["nameProduct"],
        barCode: json["barCode"],
        trademark: Trademark.fromMap(json["trademark"]),
      );

  Map<String, dynamic> toJson() => {
        //"idProduct": idProduct,
        "idMark": idMark,
        "nameProduct": nameProduct,
        "barCode": barCode,
        //"trademark": trademark!.toMap(),
      };
}

class Trademark {
  Trademark({
    required this.idTrademark,
    required this.mark,
  });

  String idTrademark;
  String mark;

  factory Trademark.fromJson(String str) => Trademark.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Trademark.fromMap(Map<String, dynamic> json) => Trademark(
        idTrademark: json["idTrademark"],
        mark: json["mark"],
      );

  Map<String, dynamic> toMap() => {
        "idTrademark": idTrademark,
        "mark": mark,
      };
}
