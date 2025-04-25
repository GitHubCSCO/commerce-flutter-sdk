import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/brand_usecase/brand_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_state.dart';
part 'brand_event.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandUseCase _brandUseCase;
  final minimumNumberCharactersSearchLog = 3;

  BrandBloc({required BrandUseCase brandUseCase})
      : _brandUseCase = brandUseCase,
        super(BrandInitial()) {
    on<BrandSectionLoadEvent>(_onBrandSectionLoadEvent);
    on<BrandAutoCompleteLoadEvent>(_onBrandAutoCompleteLoadEvent);
    on<BrandToggleEvent>(_onBrandToggleEvent);
    on<BrandLoadEvent>(_onBrandLoadEvent);
  }

  Future<void> _onBrandSectionLoadEvent(
      BrandSectionLoadEvent event, Emitter<BrandState> emit) async {
    emit(BrandLoading());

    final response = await _brandUseCase.getAlphabet();
    switch (response) {
      case Success(value: final data):
        emit(BrandSectionLoaded(data, -1));
      case Failure(errorResponse: final error):
        emit(BrandSectionFailed(error: error.message ?? ''));
    }
  }

  Future<void> _onBrandAutoCompleteLoadEvent(
      BrandAutoCompleteLoadEvent event, Emitter<BrandState> emit) async {
    if (event.query.isNotEmpty) {
      emit(BrandLoading());

      var apiCallIsSuccessful = false;
      var resultsCount = 0;

      final result = await _brandUseCase.getAutoCompleteBrands(event.query);
      switch (result) {
        case Success(value: final data):
          if (data != null && data.isNotEmpty) {
            apiCallIsSuccessful = true;
            resultsCount = data.length;
            emit(BrandAutoCompleteLoaded(data));
          } else {
            emit(BrandAutoCompleteFailed(
                error: LocalizationConstants.noResultFoundMessage.localized()));
          }
        case Failure(errorResponse: final errorResponse):
          emit(BrandAutoCompleteFailed(
              error: errorResponse.errorDescription ?? ''));
        default:
      }

      if (event.query.length >= minimumNumberCharactersSearchLog) {
        var viewScreenEvent = AnalyticsEvent(
          AnalyticsConstants.eventViewSearchResults,
          AnalyticsConstants.screenNameBrands,
        )
            .withProperty(
                name: AnalyticsConstants.eventPropertySearchTerm,
                strValue: event.query)
            .withProperty(
                name: AnalyticsConstants.eventPropertyResultsCount,
                strValue: resultsCount.toString())
            .withProperty(
                name: AnalyticsConstants.eventPropertySuccessful,
                boolValue: apiCallIsSuccessful);

        _brandUseCase.trackEvent(viewScreenEvent);
      }
    }
  }

  void _onBrandToggleEvent(BrandToggleEvent event, Emitter<BrandState> emit) {
    if (state is BrandSectionLoaded) {
      final currentState = state as BrandSectionLoaded;
      final newIndex =
          currentState.currentPanelIndex == event.index ? -1 : event.index;
      emit(BrandSectionLoaded(currentState.alphabetResult, newIndex));
    }
  }

  Future<void> _onBrandLoadEvent(
      BrandLoadEvent event, Emitter<BrandState> emit) async {
    final result = await _brandUseCase.getBrand(event.brandId);
    final brand = result.getResultSuccessValue();
    if (brand != null) {
      emit(BrandLoaded(brand: brand));
    }
  }
}
