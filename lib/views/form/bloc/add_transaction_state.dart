part of 'add_transaction_bloc.dart';

abstract class AddTransactionState extends Equatable {
  final List<TransactionCategory> categories;
  int? categoryPicked;
  AddTransactionState(this.categories, {this.categoryPicked});

  @override
  List<Object> get props => [];
}

class AddTransactionInitial extends AddTransactionState {
  AddTransactionInitial(super.categories, {super.categoryPicked});
}

class AddTransactionCategoriesLoadedState extends AddTransactionState {
  AddTransactionCategoriesLoadedState(super.categories, {super.categoryPicked});

  @override
  List<Object> get props => [categories];
}

class AddTransactionCategoryChangedState extends AddTransactionState {

  AddTransactionCategoryChangedState(super.categories, {super.categoryPicked});

  @override
  // TODO: implement props
  List<Object> get props => [
        categories,
        {categoryPicked}
      ];
}

class AddTransactionSaveBtnPressedState extends AddTransactionState {
  AddTransactionSaveBtnPressedState(super.categories);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
