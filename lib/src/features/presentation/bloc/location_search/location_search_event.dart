abstract class LocationSearchEvent {}

class LocationSearchInitialEvent extends LocationSearchEvent {}

class LocationSearchLoadingEvent extends LocationSearchEvent {}

class LocationSearchFocusEvent extends LocationSearchEvent {}

class LocationSearchLoadEvent extends LocationSearchEvent {
  final String pageType;
  final String searchQuery;
  LocationSearchLoadEvent({required this.pageType, required this.searchQuery});
}

class LocationSeachHistoryLoadEvent extends LocationSearchEvent {}
