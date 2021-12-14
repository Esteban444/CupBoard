import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:appcupboard/models/cupboard.dart';
import 'package:appcupboard/models/detail_cupboard.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CupBoardService extends ChangeNotifier {
  final List<CupBoard> cupboards = [];
  late CupBoard selectCupboard;

  final List<CupBoardDetail> cupboardDet = [];
  late CupBoardDetail selectCupboardDet;

  final List<CupBoardModel> cupboard = [];
  late CupBoardModel selectCupboardm;

  final storage = const FlutterSecureStorage();
  bool isSaving = false;
  bool isloading = true;

  CupBoardService() {
    loadCupboard();
  }

  Future<List<CupBoardModel>> loadCupboard() async {
    isloading = true;
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
      cupboard.add(response);
    });

    isloading = false;
    notifyListeners();

    return cupboard;
  }

  Future saveOrUpdateCupboard(
      CupBoard cupboard, CupBoardDetail cupBoardDetail) async {
    isSaving = true;
    notifyListeners();

    if (cupboard.idCupBoard == null) {
      await saveCupboard(cupboard, cupBoardDetail);
    } else {}

    isSaving = false;
    notifyListeners();
  }

  Future<String?> saveCupboard(
      CupBoard cupboard, CupBoardDetail cupBoardDetail) async {
    final url =
        Uri.parse('https://10.0.2.2:5001/api/CupBoard/Create-cupboard-Detail');
    final token = await storage.read(key: 'token');

    final Map<String, dynamic> cupboardData = {
      'nameCupBoard': cupboard.nameCupBoard,
      'isDefault': cupboard.isDefault,
      'creationDate': cupboard.creationDate,
      'cupBoardDetails': [cupBoardDetail],
    };

    Map<String, String> requesHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final resp = await http.post(url,
        headers: requesHeaders, body: jsonEncode(cupboardData));
    final data = json.decode(resp.body);
    cupboard.idCupBoard = data['idCupBoard'];

    notifyListeners();
    cupboards.clear();
    loadCupboard();
    return cupboard.idCupBoard;
  }

  Future<String?> updateDetail(CupBoardModel model) async {
    final url = Uri.parse(
        'https://10.0.2.2:5001/api/CupboardDetails/${model.idCupboardDetail}');
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
      body: jsonEncode(model.toJson()),
    );

    final index = cupboard.indexWhere(
        (element) => element.idCupboardDetail == model.idCupboardDetail);
    cupboard[index] = model;

    notifyListeners();
    return model.idCupboardDetail;
  }

  Future<String> deleteCupboard(String idCupboard) async {
    final url = Uri.parse('https://10.0.2.2:5001/api/CupBoard/$idCupboard');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    await http.delete(url, headers: requestHeaders);
    notifyListeners();
    cupboards.clear();
    loadCupboard();
    return idCupboard;
  }
}
