import 'package:flutter/material.dart';
import 'package:appcupboard/models/detail_cupboard.dart';

class EdittingCupBoardProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late CupBoardModel cupDetail;

  EdittingCupBoardProvider(
    this.cupDetail,
  );

  selectValue(String value) {
    cupDetail.idProduct = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
