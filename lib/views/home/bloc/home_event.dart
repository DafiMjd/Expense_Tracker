part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadRecentTransactionsEvent extends HomeEvent {
  final String username;

  HomeLoadRecentTransactionsEvent(this.username);

  @override
  List<Object> get props => [username];
}

class HomeRegisterServicesEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomePressSeeAllBtnEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomePressAddBtnEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeDeleteTransactionEvent extends HomeEvent {
  final dynamic id;

  HomeDeleteTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}

