import 'package:appcupboard/models/cupboard.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CupBoardService extends ChangeNotifier {
  final List<CupBoard> cupboardDetail = [];
  late CupBoard selectCupboardDetail;

  final List<CupBoardDetail> cupboardDet = [];
  late CupBoardDetail selectCupboardDet;

  final List<CupBoard> cupboards = [];
  late CupBoard selectCupboard;

  final storage = const FlutterSecureStorage();
  bool isSaving = false;
  bool isloading = true;

  CupBoardService() {
    loadCupboard();
  }

  Future<List<CupBoard>> loadCupboard() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse('https://10.0.2.2:5001/api/CupBoard');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> cupboardMap = json.decode(resp.body);

    cupboardMap.forEach((value) {
      final response = CupBoard.fromMap(value);
      cupboards.add(response);
    });

    isloading = false;
    notifyListeners();

    return cupboards;
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

    //cupboardDetail.add(cupboardModel);
    print(data);

    notifyListeners();
    cupboards.clear();
    loadCupboard();
    return cupboard.idCupBoard;
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
