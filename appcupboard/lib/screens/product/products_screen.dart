import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/models/product.dart';
import 'package:appcupboard/services/services.dart';
import 'package:appcupboard/widgets/appbar.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      drawer: MenuAppBar(),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
            itemCount: productService.products.length,
            itemBuilder: (BuildContext context, int index) {
              return _CardContainer(product: productService.products[index]);
            }),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo[600],
          onPressed: () {
            productService.selectProducts = Products(
                nameProduct: '',
                idMark: productService.products.first.idMark,
                barCode: '');
            Navigator.pushNamed(context, 'detailproduct');
          }),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Products product;

  const _CardContainer({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final index = productService.products
        .indexWhere((e) => e.idProduct == product.idProduct);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(top: 20, bottom: 20),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${product.nameProduct}',
              style: TextStyle(fontSize: 25),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'mark: ${product.trademark!.mark}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'BarCode: ${product.barCode}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    productService.selectProducts =
                        productService.products[index];
                    Navigator.pushNamed(context, 'detailproduct');
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
                        title: Text(
                            '¿Are you sure to delete ${product.nameProduct}?'),
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
                              await productService
                                  .deleteProduct('${product.idProduct}');
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
          color: Colors.white70,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 8), blurRadius: 10)
          ]);
}
