import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_carousel_state.dart';

class ProductCarouselCubit extends Cubit<ProductCarouselState> {
  final PricingInventoryUseCase _pricingInventoryUseCase;

  ProductCarouselCubit(
      {required PricingInventoryUseCase pricingInventoryUseCase})
      : _pricingInventoryUseCase = pricingInventoryUseCase,
        super(ProductCarouselInitialState());

  Future<void> getCarouselProducts(
      ProductCarouselWidgetEntity widgetEntity) async {
    if (isClosed) {
      return;
    }

    final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();

    if (hidePricingEnable) {
      emit(ProductCarouselLoadedState(
          productCarouselList: widgetEntity.productCarouselList!,
          isPricingLoading: false,
          hidePricingEnable: hidePricingEnable));
    } else {
      emit(ProductCarouselLoadedState(
          productCarouselList: widgetEntity.productCarouselList!,
          isPricingLoading: true));

      final productPricingEnabled =
      await _pricingInventoryUseCase.getProductPricingEnable();

      final productList = widgetEntity.productCarouselList
          ?.map((productCarousel) => productCarousel.product)
          .toList() ??
          [];

      final realTimeResult = await _pricingInventoryUseCase
          .getRealtimeSupportType();

      if (productPricingEnabled && realTimeResult != null) {
        if (realTimeResult == RealTimeSupport.RealTimePricingOnly ||
            realTimeResult ==
                RealTimeSupport.RealTimePricingWithInventoryIncluded ||
            realTimeResult == RealTimeSupport.RealTimePricingAndInventory) {
          final productPriceParameters = productList
              .map((product) =>
              ProductPriceQueryParameter(
                productId: product!.id,
                qtyOrdered: 1,
                unitOfMeasure: product.unitOfMeasure,
              ))
              .toList();

          final parameter = RealTimePricingParameters(
              productPriceParameters: productPriceParameters);

          final pricingResult =
          await _pricingInventoryUseCase.getRealTimePricing(parameter);

          switch (pricingResult) {
            case Success():
              for (var productEntity in productList) {
                var matchingPrice = pricingResult.value?.realTimePricingResults
                    ?.firstWhere((o) => o.productId == productEntity!.id);
                productEntity?.pricing =
                    ProductPriceEntityMapper().toEntity(matchingPrice);
              }
            case Failure():
            default:
          }
        }
      }

      emit(ProductCarouselLoadedState(
          productCarouselList: widgetEntity.productCarouselList!,
          isPricingLoading: false));
    }
  }
}

enum RealTimeSupport {
  NoRealTimePricingAndInventory,
  RealTimePricingOnly,
  RealTimePricingWithInventoryIncluded,
  RealTimePricingAndInventory,
  RealTimeInventory
}
