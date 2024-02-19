part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchFocusState extends SearchState {}

class SearchTypingState extends SearchState {}

class SearchUnFocusState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchCmsInitialState extends SearchState {}

class SearchAutoCompleteInitialState extends SearchState {}

class SearchAutoCompleteLoadedState extends SearchState {

  final AutocompleteResult? result;

  SearchAutoCompleteLoadedState({required this.result});

}

class SearchAutoCompleteFailureState extends SearchState {

  final String error;

  SearchAutoCompleteFailureState(this.error);

}

class SearchProductsInitialState extends SearchState {}

class SearchProductsLoadedState extends SearchState {

  final GetProductCollectionResult? result;

  SearchProductsLoadedState({required this.result});

}

class SearchProductsFailureState extends SearchState {

  final String error;

  SearchProductsFailureState(this.error);

}

