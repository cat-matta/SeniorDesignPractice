import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';
import './thememodes.dart';
import 'widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

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

bool isLightMode = true;

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

  bool _showChart = false;
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            middle: Text(
              "Budget Better",
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: Icon(
                  CupertinoIcons.add,
                  color: Theme.of(context).accentColor,
                ),
                onTap: () => _startAddNewTransaction(context),
              ),
            ]),
          )
        : AppBar(
            title: Text(
              "Budget Better",
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: const Icon(Icons.add))
            ],
          );

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: Expanded(
          child: TransactionList(_userTransactions, _deleteTransaction)),
    );
    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Show Chart",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
          if (!isLandscape) txList,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : txList,
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            appBar: appBar,
            body: pageBody);
  }
}
