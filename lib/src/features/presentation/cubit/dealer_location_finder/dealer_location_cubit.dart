import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/models/gogole_place.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/dealer_location_usecase/dealer_location_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/dealer_location_finder/dealer_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DealerLocationCubit extends Cubit<DealerLocationState> {
  GooglePlace? seachPlace;
  final DealerLocationUsecase _dealerLocationUsecase;
  double radius = 100.0;
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreDealers = true;

  DealerLocationCubit({required DealerLocationUsecase dealerLocationUsecase})
      : _dealerLocationUsecase = dealerLocationUsecase,
        super(DealerLocationInitialState());

  Future<void> loadDealersLocation({bool isPagination = false}) async {
    if (!isPagination) {
      emit(DealerLocationLoadingState());
      currentPage = 1; // Reset page for fresh load
    } else if (isLoadingMore || !hasMoreDealers) {
      return; // Avoid multiple requests if already loading or no more data
    }

    isLoadingMore = true;
    var requestParameters = DealerLocationFinderQueryParameters(
      latitude: seachPlace?.latitude,
      longitude: seachPlace?.longitude,
      radius: radius,
      page: currentPage,
      pageSize: CoreConstants.defaultPageSize,
    );

    // For pagination, emit a state showing more dealers are being loaded
    if (isPagination) {
      emit(DealerLocationLoadingMoreState(
        dealers: (state as DealerLocationLoadedState).dealers,
      ));
    }

    var response = await _dealerLocationUsecase.getDealersLocation(
      parameters: requestParameters,
    );
    switch (response) {
      case Success(value: final data):
        if (data?.dealers != null && data!.dealers!.isNotEmpty) {
          currentPage++; // Increment page for next request
          var dealers = isPagination
              ? (state as DealerLocationLoadedState).dealers + data.dealers!
              : data.dealers;

          if (data.pagination != null &&
              data.pagination!.numberOfPages != null) {
            if (currentPage > data.pagination!.numberOfPages!) {
              hasMoreDealers = false;
            }
          }

          emit(
            DealerLocationLoadedState(
              dealers: dealers ?? [],
            ),
          );
        } else {
          hasMoreDealers = false; // No more dealers
        }
      case Failure(errorResponse: final error):
        _dealerLocationUsecase.trackError(error);
        emit(DealerLocationFailureState(message: error.message ?? ''));
    }
    isLoadingMore = false;
  }

  Future<void> updateSeachPlaceForDealer(GooglePlace? seachPlace) async {
    this.seachPlace = seachPlace;
    await loadDealersLocation();
  }

  Future<void> updateVisibleMapRadius(double radius) async {
    this.radius = radius;
  }

  Future<void> loadMoreDealers() async {
    if (!isLoadingMore && hasMoreDealers) {
      await loadDealersLocation(isPagination: true);
    }
  }
}
