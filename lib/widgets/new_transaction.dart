import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import './user_transactions.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // const NewTransaction({Key? key}) : super(key: key);
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _categoryController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTransaction() {
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);
    final _enteredCategory = _categoryController.text;
    if (_amountController.text.isEmpty) return;
    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
        _enteredTitle, _enteredAmount, _enteredCategory, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              // onChanged: ((value) {
              //   titleInput = value;
              // }),
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  // color: Colors.blue,
                  width: 120,
                  child: TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    // onChanged: (value) => amountInput = value,
                    decoration: const InputDecoration(
                      labelText: "Amount",
                    ),
                    onSubmitted: (_) => _submitTransaction(),
                  ),
                ),
                Container(
                  width: 120,
                  // color: Colors.amber,
                  child: TextField(
                    controller: _categoryController,
                    // onChanged: ((value) {
                    //   titleInput = value;
                    // }),
                    onSubmitted: (_) => _submitTransaction(),
                    decoration: const InputDecoration(
                      labelText: "Category",
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 12,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? "No date chosen!"
                      : "Picked date: " +
                          DateFormat.yMd().format(_selectedDate!).toString()),
                ),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor)),
                  onPressed: _presentDatePicker,
                  child: Text(
                    "Choose Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              // color: Colors.tealAccent,
              alignment: Alignment.center,
              child: ElevatedButton(
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(color: ThemeData.dark().primaryColorDark),
                  ),
                  onPressed: _submitTransaction,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          ThemeData.dark().accentColor))),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
