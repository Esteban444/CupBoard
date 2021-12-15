import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:appcupboard/models/mark.dart';

class MarkService extends ChangeNotifier {
  final _baseUrl = 'https://apiproductmanagmentteamint.azurewebsites.net';
  final List<Mark> marks = [];
  late Mark selectedMark;

  final storage = FlutterSecureStorage();

  bool isLoading = true;

  MarkService() {
    this.loadMarks();
  }

  Future<List<Mark>> loadMarks() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_baseUrl/api/Trademarks');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> marksMap = json.decode(resp.body);

    marksMap.forEach((mark) {
      final tempCategory = Mark.fromMap(mark);

      this.marks.add(tempCategory);
    });
    this.isLoading = false;
    notifyListeners();
    return this.marks;
  }

  Future saveOrCreateMark(Mark mark) async {
    // ignore: unnecessary_null_comparison
    if (mark.idTrademark == null) {
      await this.createMark(mark);
    } else {
      await this.updateMark(mark);
    }
  }

  Future<String?> createMark(Mark mark) async {
    final url = Uri.parse('$_baseUrl/api/Trademarks');

    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response resp = await http.post(url,
        headers: requestHeaders, body: jsonEncode(mark.toJson()));

    final decodedData = json.decode(resp.body);

    mark.idTrademark = decodedData['name'];

    this.marks.add(mark);
    notifyListeners();

    return mark.idTrademark;
  }

  Future<String?> updateMark(Mark mark) async {
    final url = Uri.parse('$_baseUrl/api/Trademarks/${mark.idTrademark}');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // ignore: unused_local_variable
    final resp = await http.put(url,
        headers: requestHeaders, body: jsonEncode(mark.toJson()));

    final index =
        this.marks.indexWhere((e) => e.idTrademark == mark.idTrademark);
    this.marks[index] = mark;

    notifyListeners();

    return mark.idTrademark!;
  }

  Future<String> deleteMark(String idTrademarks) async {
    final url = Uri.parse('$_baseUrl/api/Trademarks/$idTrademarks');

    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // ignore: unused_local_variable
    final resp = await http.delete(url, headers: requestHeaders);

    notifyListeners();
    marks.clear();
    loadMarks();
    return idTrademarks;
  }
}
