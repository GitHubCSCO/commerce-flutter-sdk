part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchLoadingState extends SearchState {}

class SearchCmsInitialState extends SearchState {}

class SearchAutoCompleteInitialState extends SearchState {}

class SearchQueryLoadedState extends SearchState {
  final String? searchQuery;

  SearchQueryLoadedState({required this.searchQuery});
}

class SearchAutoCompleteLoadedState extends SearchState {
  final AutocompleteResult? result;

  SearchAutoCompleteLoadedState({required this.result});
}

class SearchAutoCompleteFailureState extends SearchState {
  final String error;

  SearchAutoCompleteFailureState(this.error);
}

class SearchProductsLoadedState extends SearchState {
  final GetProductCollectionResult? result;

  SearchProductsLoadedState({required this.result});
}

class SearchProductsFailureState extends SearchState {
  final String error;

  SearchProductsFailureState(this.error);
}

class AutoCompleteCategoryState extends SearchState {
  final Category category;

  AutoCompleteCategoryState(this.category);
}

class AutoCompleteBrandState extends SearchState {
  final Brand brand;

  AutoCompleteBrandState(this.brand);
}

class AutoCompleteProductListState extends SearchState {
  final ProductPageEntity pageEntity;

  AutoCompleteProductListState(this.pageEntity);
}
