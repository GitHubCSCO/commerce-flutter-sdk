import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pickup_location_usecase/pickup_location_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

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
  }

  Future<void> _onLoadPickUpLocations(
      LoadPickUpLocationsEvent event, Emitter<PickUpLocationState> emit) async {
    emit(PickUpLocationLoadingState());
    var wareHouses = await _pickUpLocationUseCase.getWarehouses();
    warehouseList = wareHouses;
    emit(PickUpLocationLoadedState(wareHouselist: wareHouses));
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
        wareHouselist: warehouseList,
        selectedLocation: selectedWarehouse?.latLong));
  }
}
