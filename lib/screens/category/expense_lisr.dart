import 'package:flutter/material.dart';

import 'package:money_management/models/db/cate/cate_db.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Categorydb().expenseCAtegorylistlistener,
        builder: (ctx, newList, _) {
          return ListView.separated(
              itemBuilder: ((context, index) {
                final category = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          Categorydb.instance.deletecategory(category.id);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                );
              }),
              separatorBuilder: ((context, index) {
                return SizedBox(height: 10);
              }),
              itemCount: newList.length);
        });
  }
}
