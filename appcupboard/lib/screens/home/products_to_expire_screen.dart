import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/services/produt_to_expired_service.dart';
import 'package:appcupboard/widgets/home/Card_to_expired.dart';

class ScreenToExpire extends StatelessWidget {
  const ScreenToExpire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toExpireService = Provider.of<ProductToExpireService>(context);
    //if(toExpireService.isloading) return const Loading();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products to expire'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
            itemCount: toExpireService.productToExpire.length,
            itemBuilder: (BuildContext context, int index) {
              return ToExpireCard(
                  toExpire: toExpireService.productToExpire[index],
                  height: 110);
            }),
      ),
    );
  }
}
