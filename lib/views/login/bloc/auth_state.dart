part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  AuthInitial();

  @override
  List<Object?> get props => [];
}

class SuccessfulLoginState extends AuthState {
  final String username;

  SuccessfulLoginState(this.username);

  

  @override
  List<Object?> get props => [username];
}

class RegiteringServicesState extends AuthState {
  @override
  List<Object?> get props => [];
}
