import 'package:appcupboard/providers/editting_cupboard_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:appcupboard/models/product.dart';
import 'package:appcupboard/services/services.dart';

import 'package:appcupboard/iu/input_decorations.dart';

class EdittingCupBoardDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cupboardService = Provider.of<CupBoardService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editting Detail'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_) =>
                EdittingCupBoardProvider(cupboardService.selectCupboardm),
            child: _CupBoardForm(
              cupboardService: cupboardService,
            ),
          )),
    );
  }
}

class _CupBoardForm extends StatelessWidget {
  final CupBoardService cupboardService;

  const _CupBoardForm({Key? key, required this.cupboardService})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productservice = Provider.of<ProductsService>(context);
    final cupboardForm = Provider.of<EdittingCupBoardProvider>(context);

    final newDetail = cupboardForm.cupDetail;

    return Container(
      child: Form(
        key: cupboardForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                icon: Icon(Icons.arrow_downward),
                isExpanded: true,
                iconEnabledColor: Colors.indigo,
                underline: Container(
                  height: 1,
                  color: Colors.indigo,
                ),
                hint: Text('Select product'),
                value: cupboardForm.cupDetail.idProduct,
                items: productservice.products
                    .map<DropdownMenuItem<String>>((Products value) {
                  return DropdownMenuItem<String>(
                    value: value.idProduct,
                    child: Text(value.nameProduct),
                  );
                }).toList(),
                onChanged: (value) =>
                    cupboardForm.selectValue(value.toString()),
              ),
              SizedBox(height: 10),
              TextFormField(
                autocorrect: false,
                initialValue: newDetail.amount.toString(),
                //keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Amount',
                    labelText: 'Amount',
                    prefixIcon: Icons.confirmation_number),
                onChanged: (value) => newDetail.amount = value,
                validator: (value) {
                  return (value != null && value.length >= 1)
                      ? null
                      : 'El campo solo acepta numeros';
                },
              ),
              SizedBox(height: 10),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                dateMask: 'd MMM, yyyy',
                //icon: Icon(Icons.event),
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Date entry',
                  labelText: 'Date entry',
                ),
                initialValue: newDetail.entryDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                dateLabelText: 'Date entry',
                onChanged: (val) {
                  newDetail.entryDate = val;
                  print(val);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es requerido';
                  }
                },
                onSaved: (val) => print("valor print $val"),
              ),
              SizedBox(height: 10),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                dateMask: 'd MMM, yyyy',
                //icon: Icon(Icons.event),
                initialValue: newDetail.exitDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                dateLabelText: 'Date exit',
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Date exit',
                  labelText: 'Date exit',
                ),
                onChanged: (val) {
                  newDetail.exitDate = val;
                  print(val);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es requerido';
                  }
                },
                onSaved: (val) => print("valor print $val"),
              ),
              SizedBox(height: 10),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                dateMask: 'd MMM, yyyy',
                initialValue: newDetail.expirationDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                dateLabelText: 'Date expire',
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Date expire',
                  labelText: 'Date expire',
                ),
                onChanged: (val) {
                  newDetail.expirationDate = val;
                  print(val);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es requerido';
                  }
                },
                onSaved: (val) => print("valor print $val"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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

                        if (!cupboardForm.isValidForm()) return;
                        await cupboardService
                            .updateDetail(cupboardForm.cupDetail);
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
                      onPressed: () async {
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
