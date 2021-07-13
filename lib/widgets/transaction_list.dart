import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> _userTransaction;
  final Function deletetx;
  TransactionList(this._userTransaction, this.deletetx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Color _bgcolor;

  @override
  void initState() {
    const availabeColors = [
      Colors.red,
      Colors.yellow,
      Colors.teal,
      Colors.brown
    ];
    _bgcolor = availabeColors[Random().nextInt(4)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          color: Colors.yellow,
          margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.purple,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    'Rs:${widget._userTransaction[index].amount}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            title: Text(
              '${widget._userTransaction[index].title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            subtitle: Text(
              "${DateFormat.yMEd().format(widget._userTransaction[index].date)}",
            ),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                iconSize: 34,
                color: Colors.red,
                onPressed: () =>
                    widget.deletetx(widget._userTransaction[index].id)),
          ),
        );
      },
      itemCount: widget._userTransaction.length,
    );
  }
}
