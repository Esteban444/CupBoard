import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:appcupboard/models/expired_product.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ExpiredProdutService extends ChangeNotifier {
  final List<ExpiredProduct> expiredProduct = [];
  final storage = FlutterSecureStorage();
  bool isloading = true;

  ExpiredProdutService() {
    getExpiredProduct();
  }

  Future<List<ExpiredProduct>> getExpiredProduct() async {
    notifyListeners();

    final url =
        Uri.parse('https://10.0.2.2:5001/api/CupboardDetails/expired-products');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> productToExpMap = json.decode(resp.body);

    productToExpMap.forEach((value) {
      final response = ExpiredProduct.fromMap(value);
      expiredProduct.add(response);
    });

    isloading = false;
    notifyListeners();

    return expiredProduct;
  }
}
