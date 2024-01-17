part of 'search_page_bloc.dart';

abstract class SearchPageState {}

class SearchPageInitialState extends SearchPageState {}

class SearchPageLoadingState extends SearchPageState {}

class SearchPageLoadedState extends SearchPageState {
  final List<WidgetEntity> pageWidgets;
  SearchPageLoadedState({required this.pageWidgets});
}

class SearchPageFailureState extends SearchPageState {
  final String error;

  SearchPageFailureState(this.error);
}
