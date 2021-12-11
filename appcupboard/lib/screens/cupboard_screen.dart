import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jiffy/jiffy.dart';

import 'package:appcupboard/models/detail_cupboard.dart';
import 'package:appcupboard/services/services.dart';
import 'package:appcupboard/models/cupboard.dart';

import 'package:appcupboard/widgets/appbar.dart';

class CupBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cupboardservice = Provider.of<CupBoardService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('CupBoards'),
      ),
      drawer: MenuAppBar(),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
            itemCount: cupboardservice.cupboard.length,
            itemBuilder: (BuildContext context, int index) {
              return _CardCupBoard(
                cupboard: cupboardservice.cupboard[index],
              );
            }),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo[600],
          onPressed: () {
            cupboardservice.selectCupboard = CupBoard(
              nameCupBoard: '',
              isDefault: true,
              creationDate: '',
            );
            cupboardservice.selectCupboardDet = CupBoardDetail(
                idCupBoard: '',
                idProduct: '',
                amount: '',
                entryDate: '',
                exitDate: '',
                expirationDate: '');
            Navigator.pushNamed(context, 'detailcupboard');
          }),
    );
  }
}

class _CardCupBoard extends StatelessWidget {
  final CupBoardModel cupboard;

  const _CardCupBoard({Key? key, required this.cupboard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cupboardService = Provider.of<CupBoardService>(context);
    final index = cupboardService.cupboards
        .indexWhere((e) => e.idCupBoard == cupboard.idCupBoard);

    //final fecha = Jiffy(cupboard.)

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
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product: ${cupboard.product!.nameProduct}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Amount: ${cupboard.amount}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Entry: ${Jiffy(cupboard.entryDate).format('dd-MM-yyyy')}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Exit: ${Jiffy(cupboard.exitDate).format('dd-MM-yyyy')}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Expiration: ${Jiffy(cupboard.expirationDate).format('dd-MM-yyyy')}',
              style: TextStyle(fontSize: 25),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    cupboardService.selectCupboard =
                        cupboardService.cupboards[index];
                    Navigator.pushNamed(context, 'detailcupboard');
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
                        title: Text('¿Are you sure to delete?'),
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
                              await cupboardService
                                  .deleteCupboard('${cupboard.idCupBoard}');
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
