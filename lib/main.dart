import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';

import 'package:money_management/models/transaction/transaction_model.dart';
import 'package:money_management/screens/home/homescreen.dart';
import 'package:money_management/screens/trans/transaction_add.dart';

Future<void> main() async {
  // final obj1 = Categorydb();
  // final obj2 = Categorydb();
  // print('comparing');
  // print(obj1 == obj2);
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategorytypeAdapter().typeId)) {
    Hive.registerAdapter(CategorytypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategorymodelAdapter().typeId)) {
    Hive.registerAdapter(CategorymodelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionmodelAdapter().typeId)) {
    Hive.registerAdapter(TransactionmodelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 226, 58, 136)),
      home: const Homescreen(),
      routes: {
        AddtransactionSCreen.routename: (context) =>
            const AddtransactionSCreen(),
      },
    );
  }
}
