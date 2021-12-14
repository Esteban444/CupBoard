import 'package:appcupboard/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/providers/category_provider.dart';

import 'package:appcupboard/iu/input_decorations.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CategoryProvider(categoryService.selectedCategory),
        child: _CategoryForm(categoryService: categoryService),
      ),
    );
  }
}

class _CategoryForm extends StatelessWidget {
  final CategoryService categoryService;

  const _CategoryForm({Key? key, required this.categoryService})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryProvider>(context);
    final newcategory = categoryForm.category;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Form(
          key: categoryForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                initialValue: newcategory.name,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Name',
                    labelText: 'Name Category',
                    prefixIcon: Icons.category),
                onChanged: (value) => newcategory.name = value,
                validator: (value) {
                  return (value != null && value.length >= 3)
                      ? null
                      : 'La nombre debe de ser mayor a 3 caracteres';
                },
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.indigo[600],
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          )),
                      onPressed: () async {
                        FocusScope.of(context).unfocus(); // quitar el teclado.

                        if (!categoryForm.isValidForm()) return;
                        await categoryService
                            .saveOrCreateCategory(categoryForm.category);

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
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
