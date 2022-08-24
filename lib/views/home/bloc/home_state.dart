part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeRecentTransactionsLoadedState extends HomeState {
  final List<Transaction> transactions;

  HomeRecentTransactionsLoadedState(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class HomeRegiteringServicesState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSeeAllBtnPressedState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeAddBtnPressedState extends HomeState {
  @override
  List<Object> get props => [];
}
