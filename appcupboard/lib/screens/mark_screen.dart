import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/services/services.dart';

import 'package:appcupboard/models/mark.dart';
import 'package:appcupboard/widgets/appbar.dart';

class MarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final markService = Provider.of<MarkService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks'),
      ),
      drawer: MenuAppBar(),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
            itemCount: markService.marks.length,
            itemBuilder: (BuildContext context, int index) {
              return _CardContainer(
                mark: markService.marks[index],
              );
            }),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo[600],
          onPressed: () => {
                markService.selectedMark = Mark(mark: ''),
                Navigator.pushNamed(context, 'detailmark')
              }),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Mark mark;

  const _CardContainer({Key? key, required this.mark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markService = Provider.of<MarkService>(context);
    final index =
        markService.marks.indexWhere((e) => e.idTrademark == mark.idTrademark);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(top: 20, bottom: 20),
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${mark.mark}',
              style: TextStyle(fontSize: 25),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    markService.selectedMark = markService.marks[index];
                    Navigator.pushNamed(context, 'detailmark');
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
                        title: Text('¿Are you sure to delete ${mark.mark}?'),
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
                              await markService
                                  .deleteMark('${mark.idTrademark}');
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
