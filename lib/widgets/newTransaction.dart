import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();
  final amountController = TextEditingController();
  DateTime _SelectedDate;

  void SubmitData() {
    if (amountController.text.isEmpty) return;
    final enteredTitile = titlecontroller.text;
    final enteredAmount = int.parse(amountController.text);

    if (enteredTitile.isEmpty || enteredAmount < 0 || _SelectedDate == null)
      return;

    widget.addTransaction(
      titlecontroller.text,
      int.parse(amountController.text),
      _SelectedDate,
    );
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _SelectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(15),
        // color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 25),
                  hintText: 'title'),
              controller: titlecontroller,
              onSubmitted: (_) => SubmitData(),
            ),
            TextField(
              autofocus: true,
              decoration:
                  InputDecoration(labelText: 'Amount', hintText: 'Rupees'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => SubmitData(),
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  _SelectedDate == null
                      ? Text("No date Chosen")
                      : Text(
                          'PickedDate:${DateFormat.yMd().format(_SelectedDate)}'),
                  FlatButton(
                    onPressed: _datePicker,
                    child: Text(
                      "pick a date",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    hoverColor: Colors.lime,
                    splashColor: Colors.lime,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: SubmitData,
              child: Text("Add Transaction"),
            )
          ],
        ),
      ),
    );
  }
}
