import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/db/cate/cate_db.dart';
import 'package:money_management/models/db/cate/trans/trans_db.dart';

class Trans extends StatelessWidget {
  const Trans({super.key});

  @override
  Widget build(BuildContext context) {
    Transactiondb.instance.refreshui();
    Categorydb.instance.refreshui();
    return ValueListenableBuilder(
        valueListenable: Transactiondb.instance.Transvaluenoti,
        builder: (context, _newvalue, _) {
          return ListView.separated(
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final transaction = _newvalue[index];
              return Slidable(
                key: Key(transaction.Id!),
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        Transactiondb.instance.deletetrans(transaction.Id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Colors.red,
                    )
                  ],
                ),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      foregroundColor: Colors.black,
                      child: Text(
                        parseDate(transaction.datetime),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: transaction.type == Categorytype.income
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text('Rs ${transaction.amount}'),
                    subtitle: Text(transaction.purpose),
                    trailing: IconButton(
                        onPressed: () {
                          Transactiondb.instance.deletetrans(transaction.Id!);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: _newvalue.length,
          );
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitteddate = _date.split(' ');
    return '${_splitteddate.last}\n${_splitteddate.first}';
    // return '${date.day}/${date.month}';
  }
}
