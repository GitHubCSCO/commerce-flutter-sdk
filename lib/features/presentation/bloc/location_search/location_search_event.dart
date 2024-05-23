abstract class LocationSearchEvent {}

class LocationSearchLoadingEvent extends LocationSearchEvent {}

class LocationSearchFocusEvent extends LocationSearchEvent {}

class LocationSearchLoadEvent extends LocationSearchEvent {
  final String pageType;

  LocationSearchLoadEvent(this.pageType);
}
