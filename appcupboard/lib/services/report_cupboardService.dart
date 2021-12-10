import 'dart:convert';

import 'package:appcupboard/models/report_cupboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReportCupboardService extends ChangeNotifier {
  final List<CupboardModel> productList = [];
  late CupboardModel selectCupboard;
  final storage = const FlutterSecureStorage();
  bool isloading = true;

  ReportCupboardService() {
    loadCupboard();
  }

  Future<List<CupboardModel>> loadCupboard() async {
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
      final response = CupboardModel.fromMap(value);
      productList.add(response);
    });

    isloading = false;
    notifyListeners();

    return productList;
  }
}
