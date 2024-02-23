import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsPricingBloc
    extends Bloc<ProductDetailsPricingEvent, ProductDetailsPricingState> {
  final ProductDetailsPricingUseCase _productDetailsPricingUseCase;
  ProductDetailsPricingBloc(
      {required ProductDetailsPricingUseCase productDetailsPricingUseCase})
      : _productDetailsPricingUseCase = productDetailsPricingUseCase,
        super(ProductDetailsPricingInitial()) {
    on<LoadProductDetailsPricing>(_fetchProductDetailsPricing);
  }

  Future<void> _fetchProductDetailsPricing(LoadProductDetailsPricing event,
      Emitter<ProductDetailsPricingState> emit) async {
    emit(ProductDetailsPricingLoading());
    var productDetailsPricingEntity = event.productDetailsPriceEntity;
    final result = await _productDetailsPricingUseCase.loadProductPricing(
        productDetailsPricingEntity.product!,
        productDetailsPricingEntity.styledProduct,
        1);

    switch (result) {
      case Success(value: final data):
        if (productDetailsPricingEntity.productPricingEnabled != null &&
            productDetailsPricingEntity.productPricingEnabled!) {
          var realTimeInventory = await _productDetailsPricingUseCase
              .loadRealTimeInventory(productDetailsPricingEntity.product!);

          switch (realTimeInventory) {
            case Success(value: final inventory):
              productDetailsPricingEntity = _productDetailsPricingUseCase
                  .updateProductOrStyleProductRealTimeInventory(
                      inventory!,
                      productDetailsPricingEntity.product!,
                      productDetailsPricingEntity.styledProduct,
                      productDetailsPricingEntity);
              break;
            case Failure(errorResponse: final errorResponse):
          }

          var availability = productDetailsPricingEntity.styledProduct == null
              ? productDetailsPricingEntity.product?.availability
              : productDetailsPricingEntity.styledProduct?.availability;

          var priceValueText =
              (data != null && data.isOnSale != null && data.isOnSale!)
                  ? data.unitNetPriceDisplay
                  : data.getPriceValue();
          var discountMessage = data.getDiscountValue();
          var selectedUnitOfMeasureValueText =
              data.getUnitOfMeasure(data?.unitOfMeasure ?? '');
          productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
              pricing: data,
              priceValueText: priceValueText,
              discountMessage: discountMessage,
              selectedUnitOfMeasureValueText: selectedUnitOfMeasureValueText,
              availability: availability);
        } else {
          productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
              priceValueText: SiteMessageConstants.valuePricingSignInForPrice,
              selectedUnitOfMeasureValueText: null);
        }

        emit(ProductDetailsPricingLoaded(
            productDetailsPriceEntity: productDetailsPricingEntity));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(ProductDetailsPricingErrorState(
            errorResponse.errorDescription ?? ''));
        break;
    }
  }
}
