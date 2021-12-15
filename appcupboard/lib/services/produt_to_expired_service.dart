import 'dart:convert';

import 'package:appcupboard/models/product_to_expire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProductToExpireService extends ChangeNotifier {
  final _baseUrl = 'https://apiproductmanagmentteamint.azurewebsites.net';
  final List<ProductToExpire> productToExpire = [];
  final storage = FlutterSecureStorage();
  bool isloading = true;

  ProductToExpireService() {
    getProductToExpire();
  }

  Future<List<ProductToExpire>> getProductToExpire() async {
    notifyListeners();

    final url = Uri.parse('$_baseUrl/api/CupboardDetails/productsNextToExpire');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> productToExpMap = json.decode(resp.body);

    productToExpMap.forEach((value) {
      final response = ProductToExpire.fromMap(value);
      productToExpire.add(response);
    });

    isloading = false;
    notifyListeners();

    return productToExpire;
  }
}
