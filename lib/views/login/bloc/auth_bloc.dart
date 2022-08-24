import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _auth;
  final TransactionService _transaction;
  final TransactionCategoryService _category;

  AuthBloc(this._auth, this._transaction, this._category ) : super(RegiteringServicesState()) {
    on<LoginEvent>(((event, emit) async {
      final user = await _auth.authUser(event.username, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(user));
        emit(AuthInitial());
      }
    }));

    on<RegisterServicesEvent>((event, emit) async {
      await _auth.init();
      await _transaction.init();
      await _category.init();

      emit(AuthInitial());
    });
  }
}
