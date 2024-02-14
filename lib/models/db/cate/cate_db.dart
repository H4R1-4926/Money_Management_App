// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/category/category_model.dart';

const category_db_name = 'category-database';

abstract class CateDBfun {
  Future<List<Categorymodel>> getcategories();
  Future<void> insertCategory(Categorymodel value);
  Future<void> deletecategory(String categoryID);
}

class Categorydb implements CateDBfun {
  Categorydb._internal();

  static Categorydb instance = Categorydb._internal();
  factory Categorydb() {
    return instance;
  }

  ValueNotifier<List<Categorymodel>> incomeCAtegorylistlistener =
      ValueNotifier([]);
  ValueNotifier<List<Categorymodel>> expenseCAtegorylistlistener =
      ValueNotifier([]);
  @override
  Future<void> insertCategory(Categorymodel value) async {
    final _catedb = await Hive.openBox<Categorymodel>(category_db_name);
    await _catedb.put(value.id, value);
    refreshui();
  }

  @override
  Future<List<Categorymodel>> getcategories() async {
    final _catedb = await Hive.openBox<Categorymodel>(category_db_name);
    return _catedb.values.toList();
  }

  Future<void> refreshui() async {
    final _allcate = await getcategories();
    incomeCAtegorylistlistener.value.clear();
    expenseCAtegorylistlistener.value.clear();
    await Future.forEach(_allcate, (Categorymodel category) {
      if (category.type == Categorytype.income) {
        incomeCAtegorylistlistener.value.add(category);
      } else {
        expenseCAtegorylistlistener.value.add(category);
      }
    });
    incomeCAtegorylistlistener.notifyListeners();
    expenseCAtegorylistlistener.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryID) async {
    final _catedb = await Hive.openBox<Categorymodel>(category_db_name);
    await _catedb.delete(categoryID);
    refreshui();
  }
}
