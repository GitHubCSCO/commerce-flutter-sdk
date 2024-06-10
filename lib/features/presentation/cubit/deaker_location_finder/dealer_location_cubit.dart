import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/features/domain/usecases/dealer_location_usecase/dealer_location_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/deaker_location_finder/dealer_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DealerLocationCubit extends Cubit<DealerLocationState> {
  GooglePlace? seachPlace;
  final DealerLocationUsecase _dealerLocationUsecase;
  double radius = 100.0;
  DealerLocationCubit({required DealerLocationUsecase dealerLocationUsecase})
      : _dealerLocationUsecase = dealerLocationUsecase,
        super(DealerLocationInitialState());

  Future<void> loadDealersLocation() async {
    var requestParameters = DealerLocationFinderQueryParameters(
        latitude: seachPlace?.latitude,
        longitude: seachPlace?.longitude,
        radius: radius,
        page: 1,
        pageSize: 16);

    var response = await _dealerLocationUsecase.getDealersLocation(
        parameters: requestParameters);
    switch (response) {
      case Success(value: final data):
        {
          emit(DealerLocationLoadedState(dealers: data?.dealers ?? []));
        }
      case Failure(errorResponse: final error):
        {
          emit(DealerLocationFailureState(message: error.message ?? ''));
        }
    }
  }

  Future<void> updateSeachPlaceForDealer(GooglePlace? seachPlace) async {
    this.seachPlace = seachPlace;
    loadDealersLocation();
  }

  Future<void> updateVisibleMapRdius(double radius) async {
    this.radius = radius;
  }
}
