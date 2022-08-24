import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';

import '../../../models/transaction.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TransactionService _transactionService;
  final TransactionCategoryService _categoryService;

  HomeBloc(this._transactionService, this._categoryService)
      : super(HomeRegiteringServicesState()) {
    on<HomeLoadRecentTransactionsEvent>((event, emit) {
      var transactions = _transactionService.getTransactions(event.username);
      final categories = _categoryService.getCategories();

      transactions.forEach(
        (element) => element.category =
            categories.firstWhere((cat) => cat.id == element.categoryId),
      );

      emit(HomeRecentTransactionsLoadedState(transactions));
    });

    on<HomeRegisterServicesEvent>((event, emit) async {
      await _transactionService.init();
      await _categoryService.init();

      // emit(HomeInitial());
      add(HomeLoadRecentTransactionsEvent('user'));
    });

    on<HomePressSeeAllBtnEvent>((event, emit) => emit(HomeSeeAllBtnPressedState()));

    on<HomePressAddBtnEvent>((event, emit) => emit(HomeAddBtnPressedState()));

    on<HomeDeleteTransactionEvent>((event, emit) {
      _transactionService.deleteTransaction(event.id, 'user');

      add(HomeLoadRecentTransactionsEvent('user'));
    });
  }
}
