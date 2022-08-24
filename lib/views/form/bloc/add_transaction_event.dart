part of 'add_transaction_bloc.dart';

abstract class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();

  @override
  List<Object> get props => [];
}

class AddTransactionLoadCategoriesEvent extends AddTransactionEvent {
  @override
  List<Object> get props => [];
}

class AddTransactionChangeCategoryEvent extends AddTransactionEvent {
  final int categgoryPicked;
  final List<TransactionCategory> categories;

  AddTransactionChangeCategoryEvent(this.categories, this.categgoryPicked);

  @override
  List<Object> get props => [categgoryPicked];
}

class AddTransactionPressSaveBtnEvent extends AddTransactionEvent {
  final String title;
  final int categoryId;
  final String amount;

  AddTransactionPressSaveBtnEvent(this.title, this.categoryId, this.amount);

  @override
  // TODO: implement props
  List<Object> get props => [title, categoryId, amount];
}
