import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:appcupboard/models/category.dart';

class CategoryService extends ChangeNotifier {
  final List<Category> categories = [];
  late Category selectedCategory;

  final storage = FlutterSecureStorage();

  bool isLoading = true;

  CategoryService() {
    this.loadCategories();
  }

  Future<List<Category>> loadCategories() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://10.0.2.2:5001/api/Categories');

    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> categoriesMap = json.decode(resp.body);

    categoriesMap.forEach((value) {
      final tempCategory = Category.fromMap(value);

      this.categories.add(tempCategory);
    });
    this.isLoading = false;
    notifyListeners();
    return this.categories;
  }

  Future saveOrCreateCategory(Category category) async {
    // ignore: unnecessary_null_comparison
    if (category.idcategory == null) {
      await this.createCategory(category);
    } else {
      // Actualizar
      await this.updateCategory(category);
    }
    notifyListeners();
  }

  Future<String?> updateCategory(Category category) async {
    final url = Uri.parse(
        'https://10.0.2.2:5001/api/Categories/${category.idcategory}');

    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // ignore: unused_local_variable
    final resp = await http.put(url,
        headers: requestHeaders, body: jsonEncode(category.toJson()));
    //final decodedData = resp.body;

    final index = this
        .categories
        .indexWhere((element) => element.idcategory == category.idcategory);
    this.categories[index] = category;

    return category.idcategory!;
  }

  Future<String?> createCategory(Category category) async {
    final url = Uri.parse('https://10.0.2.2:5001/api/Categories');

    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final resp = await http.post(url,
        headers: requestHeaders, body: jsonEncode(category.toJson()));

    final decodedData = json.decode(resp.body);

    category.idcategory = decodedData['name'];

    this.categories.add(category);
    notifyListeners();

    return category.idcategory;
  }

  Future<String> deleteCategory(String idCategory) async {
    final url = Uri.parse('https://10.0.2.2:5001/api/Categories/$idCategory');

    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // ignore: unused_local_variable
    final resp = await http.delete(url, headers: requestHeaders);

    notifyListeners();
    categories.clear();
    loadCategories();
    return idCategory;
  }
}
