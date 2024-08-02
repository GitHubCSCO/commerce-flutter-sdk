part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchFocusEvent extends SearchEvent {}

class SearchTypingEvent extends SearchEvent {
  final String searchQuery;

  SearchTypingEvent(this.searchQuery);
}

class SearchUnFocusEvent extends SearchEvent {}

class SearchAutoCompleteLoadEvent extends SearchEvent {
  final String query;

  SearchAutoCompleteLoadEvent(this.query);
}

class SearchSearchEvent extends SearchEvent {}

class SearchCloseEvent extends SearchEvent {}

class AutoCompleteCategoryEvent extends SearchEvent {
  final AutocompleteCategory category;

  AutoCompleteCategoryEvent(this.category);
}

class AutoCompleteBrandEvent extends SearchEvent {
  final AutocompleteBrand brand;

  AutoCompleteBrandEvent(this.brand);
}
