import 'dart:convert';

import 'package:appcupboard/models/report_cupboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReportCupboardService extends ChangeNotifier {
  final _baseUrl = 'https://apiproductmanagmentteamint.azurewebsites.net';
  final List<CupboardAvailable> productList = [];
  late CupboardAvailable selectCupboard;
  final storage = const FlutterSecureStorage();
  bool isloading = true;

  ReportCupboardService() {
    loadCupboard();
  }

  Future<List<CupboardAvailable>> loadCupboard() async {
    notifyListeners();

    final url = Uri.parse('$_baseUrl/api/CupboardDetails');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> cupboardMap = json.decode(resp.body);

    cupboardMap.forEach((value) {
      final response = CupboardAvailable.fromMap(value);
      productList.add(response);
    });

    isloading = false;
    notifyListeners();

    return productList;
  }
}
