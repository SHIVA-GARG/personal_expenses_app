import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      int sum = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          sum += recentTransaction[i].amount;
        }
      }

      // print(DateFormat.E().format(weekday));
      // print(sum);

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': sum
      };
    });
  }

  int get totalSpending {
    return groupedTransactionValues.fold(0, (totalSum, item) {
      return totalSum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 8,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return ChartBar(
              data['amount'],
              data['day'],
              totalSpending != 0.0
                  ? (data['amount'] as int) / totalSpending
                  : 0.0,
            );
          }).toList(),
        ),
      ),
    );
  }
}
