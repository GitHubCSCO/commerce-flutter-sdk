import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';

abstract class VMILocationEvent {}

class LoadVMILocationsEvent extends VMILocationEvent {}

class LoadMoreVMILocationsEvent extends VMILocationEvent {}

class LocationSelectEvent extends VMILocationEvent {
  final CurrentLocationDataEntity selectedLocation;
  LocationSelectEvent({required this.selectedLocation});
}

class UpdateSearchPlaceEvent extends VMILocationEvent {
  final GooglePlace? seachPlace;
  UpdateSearchPlaceEvent({required this.seachPlace});
}

class SaveVmiLocationEvent extends VMILocationEvent {
  final CurrentLocationDataEntity selectedLocation;
  SaveVmiLocationEvent({required this.selectedLocation});
}

class SearchVMILocationFromListEvent extends VMILocationEvent {
  final String searchKey;
  SearchVMILocationFromListEvent({required this.searchKey});
}
