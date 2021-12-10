import 'package:appcupboard/models/mark.dart';
import 'package:flutter/material.dart';

class MarkProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  late Mark mark;

  MarkProvider(this.mark);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return (formKey.currentState?.validate() ?? false);
  }
}
