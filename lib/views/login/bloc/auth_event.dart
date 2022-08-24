part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);
  

  @override
  // TODO: implement props
  List<Object> get props => [username, password];
}

class RegisterServicesEvent extends AuthEvent {
  

  @override
  List<Object> get props => [];
}
