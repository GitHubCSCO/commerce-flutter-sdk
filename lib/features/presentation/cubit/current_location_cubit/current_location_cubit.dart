import 'package:commerce_flutter_sdk/core/models/lat_long.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/curent_location_usecase/current_location_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/current_location_cubit/current_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  final CurrentLocationUseCase _currentLocationUseCase;

  CurrentLocationCubit({required CurrentLocationUseCase currentLocationUseCase})
      : _currentLocationUseCase = currentLocationUseCase,
        super(CurrentLocationInitialState());

  Future<void> onLoadLocationData() async {
    emit(CurrentLocationLoadingState());
    VmiLocationModel? vmiLocation =
        _currentLocationUseCase.getCurrentLocation();
    LatLong? latLong;
    if (vmiLocation != null) {
      latLong = await _currentLocationUseCase
          .getPlaceFromAddresss(vmiLocation.customer);
    }

    var currentLocationDataEntity =
        CurrentLocationDataEntity.fromVmiLocation(vmiLocation);
    currentLocationDataEntity =
        currentLocationDataEntity.copyWith(latLong: latLong);
    currentLocationDataEntity =
        currentLocationDataEntity.copyWith(vmiLocation: vmiLocation);

    emit(CurrentLocationLoadedState(
        currentLocationDataEntity: currentLocationDataEntity));
  }

  Future<void> onLocationSelectEvent(
      CurrentLocationDataEntity currentLocationDataEntity) async {
    await _currentLocationUseCase
        .saveCurrentVmiLocation(currentLocationDataEntity.vmiLocation!);
  }
}
