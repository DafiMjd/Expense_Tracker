import 'package:collection/collection.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/utils/formatter.dart';
import 'package:expense_tracker/views/all_expense/all_expense_page.dart';
import 'package:expense_tracker/views/form/add_transaction_page.dart';
import 'package:expense_tracker/views/home/bloc/home_bloc.dart';
import 'package:expense_tracker/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          RepositoryProvider.of<TransactionService>(context),
          RepositoryProvider.of<TransactionCategoryService>(context))
        ..add(HomeRegisterServicesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Expense Tracker"),
          // actions: [
          //   Container(
          //       margin: EdgeInsets.all(8),
          //       child: Icon(
          //         Icons.account_circle,
          //         size: 28,
          //       ))
          // ],
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeSeeAllBtnPressedState) {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllExpensesPage(
                          username: username,
                        ),
                      ))
                  .whenComplete(() => context
                      .read<HomeBloc>()
                      .add(HomeLoadRecentTransactionsEvent(username)));
            }
          },
          builder: (context, state) {
            if (state is HomeRecentTransactionsLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //     padding: EdgeInsets.all(10),
                    //     child: Text(
                    //       "Balance",
                    //       style: TextStyle(
                    //           fontSize: 24, fontWeight: FontWeight.bold),
                    //     )),
                    // Container(
                    //     padding: EdgeInsets.all(10),
                    //     child: Text(
                    //       "Rp. 8000000",
                    //       style: TextStyle(
                    //           fontSize: 24, fontWeight: FontWeight.bold),
                    //     )),
                    Card(
                      margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recent Transaction',
                                  style: TextStyle(fontSize: 18),
                                ),
                                // pindahin ke bloc
                                InkWell(
                                  onTap: () => context
                                      .read<HomeBloc>()
                                      .add(HomePressSeeAllBtnEvent()),
                                  child: Row(
                                    children: [
                                      Text(
                                        'See All',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 18),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.blue,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            (state.transactions.isEmpty)
                                ? Text(
                                    'No Data',
                                    style: TextStyle(fontSize: 24),
                                  )
                                : MediaQuery.removePadding(
                                    removeBottom: true,
                                    removeTop: true,
                                    context: context,
                                    child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            (state.transactions.length > 5)
                                                ? 5
                                                : state.transactions.length,
                                        itemBuilder: (context, index) =>
                                            TransactionTile(
                                              transaction: state
                                                  .transactions.reversed
                                                  .toList()[index],
                                              delete: () {
                                                context.read<HomeBloc>().add(HomeDeleteTransactionEvent(state
                                                    .transactions.reversed
                                                    .toList()[index]
                                                    .key));
                                                    Navigator.pop(context);
                                              },
                                            ),
                                        separatorBuilder: (context, index) =>
                                            Container(
                                              height: 10,
                                            )),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            return Container();
          },
        ),
        floatingActionButton:
            BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          if (state is HomeAddBtnPressedState) {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTransactionPage(),
                    ))
                .whenComplete(() => context
                    .read<HomeBloc>()
                    .add(HomeLoadRecentTransactionsEvent(username)));
          }
        }, builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              // var uuid = Uuid();
              // print(uuid.v1().toString());

              context.read<HomeBloc>().add(HomePressAddBtnEvent());
              // print(Formatter.dateFormatToInput());
            },
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
