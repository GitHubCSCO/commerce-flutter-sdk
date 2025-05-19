part of 'search_history_cubit.dart';

abstract class SearchHistoryState {}

class SearchHistoryInitialState extends SearchHistoryState {}

class SearchHistoryLoadingState extends SearchHistoryState {}

class SearchHistoryLoadedState extends SearchHistoryState {
  final List<String> historyList;

  SearchHistoryLoadedState({required this.historyList});
}

class SearchHistoryFailureState extends SearchHistoryState {
  final String error;

  SearchHistoryFailureState({required this.error});
}
