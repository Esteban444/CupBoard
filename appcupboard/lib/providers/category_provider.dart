import 'package:flutter/material.dart';
import 'package:appcupboard/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  late Category category;

  CategoryProvider(this.category);

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
