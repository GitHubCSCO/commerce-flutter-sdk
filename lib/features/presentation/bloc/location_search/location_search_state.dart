import 'package:commerce_flutter_sdk/core/models/gogole_place.dart';
import 'package:commerce_flutter_sdk/core/models/lat_long.dart';

abstract class LoactionSearchState {}

class LocationSearchInitialState extends LoactionSearchState {}

class LocationSearchLoadingState extends LoactionSearchState {}

class LocationSearchFocusState extends LoactionSearchState {}

class LocationSearchLoadedState extends LoactionSearchState {
  final String pageType;
  final GooglePlace? searchedLocation;
  LocationSearchLoadedState(
      {required this.searchedLocation, required this.pageType});
}

class LocationSearchFailureState extends LoactionSearchState {}

class LocationSearchHistoryLoadedState extends LoactionSearchState {
  final List<String> searchHistory;
  LocationSearchHistoryLoadedState({required this.searchHistory});
}
