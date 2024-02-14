import 'package:flutter/material.dart';

import '../../models/db/cate/cate_db.dart';

class Incomecategorylist extends StatelessWidget {
  const Incomecategorylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Categorydb().incomeCAtegorylistlistener,
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
