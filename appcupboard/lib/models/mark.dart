import 'dart:convert';

class Mark {
  Mark({
    this.idTrademark,
    required this.mark,
  });

  String? idTrademark;
  String mark;

  factory Mark.fromJson(String str) => Mark.fromMap(json.decode(str));

  factory Mark.fromMap(Map<String, dynamic> json) => Mark(
        idTrademark: json["idTrademark"],
        mark: json["mark"],
      );

  Map<String, dynamic> toJson() => {
        "mark": mark,
      };

  Mark updateMark() => Mark(idTrademark: idTrademark, mark: mark);
}
