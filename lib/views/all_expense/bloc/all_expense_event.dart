part of 'all_expense_bloc.dart';

abstract class AllExpenseEvent extends Equatable {
  const AllExpenseEvent();

  @override
  List<Object> get props => [];
}

class AllExpenseLoadTransactionsEvent extends AllExpenseEvent {
  final String username;

  AllExpenseLoadTransactionsEvent(this.username);

  @override
  List<Object> get props => [username];

}

class AllExpenseDeleteTransactionEvent extends AllExpenseEvent {
  final dynamic id;

  AllExpenseDeleteTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AllExpenseDeleteAllTransactionsEvent extends AllExpenseEvent {
  final String username;

  AllExpenseDeleteAllTransactionsEvent(this.username);

  @override
  // TODO: implement props
  List<Object> get props => [username];
}
