import 'package:flutter/material.dart';
import 'package:appcupboard/models/cupboard.dart';

class CupBoardProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late CupBoard cupModel;
  late CupBoardDetail cupDetail;

  CupBoardProvider(
    this.cupModel,
    this.cupDetail,
  );

  updateIsDefault(bool value) {
    this.cupModel.isDefault = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
