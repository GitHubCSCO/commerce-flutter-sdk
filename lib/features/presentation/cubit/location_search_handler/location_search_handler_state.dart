part of 'location_search_handler_cubit.dart';

class LocationSearchHandlerState extends Equatable {
  const LocationSearchHandlerState({
    this.locationData,
    this.warehouseData,
  });

  final CurrentLocationDataEntity? locationData;
  final WarehouseEntity? warehouseData;

  @override
  List<Object?> get props => [locationData, warehouseData];
}
