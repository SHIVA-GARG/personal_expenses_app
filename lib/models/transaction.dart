import 'package:flutter/foundation.dart';

class Transaction {
  final String title;
  final String id;
  final int amount;
  final DateTime date;

  Transaction({
    @required this.date,
    @required this.amount,
    @required this.id,
    @required this.title,
  });
}
