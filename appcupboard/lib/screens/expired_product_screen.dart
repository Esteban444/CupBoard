import 'package:appcupboard/services/services.dart';
import 'package:appcupboard/widgets/home/card_expired_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpireProductScreen extends StatelessWidget {
  const ExpireProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expireProducService = Provider.of<ExpiredProdutService>(context);
    //if(expireProducService.isloading) return const Loading();

    return Scaffold(
      appBar: AppBar(
        title: Text('Products expired'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
            itemCount: expireProducService.expiredProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpireProdCard(
                  expired: expireProducService.expiredProduct[index],
                  height: 110);
            }),
      ),
    );
  }
}
