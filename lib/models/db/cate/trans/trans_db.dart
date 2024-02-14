// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

const Transaction_db_name = 'transaction-db';

abstract class transactiondbfun {
  Future<List<Transactionmodel>> getTrans();
  Future<void> addtrans(Transactionmodel obj);
  Future<void> deletetrans(String TransID);
}

class Transactiondb implements transactiondbfun {
  Transactiondb._internal();

  static Transactiondb instance = Transactiondb._internal();
  factory Transactiondb() {
    return instance;
  }

  // ignore: non_constant_identifier_names
  ValueNotifier<List<Transactionmodel>> Transvaluenoti = ValueNotifier([]);

  @override
  Future<void> addtrans(Transactionmodel obj) async {
    final transdb = await Hive.openBox<Transactionmodel>(Transaction_db_name);
    transdb.put(obj.Id, obj);
  }

  @override
  Future<List<Transactionmodel>> getTrans() async {
    final transdb = await Hive.openBox<Transactionmodel>(Transaction_db_name);

    return transdb.values.toList();
  }

  Future<void> refreshui() async {
    final _list = await getTrans();
    _list.sort((first, second) => first.datetime.compareTo(second.datetime));
    Transvaluenoti.value.clear();
    Transvaluenoti.value.addAll(_list);
    Transvaluenoti.notifyListeners();
  }

  @override
  Future<void> deletetrans(String TransID) async {
    final transdb = await Hive.openBox<Transactionmodel>(Transaction_db_name);
    transdb.delete(TransID);
    refreshui();
  }
}
