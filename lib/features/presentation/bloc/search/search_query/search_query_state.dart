part of 'search_query_bloc.dart';

@immutable
abstract class SearchQueryState {}

class SearchQueryInitialState extends SearchQueryState {}

class SearchQueryFocusState extends SearchQueryState {}

class SearchQueryTypingState extends SearchQueryState {}

class SearchQueryUnFocusState extends SearchQueryState {}

class SearchQueryLoadingState extends SearchQueryState {}

class SearchQueryCmsInitialState extends SearchQueryState {}

class SearchQueryAutoCompleteInitialState extends SearchQueryState {}

class SearchQueryAutoCompleteLoadedState extends SearchQueryState {

  final AutocompleteResult? result;

  SearchQueryAutoCompleteLoadedState({required this.result});

}

class SearchQueryAutoCompleteFailureState extends SearchQueryState {

  final String error;

  SearchQueryAutoCompleteFailureState(this.error);

}

class SearchQueryProductsInitialState extends SearchQueryState {}

class SearchQueryProductsLoadedState extends SearchQueryState {

  final GetProductCollectionResult? result;

  SearchQueryProductsLoadedState({required this.result});

}

class SearchQueryProductsFailureState extends SearchQueryState {

  final String error;

  SearchQueryProductsFailureState(this.error);

}

