import 'package:appcupboard/services/produt_to_expired_service.dart';
import 'package:appcupboard/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/widgets/home/card_home.dart';
import 'package:appcupboard/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final producToExpire = Provider.of<ProductToExpireService>(context);
    final expiredProducts = Provider.of<ExpiredProdutService>(context);
    final productlistcupboard = Provider.of<ReportCupboardService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MenuAppBar(),
      body: Container(
        color: Colors.black12,
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 10.0,
              children: <Widget>[
                CardHome(
                  icon: Icons.warning_amber_outlined,
                  color: Colors.amber,
                  texto: producToExpire.productToExpire.length == 1
                      ? "${producToExpire.productToExpire.length} Products that are about to expire"
                      : "${producToExpire.productToExpire.length} Products that are about to expire",
                  button: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      //minWidth: double.infinity,
                      color: Colors.indigo[600],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: const Text(
                          'Detalle',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'toExpire');
                      }),
                ),
                CardHome(
                  icon: Icons.warning_amber_outlined,
                  color: Colors.red,
                  texto: expiredProducts.expiredProduct.length == 1
                      ? "${expiredProducts.expiredProduct.length} Products that are expired"
                      : "${expiredProducts.expiredProduct.length} Products that are expired",
                  button: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      //minWidth: double.infinity,
                      color: Colors.indigo[600],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: const Text(
                          'Detalle',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'expiredProduct');
                      }),
                ),
                CardHome(
                  icon: Icons.checklist_rounded,
                  color: Colors.green,
                  texto:
                      "${productlistcupboard.productList.length} Products available",
                  button: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      //minWidth: double.infinity,
                      color: Colors.indigo[600],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: const Text(
                          'Detalle',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'available');
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
