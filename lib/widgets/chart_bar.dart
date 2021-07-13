import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  int amount;
  final weekday;
  final Spendingpercentage;
  ChartBar(this.amount, this.weekday, this.Spendingpercentage);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            child: FittedBox(child: Text('Rs: ${amount}')),
            height: constraints.maxHeight * 0.1,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.07,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: Spendingpercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.1,
          ),
          Container(
            child: Text(weekday),
            height: constraints.maxHeight * 0.08,
          ),
        ],
      );
    });
  }
}
