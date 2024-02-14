import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class Transactionmodel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime datetime;
  @HiveField(3)
  final Categorytype type;
  @HiveField(4)
  final Categorymodel category;
  @HiveField(5)
  String? Id;

  Transactionmodel({
    required this.purpose,
    required this.amount,
    required this.datetime,
    required this.type,
    required this.category,
  }) {
    Id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
