import 'package:flutter/material.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/db/cate/cate_db.dart';
import 'package:money_management/models/db/cate/trans/trans_db.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class AddtransactionSCreen extends StatefulWidget {
  static const routename = 'add-transaction';
  const AddtransactionSCreen({super.key});

  @override
  State<AddtransactionSCreen> createState() => _AddtransactionSCreenState();
}

class _AddtransactionSCreenState extends State<AddtransactionSCreen> {
  DateTime? _selecteddate;
  Categorytype? _selectedcategorytype;
  Categorymodel? _selectedcategorymodel;

  String? _cateid;

  TextEditingController _purposecontroller = TextEditingController();
  TextEditingController _amountcontroller = TextEditingController();

  @override
  void initState() {
    _selectedcategorytype = Categorytype.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: _purposecontroller,
                decoration: const InputDecoration(
                    hintText: 'Purpose', border: OutlineInputBorder()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              TextButton.icon(
                  onPressed: () async {
                    final _showdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 30)),
                        lastDate: DateTime.now());

                    if (_showdate == null) {
                      return;
                    } else {
                      print(_showdate.toString());
                      setState(() {
                        _selecteddate = _showdate;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text(_selecteddate == null
                      ? 'Add Date'
                      : _selecteddate!.toString())),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: Categorytype.income,
                          groupValue: _selectedcategorytype,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedcategorytype = Categorytype.income;
                              _cateid = null;
                            });
                          }),
                      const Text('Income')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: Categorytype.expense,
                          groupValue: _selectedcategorytype,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedcategorytype = Categorytype.expense;
                              _cateid = null;
                            });
                          }),
                      const Text('Expense')
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                hint: const Text('select category'),
                value: _cateid,
                items: (_selectedcategorytype == Categorytype.income
                        ? Categorydb().incomeCAtegorylistlistener
                        : Categorydb().expenseCAtegorylistlistener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedcategorymodel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _cateid = selectedValue;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    addTrans();
                  },
                  child: const Text('Submit'))
            ],
          ),
        )),
      ),
    );
  }

  Future<void> addTrans() async {
    final _purposetext = _purposecontroller.text;
    final _amounttext = _amountcontroller.text;

    if (_purposetext.isEmpty) {
      return;
    }
    if (_amounttext.isEmpty) {
      return;
    }

    // if (_cateid == null) {
    //   return;
    // }
    if (_selecteddate == null) {
      return;
    }

    final _parsedamount = double.tryParse(_amounttext);
    if (_parsedamount == null) {
      return;
    }
    if (_selectedcategorymodel == null) {
      return;
    }

    final _model = Transactionmodel(
        purpose: _purposetext,
        amount: _parsedamount,
        datetime: _selecteddate!,
        type: _selectedcategorytype!,
        category: _selectedcategorymodel!);

    await Transactiondb.instance.addtrans(_model);

    Navigator.of(context).pop();
    Transactiondb.instance.refreshui();
  }
}
