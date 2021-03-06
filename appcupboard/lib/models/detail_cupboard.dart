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
  //List<CupboardModel> cupBoardDetails;
  //DateTime expirationDate;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        idProduct: json["idProduct"],
        idMark: json["idMark"],
        nameProduct: json["nameProduct"],
        barCode: json["barCode"],
        //cupBoardDetails: List<CupboardModel>.from(json["cupBoardDetails"].map((x) => CupboardModel.fromMap(x))),
        // expirationDate: DateTime.parse(json["expirationDate"]),
        //expirationDate: json["expirationDate"] == null ? null : DateTime.parse(json["expirationDate"]),
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

class Cupboard {
  Cupboard({
    this.idCupBoard,
    this.nameCupBoard,
    this.isDefault,
    this.creationDate,
    this.cupBoardDetails,
  });

  String? idCupBoard;
  String? nameCupBoard;
  bool? isDefault;
  DateTime? creationDate;
  List<CupBoardModel>? cupBoardDetails;

  factory Cupboard.fromJson(String str) => Cupboard.fromMap(json.decode(str));

  factory Cupboard.fromMap(Map<String, dynamic> json) => Cupboard(
        idCupBoard: json["idCupBoard"],
        nameCupBoard: json["nameCupBoard"],
        isDefault: json["isDefault"],
        creationDate: DateTime.parse(json["creationDate"]),
        cupBoardDetails: List<CupBoardModel>.from(
            json["cupBoardDetails"].map((x) => CupBoardModel.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "idCupBoard": idCupBoard,
        "nameCupBoard": nameCupBoard,
        "isDefault": isDefault,
        "creationDate": creationDate,
        "cupBoardDetails":
            List<dynamic>.from(cupBoardDetails!.map((x) => x.toJson())),
      };
}

class CupBoardModel {
  CupBoardModel({
    this.idCupboardDetail,
    this.idCupBoard,
    required this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
    this.product,
  });

  String? idCupboardDetail;
  String? idCupBoard;
  String idProduct;
  String amount;
  String entryDate;
  String exitDate;
  String expirationDate;
  Product? product;

  factory CupBoardModel.fromJson(String str) =>
      CupBoardModel.fromMap(json.decode(str));

  factory CupBoardModel.fromMap(Map<String, dynamic> json) => CupBoardModel(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"].toString(),
        entryDate: json["entryDate"],
        exitDate: json["exitDate"],
        expirationDate: json["expirationDate"],
        //cupBoard: CupBoard.fromMap(json["cupBoard"]),
        product: Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "idCupboardDetail": idCupboardDetail,
        "idCupBoard": idCupBoard,
        "idProduct": idProduct,
        "amount": amount,
        "entryDate": entryDate,
        "exitDate": exitDate,
        "expirationDate": expirationDate,
        //"cupBoard": cupBoard!.toJson(),
        //"product": product!.toMap(),
      };
}
