import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/utils/formatter.dart';
import 'package:expense_tracker/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'bloc/all_expense_bloc.dart';

class AllExpensesPage extends StatelessWidget {
  const AllExpensesPage({Key? key, required this.username}) : super(key: key);

  // final Map<String, List<Transaction>> groupedTransactions;
  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllExpenseBloc(
          RepositoryProvider.of<TransactionService>(context),
          RepositoryProvider.of<TransactionCategoryService>(context))
        ..add(AllExpenseLoadTransactionsEvent(username)),
      child: BlocBuilder<AllExpenseBloc, AllExpenseState>(
        builder: (context, state) {
          if (state is AllExpenseTransactionsLoadedState) {
            return Scaffold(
              appBar: AppBar(
                title: Text('All Expenses'),
                actions: [
                  IconButton(
                    onPressed: () async {
                      var isConfirmed = await _confirm(context);
                      if (isConfirmed) {
                        context
                          .read<AllExpenseBloc>()
                          .add(AllExpenseDeleteAllTransactionsEvent('user'));
                      }
                    },
                      // onPressed: () => context
                      //     .read<AllExpenseBloc>()
                      //     .add(AllExpenseDeleteAllTransactionsEvent('user')),
                      icon: Icon(Icons.delete))
                ],
              ),
              body: Container(
                  // padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                child: state.groupedTransactions.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'No Data',
                          style: TextStyle(fontSize: 24),
                        ))
                    : Column(
                        children: [
                          for (var key in state.groupedTransactions.keys)
                            StickyHeader(
                              header: Container(
                                height: 35,
                                color: Theme.of(context).primaryColor,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Formatter.getMonth(state
                                          .groupedTransactions[key]![0].date),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Earned: ' + Formatter.formatMoney(state.earned[key]!),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Spent: ' + Formatter.formatMoney(state.spent[key]!) ,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  
                                  ],
                                ),
                              ),
                              content: MediaQuery.removePadding(
                                removeBottom: true,
                                removeTop: true,
                                context: context,
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        state.groupedTransactions[key]!.length,
                                    itemBuilder: (context, index) =>
                                        TransactionTile(
                                            delete: () {
                                              context.read<AllExpenseBloc>().add(
                                                  AllExpenseDeleteTransactionEvent(
                                                      state
                                                          .groupedTransactions[
                                                              key]!
                                                          .reversed
                                                          .toList()[index]
                                                          .key));
                                              Navigator.pop(context);
                                            },
                                            transaction: state
                                                .groupedTransactions[key]!
                                                .reversed
                                                .toList()[index]),
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          height: 10,
                                        )),
                              ),
                            )
                        ],
                      ),
              )),
            );
          }
          return Scaffold();
        },
      ),
    );
  }

  Future<bool> _confirm(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to delete all items?"),
          actions: <Widget>[
            ElevatedButton(
                // onPressed: () => Navigator.of(context).pop(true),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("DELETE")),
            ElevatedButton(
              // onPressed: () => Navigator.of(context).pop(false),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }
}
