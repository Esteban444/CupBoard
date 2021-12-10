import 'dart:convert';

class Product {
  Product({
    required this.idProduct,
    required this.idMark,
    required this.nameProduct,
    required this.barCode,
    //required this.cupBoardDetails,
    //required this.expirationDate,
  });

  String idProduct;
  String idMark;
  String nameProduct;
  String barCode;
  //List<ExpiredProdModel> cupBoardDetails;
  //DateTime expirationDate;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        idProduct: json["idProduct"],
        idMark: json["idMark"],
        nameProduct: json["nameProduct"],
        barCode: json["barCode"],
        //cupBoardDetails: List<ExpiredProdModel>.from(json["cupBoardDetails"].map((x) => ExpiredProdModel.fromMap(x))),
        //expirationDate: DateTime.parse(json["expirationDate"]),
      );

  Map<String, dynamic> toMap() => {
        "idProduct": idProduct,
        "idMark": idMark,
        "nameProduct": nameProduct,
        "barCode": barCode,
        //"cupBoardDetails": List<dynamic>.from(cupBoardDetails.map((x) => x.toMap())),
        //"expirationDate": expirationDate.toIso8601String(),
      };
}

class ExpiredProduct {
  ExpiredProduct({
    required this.idCupboardDetail,
    required this.idCupBoard,
    this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
    //required this.cupBoard,
    this.product,
  });

  String idCupboardDetail;
  String idCupBoard;
  String? idProduct;
  int amount;
  DateTime entryDate;
  DateTime exitDate;
  DateTime expirationDate;
  //CupBoard cupBoard;
  Product? product;

  factory ExpiredProduct.fromJson(String str) =>
      ExpiredProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExpiredProduct.fromMap(Map<String, dynamic> json) => ExpiredProduct(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"],
        entryDate: DateTime.parse(json["entryDate"]),
        exitDate: DateTime.parse(json["exitDate"]),
        expirationDate: DateTime.parse(json["expirationDate"]),
        //cupBoard: CupBoard.fromMap(json["cupBoard"]),
        product: Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "idCupboardDetail": idCupboardDetail,
        "idCupBoard": idCupBoard,
        "idProduct": idProduct,
        "amount": amount,
        "entryDate": entryDate.toIso8601String(),
        "exitDate": exitDate.toIso8601String(),
        "expirationDate": expirationDate.toIso8601String(),
        //"cupBoard": cupBoard.toMap(),
        "product": product!.toMap(),
      };
}
