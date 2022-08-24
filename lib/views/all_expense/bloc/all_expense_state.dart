part of 'all_expense_bloc.dart';

abstract class AllExpenseState extends Equatable {
  const AllExpenseState();
  
  @override
  List<Object> get props => [];
}

class AllExpenseInitial extends AllExpenseState {
  @override
  List<Object> get props => [];
}

class AllExpenseTransactionsLoadedState extends AllExpenseState {

  final Map<String, List<Transaction>> groupedTransactions;
  final Map<String, double> earned, spent;

  AllExpenseTransactionsLoadedState(this.groupedTransactions, this.earned, this.spent);

  @override
  List<Object> get props => [groupedTransactions];
}

