import 'package:flutter/material.dart';
import 'package:money_management/models/db/cate/cate_db.dart';
import 'package:money_management/screens/category/expense_lisr.dart';
import 'package:money_management/screens/category/income.dart';

class Categorys extends StatefulWidget {
  const Categorys({super.key});

  @override
  State<Categorys> createState() => _CategorysState();
}

class _CategorysState extends State<Categorys>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    Categorydb().refreshui();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expense',
            )
          ]),
      Expanded(
          child: TabBarView(
              controller: _tabController,
              children: const [Incomecategorylist(), Expenselist()]))
    ]);
  }
}
