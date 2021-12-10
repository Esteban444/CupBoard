import 'dart:convert';

class CupBoard {
  CupBoard({
    this.idCupBoard,
    required this.nameCupBoard,
    required this.isDefault,
    this.creationDate,
    this.cupBoardDetails,
  });

  String? idCupBoard;
  String nameCupBoard;
  bool isDefault;
  String? creationDate;
  List<CupBoardDetail>? cupBoardDetails;

  factory CupBoard.fromJson(String str) => CupBoard.fromMap(json.decode(str));

  factory CupBoard.fromMap(Map<String, dynamic> json) => CupBoard(
        idCupBoard: json["idCupBoard"],
        nameCupBoard: json["nameCupBoard"] ?? '',
        isDefault: json["isDefault"] ?? true,
        creationDate: json["creationDate"],
        //cupBoardDetails: List<CupBoardDetail>.from(
        // json["cupBoardDetails"].map((x) => CupBoardDetail.fromMap(x))),
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

class CupBoardDetail {
  CupBoardDetail({
    this.idCupboardDetail,
    this.idCupBoard,
    required this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
    //this.cupBoard,
  });

  String? idCupboardDetail;
  String? idCupBoard;
  String idProduct;
  String amount;
  String entryDate;
  String exitDate;
  String expirationDate;
  //CupBoardReq? cupBoard;

  factory CupBoardDetail.fromJson(String str) =>
      CupBoardDetail.fromMap(json.decode(str));

  factory CupBoardDetail.fromMap(Map<String, dynamic> json) => CupBoardDetail(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"].toString(),
        entryDate: json["entryDate"],
        exitDate: json["exitDate"],
        expirationDate: json["expirationDate"],
      );

  Map<String, dynamic> toJson() => {
        "idCupboardDetail": idCupboardDetail,
        "idCupBoard": idCupBoard,
        "idProduct": idProduct,
        "amount": amount,
        "entryDate": entryDate,
        "exitDate": exitDate,
        "expirationDate": expirationDate,
      };
}
