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

class ReportCupBoard {
  ReportCupBoard({
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
  List<CupboardModel>? cupBoardDetails;

  factory ReportCupBoard.fromJson(String str) =>
      ReportCupBoard.fromMap(json.decode(str));

  factory ReportCupBoard.fromMap(Map<String, dynamic> json) => ReportCupBoard(
        idCupBoard: json["idCupBoard"],
        nameCupBoard: json["nameCupBoard"],
        isDefault: json["isDefault"],
        creationDate: DateTime.parse(json["creationDate"]),
        cupBoardDetails: List<CupboardModel>.from(
            json["cupBoardDetails"].map((x) => CupboardModel.fromMap(x))),
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

class CupboardModel {
  CupboardModel({
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
  int amount;
  String entryDate;
  String exitDate;
  String expirationDate;
  Product? product;

  factory CupboardModel.fromJson(String str) =>
      CupboardModel.fromMap(json.decode(str));

  factory CupboardModel.fromMap(Map<String, dynamic> json) => CupboardModel(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"],
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
