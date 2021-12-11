import 'dart:convert';

class ProductAvailable {
  ProductAvailable({
    required this.idProduct,
    required this.idMark,
    required this.nameProduct,
    required this.barCode,
  });

  String idProduct;
  String idMark;
  String nameProduct;
  String barCode;

  factory ProductAvailable.fromJson(String str) =>
      ProductAvailable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductAvailable.fromMap(Map<String, dynamic> json) =>
      ProductAvailable(
        idProduct: json["idProduct"],
        idMark: json["idMark"],
        nameProduct: json["nameProduct"],
        barCode: json["barCode"],
      );

  Map<String, dynamic> toMap() => {
        "idProduct": idProduct,
        "idMark": idMark,
        "nameProduct": nameProduct,
        "barCode": barCode,
      };
}

class MainCupBoardAvailable {
  MainCupBoardAvailable({
    required this.idCupBoard,
    required this.nameCupBoard,
    required this.isDefault,
    required this.creationDate,
    required this.cupBoardDetails,
  });

  String idCupBoard;
  String nameCupBoard;
  bool isDefault;
  DateTime creationDate;
  List<CupboardAvailable> cupBoardDetails;

  factory MainCupBoardAvailable.fromJson(String str) =>
      MainCupBoardAvailable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MainCupBoardAvailable.fromMap(Map<String, dynamic> json) =>
      MainCupBoardAvailable(
        idCupBoard: json["idCupBoard"],
        nameCupBoard: json["nameCupBoard"],
        isDefault: json["isDefault"],
        creationDate: DateTime.parse(json["creationDate"]),
        cupBoardDetails: List<CupboardAvailable>.from(
            json["cupBoardDetails"].map((x) => CupboardAvailable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idCupBoard": idCupBoard,
        "nameCupBoard": nameCupBoard,
        "isDefault": isDefault,
        "creationDate": creationDate.toIso8601String(),
        "cupBoardDetails":
            List<dynamic>.from(cupBoardDetails.map((x) => x.toMap())),
      };
}

class CupboardAvailable {
  CupboardAvailable({
    required this.idCupboardDetail,
    required this.idCupBoard,
    required this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
    this.mainCupBoardAvailable,
    this.productAvailable,
  });

  String idCupboardDetail;
  String idCupBoard;
  String idProduct;
  int amount;
  String entryDate;
  String exitDate;
  String expirationDate;
  MainCupBoardAvailable? mainCupBoardAvailable;
  ProductAvailable? productAvailable;

  factory CupboardAvailable.fromJson(String str) =>
      CupboardAvailable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CupboardAvailable.fromMap(Map<String, dynamic> json) =>
      CupboardAvailable(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"],
        entryDate: json["entryDate"],
        exitDate: json["exitDate"],
        expirationDate: json["expirationDate"],
        productAvailable: ProductAvailable.fromMap(json["product"]),
        //mainCupBoardAvailable: MainCupBoardAvailable.fromMap(json["cupBoard"]),
      );

  Map<String, dynamic> toMap() => {
        "idCupboardDetail": idCupboardDetail,
        "idCupBoard": idCupBoard,
        "idProduct": idProduct,
        "amount": amount,
        "entryDate": entryDate,
        "exitDate": exitDate,
        "expirationDate": expirationDate,
        "productAvailable": productAvailable!.toMap(),
        //"mainCupBoardAvailable": mainCupBoardAvailable!.toMap(),
      };
}
