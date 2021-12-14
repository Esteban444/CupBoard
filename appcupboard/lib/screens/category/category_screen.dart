import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/models/category.dart';
import 'package:appcupboard/services/category_service.dart';

import 'package:appcupboard/widgets/appbar.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      drawer: MenuAppBar(),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
            itemCount: categoryService.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return _CardContainer(
                category: categoryService.categories[index],
              );
            }),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo[600],
          onPressed: () {
            categoryService.selectedCategory = Category(name: '');
            Navigator.pushNamed(context, 'detailcategory');
          }),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Category category;

  const _CardContainer({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    final index = categoryService.categories
        .indexWhere((e) => e.idcategory == category.idcategory);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${category.name}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    categoryService.selectedCategory =
                        categoryService.categories[index];
                    Navigator.pushNamed(context, 'detailcategory');
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.withOpacity(0.8),
                  ),
                  onPressed: () {
                    final dialog = AlertDialog(
                        title:
                            Text('¿Are you sure to delete ${category.name}?'),
                        content: Text('Delete'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No')),
                          TextButton(
                            child: Text('Yes, Delete'),
                            onPressed: () async {
                              await categoryService
                                  .deleteCategory('${category.idcategory}');
                              Navigator.of(context).pop();
                            },
                          ),
                        ]);

                    showDialog(context: context, builder: (_) => dialog);
                  },
                )
              ],
            ),
          ],
        ),
        decoration: _cardDecoration(),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 8), blurRadius: 10)
          ]);
}
