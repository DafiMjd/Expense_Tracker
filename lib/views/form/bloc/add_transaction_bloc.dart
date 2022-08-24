import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/utils/formatter.dart';
import 'package:uuid/uuid.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final TransactionCategoryService _categoryService;
  final TransactionService _transactionService;
  AddTransactionBloc(this._categoryService, this._transactionService)
      : super(AddTransactionInitial([])) {
    on<AddTransactionLoadCategoriesEvent>((event, emit) {
      final categories = _categoryService.getCategories();

      emit(AddTransactionCategoriesLoadedState(categories));
    });

    on<AddTransactionChangeCategoryEvent>((event, emit) {
      emit(AddTransactionCategoryChangedState(event.categories,
          categoryPicked: event.categgoryPicked));
    });

    on<AddTransactionPressSaveBtnEvent>((event, emit) {
      var uuid = Uuid();
      _transactionService.addTransaction(
          uuid.v1().toString(),
          Formatter.dateFormatToInput(DateTime.now()),
          event.title,
          event.categoryId,
          event.categoryId == 4 ? false : true,
          double.parse(event.amount),
          'user');

      emit(AddTransactionSaveBtnPressedState([]));
    });
  }
}
