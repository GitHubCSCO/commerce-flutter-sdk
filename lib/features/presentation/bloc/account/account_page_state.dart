part of 'account_page_bloc.dart';

abstract class AccountPageState {}

class AccountPageInitialState extends AccountPageState {}

class AccountPageLoadingState extends AccountPageState {}

class AccountPageLoadedState extends AccountPageState {
  final List<WidgetEntity> pageWidgets;
  AccountPageLoadedState({required this.pageWidgets});
}

class AccountPageFailureState extends AccountPageState {
  final String error;

  AccountPageFailureState(this.error);
}
