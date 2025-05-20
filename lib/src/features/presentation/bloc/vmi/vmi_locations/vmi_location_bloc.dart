import 'package:commerce_flutter_sdk/src/core/models/gogole_place.dart';
import 'package:commerce_flutter_sdk/src/core/models/lat_long.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/vmi_location_list_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/vmi_usecase/vmi_location_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMILocationBloc extends Bloc<VMILocationEvent, VMILocationState> {
  final VMILocationUseCase _vmiLocationUseCase;
  CurrentLocationDataEntity? selectedLocation;
  LatLng? currentLocation;
  GooglePlace? seachPlace;
  List<CurrentLocationDataEntity> currentLocationDataEntityList = [];
  List<CurrentLocationDataEntity>? searchedDataEntityList = [];
  Pagination? pagination;
  VmiLocationListStatus status = VmiLocationListStatus.initial;

  VMILocationBloc({required VMILocationUseCase vmiLocationUseCase})
      : _vmiLocationUseCase = vmiLocationUseCase,
        super(VMILocationInitialState()) {
    on<LoadVMILocationsEvent>(_onloadVMILocations);
    on<LocationSelectEvent>(_onLocationSelectEvent);
    on<UpdateSearchPlaceEvent>(_updateSeachPlace);
    on<SaveVmiLocationEvent>(_saveVMILocationEvent);
    on<SearchVMILocationFromListEvent>(_onSearchVMIlocationsOnList);
    on<LoadMoreVMILocationsEvent>(_onLoadMoreVMILocations);
  }

  Future<void> _onloadVMILocations(
      LoadVMILocationsEvent event, Emitter<VMILocationState> emit) async {
    emit(VMILocationLoadingState());

    var response = await _vmiLocationUseCase.getVMILocations(1);
    // currentLocation = await _vmiLocationUseCase.getCurrentLocation();
    switch (response) {
      case Success(value: final data):
        {
          pagination = data?.pagination;
          await _loadVMILocationsByPages(data, emit);
        }
      case Failure():
        break;
    }
  }

  Future<void> _onLoadMoreVMILocations(
      LoadMoreVMILocationsEvent event, Emitter<VMILocationState> emit) async {
    if (pagination?.page == null ||
        pagination!.page! + 1 > pagination!.numberOfPages! ||
        status == VmiLocationListStatus.moreLoading) {
      return;
    }
    status = VmiLocationListStatus.moreLoading;
    emit((state as VMILocationLoadedState)
        .copyWith(status: VmiLocationListStatus.moreLoading));

    var response = await _vmiLocationUseCase.getVMILocations(
      pagination!.page! + 1,
    );
    switch (response) {
      case Success(value: final data):
        {
          pagination = data?.pagination;
          await _loadVMILocationsByPages(data, emit);
        }
      case Failure():
        break;
    }
  }

  Future<void> _loadVMILocationsByPages(
      GetVmiLocationResult? data, Emitter<VMILocationState> emit) async {
    for (var vmiLocation in data?.vmiLocations ?? []) {
      LatLong? latLong;
      if (vmiLocation != null) {
        latLong = await _vmiLocationUseCase
            .getPlaceFromAddresss(vmiLocation.customer);
      }

      var currentLocationDataEntity =
          CurrentLocationDataEntity.fromVmiLocation(vmiLocation);
      currentLocationDataEntity = currentLocationDataEntity.copyWith(
          latLong: latLong, id: vmiLocation.id);

      currentLocationDataEntityList.add(currentLocationDataEntity);
    }
    VmiLocationModel? currentVMILocation =
        _vmiLocationUseCase.getCurrentVMILocation();
    selectedLocation = CurrentLocationDataEntity(
        id: currentVMILocation?.id,
        locationName: currentVMILocation?.name,
        vmiLocation: currentVMILocation);

    if (selectedLocation != null) {
      var selectedItem = currentLocationDataEntityList.firstWhere(
        (location) => location.id == selectedLocation?.id,
      );
      currentLocationDataEntityList
          .removeWhere((location) => location.id == selectedLocation?.id);
      currentLocationDataEntityList.insert(0, selectedItem);
    }
    searchedDataEntityList = null;
    if (seachPlace != null) {
      emit(VMILocationLoadedState(
          currentLocationDataEntityList: currentLocationDataEntityList,
          selectedLocation: selectedLocation,
          status: VmiLocationListStatus.loaded));
      status = VmiLocationListStatus.loaded;
    } else {
      emit(VMILocationLoadedState(
          currentLocationDataEntityList: currentLocationDataEntityList,
          selectedLocation: selectedLocation,
          status: VmiLocationListStatus.loaded));
      status = VmiLocationListStatus.loaded;
    }
  }

  bool isCloseToLocation(double latitude, double longitude) {
    var fromSource = LatLng(latitude, longitude);

    var currentLocation =
        LatLng(seachPlace?.latitude ?? 0.0, seachPlace?.longitude ?? 0.0);

    return _vmiLocationUseCase.isCloseToLocation(fromSource, currentLocation);
  }

  Future<void> _onLocationSelectEvent(
      LocationSelectEvent event, Emitter<VMILocationState> emit) async {
    var dataEntityList =
        searchedDataEntityList ?? currentLocationDataEntityList;
    seachPlace = null;
    selectedLocation = event.selectedLocation;
    String selectedLocationId = event.selectedLocation.id!;
    var selectedItem = dataEntityList.firstWhere(
      (location) => location.id == selectedLocationId,
    );
    dataEntityList.removeWhere((location) => location.id == selectedLocationId);
    dataEntityList.insert(0, selectedItem);
    emit(VMILocationLoadedState(
        currentLocationDataEntityList: dataEntityList,
        selectedLocation: selectedLocation,
        status: VmiLocationListStatus.itemSelected));
  }

  Future<void> _updateSeachPlace(
      UpdateSearchPlaceEvent event, Emitter<VMILocationState> emit) async {
    seachPlace = event.seachPlace;
  }

  Future<void> _saveVMILocationEvent(
      SaveVmiLocationEvent event, Emitter<VMILocationState> emit) async {
    await _vmiLocationUseCase
        .saveCurrentVmiLocation(event.selectedLocation.vmiLocation!);
  }

  Future<void> _onSearchVMIlocationsOnList(SearchVMILocationFromListEvent event,
      Emitter<VMILocationState> emit) async {
    emit(VMILocationLoadingState());
    var searchKey = event.searchKey;
    var searchResult = currentLocationDataEntityList.where((element) {
      return element.locationName
              ?.toLowerCase()
              .contains(searchKey.toLowerCase()) ??
          false;
    }).toList();
    searchedDataEntityList = searchResult;
    emit(VMILocationLoadedState(
        currentLocationDataEntityList: searchResult,
        status: VmiLocationListStatus.loaded));
  }
}
