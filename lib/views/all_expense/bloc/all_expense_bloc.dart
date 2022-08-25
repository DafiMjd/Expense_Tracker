import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/views/home/bloc/home_bloc.dart';

import '../../../models/transaction.dart';

part 'all_expense_event.dart';
part 'all_expense_state.dart';

class AllExpenseBloc extends Bloc<AllExpenseEvent, AllExpenseState> {
  final TransactionService _transactionService;
  final TransactionCategoryService _categoryService;

  AllExpenseBloc(this._transactionService, this._categoryService)
      : super(AllExpenseInitial()) {
    on<AllExpenseLoadTransactionsEvent>((event, emit) {
      var transactions = _transactionService.getTransactions(event.username);
      final categories = _categoryService.getCategories();

      transactions.forEach(
        (element) => element.category =
            categories.firstWhere((cat) => cat.id == element.categoryId),
      );

      var groupedTransactions = groupBy(
          transactions, (Transaction obj) => Transaction.getMonth(obj.date));

      Map<String, double> earned = Map<String, double>();
      Map<String, double> spent = Map<String, double>();
      groupedTransactions.forEach(
        (key, value) {
          earned[key] = _countEarnedOrSpent(transactions, false);
          spent[key] = _countEarnedOrSpent(transactions, true);
        }
      );



      emit(AllExpenseTransactionsLoadedState(
          groupedTransactions, earned, spent));
    });

    on<AllExpenseDeleteTransactionEvent>((event, emit) {
      _transactionService.deleteTransaction(event.id, 'user');

      add(AllExpenseLoadTransactionsEvent('user'));
    });

    on<AllExpenseDeleteAllTransactionsEvent>((event, emit) {
      _transactionService.deleteAllTransaction('user');

      add(AllExpenseLoadTransactionsEvent('user'));
    });
  }

  double _countEarnedOrSpent(List<Transaction> transactions, bool isSpent) {
    double money = 0;

    if (isSpent) {
      transactions.forEach((element) {
        if (element.isCredit) {
          money += element.amount;
        }
      });

      return money;
    }

    transactions.forEach((element) {
      if (!element.isCredit) {
        money += element.amount;
      }
    });

    return money;
  }
}
