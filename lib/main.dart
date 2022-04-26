import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';
import './thememodes.dart';
import 'widgets/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isLightMode ? ThemeModes.lightMode() : ThemeModes.darkMode(),
      debugShowCheckedModeBanner: false,
      title: "Personal Expenses",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool isLightMode = false;

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  void _addNewTransaction(
      String title, double amount, String category, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        name: title,
        amount: amount,
        date: chosenDate,
        category: category);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  void _toggleTheme() {
    setState(() {
      isLightMode = !isLightMode;
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      appBar: AppBar(
        leading: isLightMode
            ? IconButton(
                icon: const Icon(Icons.dark_mode),
                onPressed: _toggleTheme,
              )
            : IconButton(
                icon: const Icon(Icons.light_mode),
                onPressed: _toggleTheme,
              ),
        title: const Text(
          "Budget Better",
          // style: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.bold),
        ),
        // foregroundColor: Theme.of(context).accentColor,
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(_recentTransactions),
          Expanded(
              child: TransactionList(_userTransactions, _deleteTransaction)),
        ],
      ),
    );
  }
}
