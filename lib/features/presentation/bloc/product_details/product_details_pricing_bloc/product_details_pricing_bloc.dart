import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
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
    final productSettings = event.productSettings;

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

    var availability = productDetailsPricingEntity.styledProduct == null
        ? productDetailsPricingEntity.product?.availability
        : productDetailsPricingEntity.styledProduct?.availability;

    productDetailsPricingEntity =
        await _loadQuantityPricingAndShowInventoryData(
            productDetailsPricingEntity,
            productSettings,
            styledProduct,
            product,
            availability,
            data);

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

  Future<ProductDetailsPriceEntity> _loadQuantityPricingAndShowInventoryData(
      ProductDetailsPriceEntity productDetailsPricingEntity,
      ProductSettings productSettings,
      StyledProductEntity? styledProduct,
      ProductEntity product,
      AvailabilityEntity? availability,
      ProductPriceEntity? productPricing) async {
    if (productSettings.showInventoryAvailability!) {
      var showAvailabilityMessage = true;
      var showAvailabilityPerWarehouseLink = true;

      if (_isProductStyleable()) {
        var isStyleSelectionComplete = _isProductStyleSelectionCompleted();
        showAvailabilityMessage = isStyleSelectionComplete;
        showAvailabilityPerWarehouseLink = isStyleSelectionComplete;
      } else if (_isProductConfigurable()) {
        var configurationCompleted = _isProductConfigurationCompleted();

        showAvailabilityMessage = configurationCompleted;
        showAvailabilityPerWarehouseLink = configurationCompleted;
      }

      showAvailabilityPerWarehouseLink &= styledProduct != null
          ? styledProduct.trackInventory!
          : product.trackInventory!;

      if (availability != null && availability.message.isNullOrEmpty) {
        showAvailabilityMessage = false;
      }

      var displayInventoryPerWarehouseEnabled =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
              productSettings,
              isProductDetailPage: true);
      productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
          showInventoryAvailability: showAvailabilityMessage,
          viewInventoryByWarehouseShown: showAvailabilityPerWarehouseLink &&
              displayInventoryPerWarehouseEnabled);
    } else {
      productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
          showInventoryAvailability: false,
          viewInventoryByWarehouseShown: false);
    }

    productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
        viewQuantityPricingButtonShown: product.canShowPrice! &&
            !product.quoteRequired! &&
            productPricing != null &&
            productPricing.unitRegularBreakPrices!.length > 1);
    return productDetailsPricingEntity;
  }

  bool _isProductStyleable() {
    // need to implement

    return true;
  }

  bool _isProductConfigurable() {
    // need to implement

    return true;
  }

  bool _isProductStyleSelectionCompleted() {
    // need to implement

    return true;
  }

  bool _isProductConfigurationCompleted() {
    // need to implement

    return true;
  }
}
