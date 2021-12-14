import 'package:flutter/material.dart';

import 'package:appcupboard/models/product.dart';

class ProductsProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late Products product;

  ProductsProvider(this.product);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  selectValue(String value) {
    product.idMark = value;
    notifyListeners();
  }

  bool isValidForm() {
    return (formKey.currentState?.validate() ?? false);
  }
}
