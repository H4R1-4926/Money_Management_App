import 'package:flutter/material.dart';

import 'package:money_management/screens/category/category.dart';
import 'package:money_management/screens/category/popup_cate.dart';
import 'package:money_management/screens/home/widgets/bottom.dart';

import 'package:money_management/screens/trans/trans.dart';
import 'package:money_management/screens/trans/transaction_add.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  static ValueNotifier<int> selectedindexnotifier = ValueNotifier(0);

  final _page = const [Trans(), Categorys()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 238, 248, 255),
          appBar: AppBar(
            title: const Center(child: Text('MONEY MANAGER')),
          ),
          body: SafeArea(
            child: ValueListenableBuilder(
                valueListenable: selectedindexnotifier,
                builder: (BuildContext context, int updatedindex, _) {
                  return _page[updatedindex];
                }),
          ),
          bottomNavigationBar: const Btmnav(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (selectedindexnotifier.value == 0) {
                print('add trans');
                Navigator.of(context).pushNamed(AddtransactionSCreen.routename);
              } else {
                print('add cate');

                showCateaddpopup(context);
              }
            },
            child: const Icon(Icons.add),
          )),
    );
  }
}
