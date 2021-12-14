import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:appcupboard/models/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final List<Products> products = [];
  late Products selectProducts;

  final storage = FlutterSecureStorage();

  bool isloading = true;

  ProductsService() {
    loadProduct();
  }

  Future<List<Products>> loadProduct() async {
    this.isloading = true;
    notifyListeners();

    final url = Uri.parse('https://10.0.2.2:5001/api/Products');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> productMap = json.decode(resp.body);

    productMap.forEach((value) {
      final response = Products.fromMap(value);
      this.products.add(response);
    });

    this.isloading = false;
    notifyListeners();
    return this.products;
  }

  Future saveOrUpdateProduct(Products product) async {
    notifyListeners();

    if (product.idProduct == null) {
      await saveProduct(product);
    } else {
      updateProduct(product);
    }

    notifyListeners();
  }

  Future<String?> saveProduct(Products product) async {
    final url = Uri.parse('https://10.0.2.2:5001/api/Products');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final resp = await http.post(url,
        headers: requestHeaders, body: jsonEncode(product.toJson()));
    final respuesta = json.decode(resp.body);
    product.idProduct = respuesta['idProduct'];
    print('respuesta product: $respuesta');

    products.clear();
    loadProduct();

    notifyListeners();
    return product.idProduct;
  }

  Future<String?> updateProduct(Products product) async {
    final url =
        Uri.parse('https://10.0.2.2:5001/api/Products/${product.idProduct}');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // ignore: unused_local_variable
    final resp = await http.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(product.toJson()),
    );

    final index = products
        .indexWhere((element) => element.idProduct == product.idProduct);
    products[index] = product;

    notifyListeners();
    return product.idProduct;
  }

  Future<String> deleteProduct(String idProduct) async {
    final url = Uri.parse('https://10.0.2.2:5001/api/Products/$idProduct');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // ignore: unused_local_variable
    final resp = await http.delete(url, headers: requestHeaders);
    notifyListeners();
    products.clear();
    loadProduct();
    return idProduct;
  }
}
