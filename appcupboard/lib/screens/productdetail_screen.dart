import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/models/mark.dart';
import 'package:appcupboard/services/services.dart';
import 'package:appcupboard/providers/product_provider.dart';

import 'package:appcupboard/iu/input_decorations.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_) => ProductsProvider(productService.selectProduct),
            child: _ProductForm(productService: productService),
          )),
    );
  }
}

class _ProductForm extends StatelessWidget {
  final ProductsService productService;

  const _ProductForm({Key? key, required this.productService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markService = Provider.of<MarkService>(context);

    final productForm = Provider.of<ProductsProvider>(context);
    final newproduct = productForm.product;
    // ignore: unused_local_variable
    String _value = newproduct.idMark;

    return Container(
      child: Form(
        key: productForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              initialValue: newproduct.nameProduct,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Name',
                  labelText: 'Name product',
                  prefixIcon: Icons.agriculture),
              onChanged: (value) => newproduct.nameProduct = value,
              validator: (value) {
                return (value != null && value.length >= 2)
                    ? null
                    : 'La nombre debe de ser mayor a 3 caracteres';
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              iconEnabledColor: Colors.indigo,
              underline: Container(
                height: 1,
                color: Colors.indigo,
              ),
              hint: const Text('Select Mark'),
              selectedItemBuilder: (BuildContext context) {
                return markService.marks.map<Widget>((Mark item) {
                  return Text('item ${item.mark}');
                }).toList();
              },
              items:
                  markService.marks.map<DropdownMenuItem<String>>((Mark value) {
                return DropdownMenuItem<String>(
                  value: value.idTrademark,
                  child: Text(value.mark),
                );
              }).toList(),
              onChanged: (value) {
                newproduct.idMark = value.toString();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Bar Code',
                  labelText: 'Bar code',
                  prefixIcon: Icons.bar_chart),
              onChanged: (value) => newproduct.barCode = value,
              validator: (value) {
                return (value != null) ? null : 'Codigo de barras no valido.';
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Colors.indigo[600],
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        )),
                    onPressed: () async {
                      FocusScope.of(context).unfocus(); // quitar el teclado.

                      if (!productForm.isValidForm()) return;
                      await productService
                          .saveOrUpdateProduct(productForm.product);
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  height: 10,
                  width: 20,
                ),
                MaterialButton(
                    minWidth: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Colors.blueGrey,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        )),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
