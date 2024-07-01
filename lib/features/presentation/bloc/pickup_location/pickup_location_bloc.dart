import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pickup_location_usecase/pickup_location_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class PickupLocationBloc
    extends Bloc<PickUpLocationEvent, PickUpLocationState> {
  final PickUpLocationUseCase _pickUpLocationUseCase;
  LatLng? currentLocation;
  GooglePlace? seachPlace;
  List<WarehouseEntity> warehouseList = [];
  WarehouseEntity? selectedWarehouse;

  PickupLocationBloc({required PickUpLocationUseCase pickUpLocationUseCase})
      : _pickUpLocationUseCase = pickUpLocationUseCase,
        super(PickUpLocationInitialState()) {
    on<LoadPickUpLocationsEvent>(_onLoadPickUpLocations);
    on<PickUpLocationSelectEvent>(_onPickupLocationSelectEvent);
    on<LoadSearchedPickUpLocationsEvent>(_onSearchPickUpLocationsEvent);
  }

  Future<void> _onLoadPickUpLocations(
      LoadPickUpLocationsEvent event, Emitter<PickUpLocationState> emit) async {
    emit(PickUpLocationLoadingState());
    selectedWarehouse = event.selectedPickupWarehouse;
    var wareHouses = await _pickUpLocationUseCase.getWarehouses(
        latitude: event.selectedPickupWarehouse?.latitude?.toDouble(),
        longitude: event.selectedPickupWarehouse?.longitude?.toDouble());
    warehouseList = wareHouses;
    emit(PickUpLocationLoadedState(
        wareHouselist: wareHouses, selectedWarehouse: selectedWarehouse));
  }

  Future<void> _onPickupLocationSelectEvent(PickUpLocationSelectEvent event,
      Emitter<PickUpLocationState> emit) async {
    emit(PickUpLocationLoadingState());
    seachPlace = null;
    selectedWarehouse = event.selectedWarehouse;
    var selectedItem = warehouseList.firstWhere(
      (warehouse) => warehouse.id == selectedWarehouse?.id,
    );
    warehouseList
        .removeWhere((warehouse) => warehouse.id == selectedWarehouse?.id);
    warehouseList.insert(0, selectedItem);
    emit(PickUpLocationLoadedState(
        wareHouselist: warehouseList, selectedWarehouse: selectedWarehouse));
  }

  Future<void> _onSearchPickUpLocationsEvent(
      LoadSearchedPickUpLocationsEvent event,
      Emitter<PickUpLocationState> emit) async {
    emit(PickUpLocationLoadingState());
    seachPlace = event.searchedLocation;
    var wareHouses = await _pickUpLocationUseCase.getWarehouses(
        latitude: seachPlace?.latitude, longitude: seachPlace?.longitude);
    warehouseList = wareHouses;
    emit(PickUpLocationLoadedState(
        wareHouselist: wareHouses, selectedWarehouse: selectedWarehouse));
  }
}
