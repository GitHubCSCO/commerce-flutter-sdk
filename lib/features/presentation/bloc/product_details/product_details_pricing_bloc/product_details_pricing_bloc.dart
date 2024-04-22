import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
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

    var productDetailsPricingEntity = event.productDetailsPricingEntity;
    var product = event.product!;
    final styledProduct = event.styledProduct;
    final quantity = event.quantity;
    final productPricingEnabled = event.productPricingEnabled;
    final chosenUnitOfMeasure = event.chosenUnitOfMeasure;
    final realtimeProductAvailabilityEnabled =
        event.realtimeProductAvailabilityEnabled;
    final realtimeProductPricingEnabled = event.realtimeProductPricingEnabled;

    final result = await _productDetailsPricingUseCase.loadProductPricing(
        product,
        styledProduct,
        chosenUnitOfMeasure,
        realtimeProductPricingEnabled,
        quantity!);

    ProductPriceEntity? data =
        (result is Success) ? (result as Success).value : null;

    if (productPricingEnabled != null && productPricingEnabled) {
      var priceValueText =
          (data != null && data.isOnSale != null && data.isOnSale!)
              ? data.unitNetPriceDisplay
              : data.getPriceValue();
      var discountMessage = data.getDiscountValue();
      var selectedUnitOfMeasureValueText =
          data.getUnitOfMeasure(data?.unitOfMeasure ?? '');
      product = product.copyWith(pricing: data);
      productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
          priceValueText: priceValueText,
          discountMessage: discountMessage,
          selectedUnitOfMeasureValueText: selectedUnitOfMeasureValueText,
          productPricingEnabled: productPricingEnabled,
          product: product,
          styledProduct: styledProduct,
          quantity: quantity);
    } else {
      productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
          priceValueText: SiteMessageConstants.valuePricingSignInForPrice,
          productPricingEnabled: productPricingEnabled,
          product: product,
          styledProduct: styledProduct,
          quantity: quantity,
          selectedUnitOfMeasureValueText: null);
    }
    if (realtimeProductAvailabilityEnabled) {
      productDetailsPricingEntity = await _loadRealTimeInventory(
          productDetailsPricingEntity, chosenUnitOfMeasure, product);
    }

    emit(ProductDetailsPricingLoaded(
        productDetailsPriceEntity: productDetailsPricingEntity));
  }

  Future<ProductDetailsPriceEntity> _loadRealTimeInventory(
      ProductDetailsPriceEntity productDetailsPricingEntity,
      ProductUnitOfMeasureEntity? chosenUnitOfMeasure,
      ProductEntity? product) async {
    var realTimeInventory =
        await _productDetailsPricingUseCase.loadRealTimeInventory(product!);

    GetRealTimeInventoryResult? inventory = (realTimeInventory is Success)
        ? (realTimeInventory as Success).value
        : null;

    productDetailsPricingEntity = _productDetailsPricingUseCase
        .updateProductOrStyleProductRealTimeInventory(
            inventory,
            productDetailsPricingEntity.product!,
            productDetailsPricingEntity.styledProduct,
            productDetailsPricingEntity,
            chosenUnitOfMeasure);

    // need to implement hide/show inventory and quanty button logix

    var availability = productDetailsPricingEntity.styledProduct == null
        ? productDetailsPricingEntity.product?.availability
        : productDetailsPricingEntity.styledProduct?.availability;

    productDetailsPricingEntity =
        productDetailsPricingEntity.copyWith(availability: availability);
    return productDetailsPricingEntity;
  }
}
