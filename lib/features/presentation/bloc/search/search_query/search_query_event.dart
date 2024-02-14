part of 'search_query_bloc.dart';

@immutable
abstract class SearchQueryEvent {}

class SearchQueryFocusEvent extends SearchQueryEvent {}

class SearchQueryTypingEvent extends SearchQueryEvent {
  final String searchQuery;

  SearchQueryTypingEvent(this.searchQuery);
}

class SearchQueryUnFocusEvent extends SearchQueryEvent {}

class SearchQueryAutoCompleteLoadEvent extends SearchQueryEvent {

  final String query;

  SearchQueryAutoCompleteLoadEvent(this.query);

}

class SearchQuerySearchEvent extends SearchQueryEvent {}

class SearchQueryCloseEvent extends SearchQueryEvent {}

