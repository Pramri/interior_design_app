import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

/*
 Customer List details for Dashboard Page...
 */
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            //elevation thoda dark karta hai card ko...
            elevation: 10,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                        child: Text('${transactions[index].amount}'))),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing: PopupMenuButton(itemBuilder: (ctx) =>[
                PopupMenuItem(child: Text("Delete"), onTap: () {
                  deleteTx(transactions[index].id);
                },),
                PopupMenuItem(child: Text("Edit")),
              ]),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
