import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTx;
  TransactionList(this.transactions, this._deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: ((context, constraints) {
              return Column(children: [
                Text(
                  "no transactions",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ]);
            }),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: Container(
                    // radius: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ThemeData.dark().accentColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Container(
                        width: 125,
                        child: Column(
                          children: [
                            Text(
                                "\$${(transactions[index].amount).toStringAsFixed(2)}"),
                            Text(transactions[index].category),
                          ],
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].name,
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                  subtitle: Text(DateFormat.yMMMd()
                      .format(transactions[index].date)
                      .toString()),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          onPressed: () => _deleteTx(transactions[index].id),
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          label: Text("Delete"))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => _deleteTx(transactions[index].id),
                        ),
                ),
              );
            },
          );
  }
}
