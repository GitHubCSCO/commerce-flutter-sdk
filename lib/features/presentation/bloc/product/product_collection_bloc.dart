import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductCollectionBloc extends Bloc<ProductEvent, ProductState> {
  final SearchUseCase _searchUseCase;

  ProductCollectionBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(ProductInitial()) {
    on<ProductLoadEvent>((event, emit) => _onProductLoadEvent(event, emit));
  }

  Future<void> _onProductLoadEvent(
      ProductLoadEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    var apiCallIsSuccessful = false;
    var resultsCount = 0;

    Result<GetProductCollectionResult, ErrorResponse>? result;
    if (event.entity.parentType == ProductParentType.category) {
      result = await _searchUseCase.loadSearchProductsResults(
          event.entity.query, 1,
          selectedCategoryId:
              event.entity.category?.id ?? event.entity.categoryId ?? '');
    } else if (event.entity.parentType == ProductParentType.brand ||
        event.entity.parentType == ProductParentType.brandCategory) {
      result = await _searchUseCase.loadSearchProductsResults(
          event.entity.query, 1,
          selectedCategoryId: event.entity.categoryId,
          selectedBrandIds: [
            event.entity.brandEntity?.id ?? event.entity.brandEntityId ?? ''
          ]);
    } else if (event.entity.parentType == ProductParentType.brandProductLine) {
      result = await _searchUseCase.loadSearchProductsResults(
          event.entity.query, 1, selectedProductLineIds: [
        event.entity.brandProductLine?.id ?? ''
      ], selectedBrandIds: [
        event.entity.brandEntity?.id ?? event.entity.brandEntityId ?? ''
      ]);
    }

    switch (result) {
      case Success(value: final data):
        apiCallIsSuccessful = true;
        resultsCount = data?.products?.length ?? 0;
        emit(ProductLoaded(result: data));
      case Failure(errorResponse: final errorResponse):
        emit(ProductFailed(errorResponse.errorDescription ?? ''));
      default:
    }

    _trackViewSearchResultsEvent(
        event.entity, apiCallIsSuccessful, resultsCount);
  }

  void _trackViewSearchResultsEvent(
      ProductPageEntity entity, bool apiCallIsSuccessful, int resultsCount) {
    if (entity.query.isNotEmpty) {
      late String screenName,
          eventPropertyReferenceId,
          eventPropertyReferenceName;
      switch (entity.parentType) {
        case ProductParentType.search:
        // TODO: Handle this case.
        case ProductParentType.category:
          screenName = AnalyticsConstants.screenNameProductList;
          eventPropertyReferenceId = entity.category?.id ?? '';
          eventPropertyReferenceName = entity.category?.shortDescription ?? '';
        case ProductParentType.brand:
          screenName = AnalyticsConstants.screenNameBrandProductList;
          eventPropertyReferenceId = entity.brandEntity?.id ?? '';
          eventPropertyReferenceName = entity.brandEntity?.name ?? '';
        case ProductParentType.brandProductLine:
          screenName = AnalyticsConstants.screenNameBrandProductLineProductList;
          eventPropertyReferenceId = entity.brandProductLine?.id ?? '';
          eventPropertyReferenceName = entity.brandProductLine?.name ?? '';
        case ProductParentType.brandCategory:
          screenName = AnalyticsConstants.screenNameBrandCategoryProductList;
          eventPropertyReferenceId = entity.categoryId ?? '';
          eventPropertyReferenceName = entity.brandEntityTitle ?? '';
      }

      var viewScreenEvent =
          AnalyticsEvent(AnalyticsConstants.eventViewScreen, screenName)
              .withProperty(
                  name: AnalyticsConstants.eventPropertySearchTerm,
                  strValue: entity.query)
              .withProperty(
                  name: AnalyticsConstants.eventPropertyReferenceId,
                  strValue: eventPropertyReferenceId)
              .withProperty(
                  name: AnalyticsConstants.eventPropertyReferenceName,
                  strValue: eventPropertyReferenceName)
              .withProperty(
                  name: AnalyticsConstants.eventPropertyResultsCount,
                  strValue: resultsCount.toString())
              .withProperty(
                  name: AnalyticsConstants.eventPropertySuccessful,
                  strValue: apiCallIsSuccessful.toString());
      _searchUseCase.trackEvent(viewScreenEvent);
    }
  }
}
