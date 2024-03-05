import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_carousel_state.dart';

class ProductCarouselCubit extends Cubit<ProductCarouselState> {
  final ProductCarouselUseCase _productCarouselUseCase;

  ProductCarouselCubit({required ProductCarouselUseCase productCarouselUseCase})
      : _productCarouselUseCase = productCarouselUseCase,
        super(ProductCarouselInitialState());

  Future<void> getCarouselProducts(ProductCarouselWidgetEntity widgetEntity) async {
    if (isClosed) {
      return;
    }
    final result = await _productCarouselUseCase.getProducts(widgetEntity);
    switch (result) {
      case Success():
        final productPricingEnabled = await _productCarouselUseCase.getProductPricingEnable();
        final productList = result.value ?? [];

        final list = productList.map((productEntity) =>
            ProductCarouselEntity(product: productEntity, productPricingEnabled: productPricingEnabled)).toList();

        emit(ProductCarouselLoadedState(productCarouselList: list, isPricingLoading: true));

        if (productPricingEnabled) {
          final realTimeResult = RealTimeSupport.RealTimePricingOnly;

          if (realTimeResult != null &&
              (realTimeResult == RealTimeSupport.RealTimePricingOnly ||
                  realTimeResult == RealTimeSupport.RealTimePricingWithInventoryIncluded ||
                  realTimeResult == RealTimeSupport.RealTimePricingAndInventory)) {
            final productPriceParameters = productList.map((product) =>
                ProductPriceQueryParameter(
                  productId: product.id,
                  qtyOrdered: 1,
                  unitOfMeasure: product.unitOfMeasure,
                )).toList();

            final parameter = RealTimePricingParameters(productPriceParameters: productPriceParameters);

            final pricingResult = await _productCarouselUseCase.getRealTimePricing(parameter);

            switch(pricingResult) {
              case Success():
                for(var productEntity in productList) {
                  var matchingPrice = pricingResult.value?.realTimePricingResults?.firstWhere(
                          (o) => o.productId == productEntity.id
                  );
                  productEntity.pricing = ProductPriceEntityMapper().toEntity(matchingPrice);
                }
              case Failure():
              default:
            }
          }
        }
        emit(ProductCarouselLoadedState(productCarouselList: list, isPricingLoading: false));
        break;
      case Failure():
        emit(ProductCarouselFailureState(error: result.errorResponse.errorDescription!));
        break;
      default:
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