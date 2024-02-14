// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/db/cate/cate_db.dart';

ValueNotifier<Categorytype> selectCategorynotu =
    ValueNotifier(Categorytype.income);

Future<void> showCateaddpopup(BuildContext context) async {
  final _nameeditingcontroller = TextEditingController();

  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameeditingcontroller,
                decoration: InputDecoration(
                    hintText: 'add category',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'income', type: Categorytype.income),
                  RadioButton(title: 'Expense', type: Categorytype.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameeditingcontroller.text;
                    if (_name.isEmpty) {
                      return;
                    } else {
                      final _type = selectCategorynotu.value;
                      final _category = Categorymodel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _name,
                          type: _type);

                      Categorydb.instance.insertCategory(_category);
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: Text('Add')),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final Categorytype type;

  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectCategorynotu,
            builder: (ctx, newCategory, _) {
              return Radio<Categorytype>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectCategorynotu.value = value;
                  selectCategorynotu.notifyListeners();
                },
              );
            }),
        Text(title),
      ],
    );
  }
}
