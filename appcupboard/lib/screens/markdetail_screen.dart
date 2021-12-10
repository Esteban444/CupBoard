import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/providers/mark_providers.dart';

import 'package:appcupboard/services/services.dart';

import 'package:appcupboard/iu/input_decorations.dart';

class MarkDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final markService = Provider.of<MarkService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_) => MarkProvider(markService.selectedMark),
            child: _MarkForm(
              markService: markService,
            ),
          )),
    );
  }
}

class _MarkForm extends StatelessWidget {
  final MarkService markService;

  const _MarkForm({Key? key, required this.markService}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final markForm = Provider.of<MarkProvider>(context);
    final newmark = markForm.mark;
    return Container(
      child: Form(
        key: markForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              initialValue: newmark.mark,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Name',
                  labelText: 'Name mark',
                  prefixIcon: Icons.mark_as_unread),
              onChanged: (value) => newmark.mark = value,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        )),
                    onPressed: () async {
                      FocusScope.of(context).unfocus(); // quitar el teclado.

                      if (!markForm.isValidForm()) return;
                      await markService.saveOrCreateMark(markForm.mark);
                      Navigator.pushReplacementNamed(context, 'mark');
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
                    onPressed: () {
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
