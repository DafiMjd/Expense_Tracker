import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/utils/formatter.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(
      {Key? key, required this.transaction, required this.delete})
      : super(key: key);

  final Transaction transaction;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id2),
      background: Container(
        padding: EdgeInsets.only(right: 15),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(Icons.delete),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: <Widget>[
                ElevatedButton(
                    // onPressed: () => Navigator.of(context).pop(true),
                    onPressed: delete,
                    child: const Text("DELETE")),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      child: ListTile(
        leading: Icon(TransactionCategory.getIcon(transaction.category!.icon)),
        title: Text(
          transaction.title,
          style: TextStyle(fontSize: 18),
        ),
        subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction.category!.name),
              Text(Formatter.dateFormat(transaction.date))
            ]),
        trailing: transaction.isCredit
            ? Text(
                '- ${Formatter.formatMoney(transaction.amount)}',
                style: TextStyle(fontSize: 18),
              )
            : Text(
                Formatter.formatMoney(transaction.amount),
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
      ),
    );
  }
}
