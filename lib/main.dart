import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

import './widgets/newTransaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction = [];

  void addNewTransaction(String txtitle, int txamount, DateTime chosenDate) {
    final newTx = Transaction(
        date: chosenDate,
        amount: txamount,
        id: DateTime.now().toString(),
        title: txtitle);
    setState(() {
      _userTransaction.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void startAddingNEwTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text("Expense Tracker"), actions: [
      IconButton(
        icon: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => startAddingNEwTransaction(context),
      ),
    ]);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Chart(_recentTransaction),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
            ),
            Container(
              color: Colors.red,
              child: TransactionList(_userTransaction, _deleteTransaction),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => startAddingNEwTransaction(context),
      ),
    );
  }
}
