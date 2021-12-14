import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/widgets/home/card_cupboard_report.dart';
import 'package:appcupboard/services/services.dart';

class ListCupBoardScreen extends StatelessWidget {
  const ListCupBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cupboardService = Provider.of<ReportCupboardService>(context);
    //if(cupboardService.isloading) return const Loading();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products available'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
            itemCount: cupboardService.productList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListCupboardCardReport(
                  cupboard: cupboardService.productList[index], height: 110);
            }),
      ),
    );
  }
}
