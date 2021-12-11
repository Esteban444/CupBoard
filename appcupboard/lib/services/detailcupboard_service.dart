/*import 'dart:convert';
import 'package:appcupboard/models/detail_cupboard.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DetailCupBoardService extends ChangeNotifier {
  final List<CupBoardModel> detailcupboardList = [];
  late CupBoardModel selectCupboard;
  final storage = const FlutterSecureStorage();
  bool isloading = true;

  DetailCupBoardService() {
    loadCupboard();
  }

  Future<List<CupBoardModel>> loadCupboard() async {
    notifyListeners();

    final url = Uri.parse('https://10.0.2.2:5001/api/CupboardDetails');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> cupboardMap = json.decode(resp.body);

    cupboardMap.forEach((value) {
      final response = CupBoardModel.fromMap(value);
      detailcupboardList.add(response);
    });

    isloading = false;
    notifyListeners();

    return detailcupboardList;
  }
}*/
