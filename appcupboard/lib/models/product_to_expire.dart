import 'dart:convert';

class Product {
  Product({
    required this.idProduct,
    required this.idMark,
    required this.nameProduct,
    //required this.expirationDate,
    required this.barCode,
    //required this.cupBoardDetails,
  });

  String idProduct;
  String idMark;
  String nameProduct;
  //DateTime expirationDate;
  String barCode;
  //List<ProdExpireModel> cupBoardDetails;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        idProduct: json["idProduct"],
        idMark: json["idMark"],
        nameProduct: json["nameProduct"],
        //expirationDate: DateTime.parse(json["expirationDate"]),
        barCode: json["barCode"],
        //cupBoardDetails: List<ProdExpireModel>.from(json["cupBoardDetails"].map((x) => ProdExpireModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idProduct": idProduct,
        "idMark": idMark,
        "nameProduct": nameProduct,
        //"expirationDate": expirationDate.toIso8601String(),
        "barCode": barCode,
        //"cupBoardDetails": List<dynamic>.from(cupBoardDetails.map((x) => x.toMap())),
      };
}

class ProductToExpire {
  ProductToExpire({
    required this.idCupboardDetail,
    required this.idCupBoard,
    required this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
    //required this.cupBoard,
    required this.product,
  });

  String idCupboardDetail;
  String idCupBoard;
  String idProduct;
  int amount;
  DateTime entryDate;
  DateTime exitDate;
  DateTime expirationDate;
  //CupBoard cupBoard;
  Product product;

  factory ProductToExpire.fromJson(String str) =>
      ProductToExpire.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductToExpire.fromMap(Map<String, dynamic> json) => ProductToExpire(
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
        "product": product.toMap(),
      };
}
