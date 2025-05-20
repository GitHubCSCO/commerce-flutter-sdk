import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsPricingBloc
    extends Bloc<ProductDetailsPricingEvent, ProductDetailsPricingState> {
  final ProductDetailsAddToCartUseCase _addToCartUseCase =
      ProductDetailsAddToCartUseCase();
  final ProductDetailsPricingUseCase _productDetailsPricingUseCase;
  final ProductDetailsStyleTraitsUseCase _productDetailsStyleTraitUseCase;
  late ProductDetailsPriceEntity productDetailsPricingEntity;
  ProductDetailsPricingBloc(
      {required ProductDetailsPricingUseCase productDetailsPricingUseCase,
      required ProductDetailsStyleTraitsUseCase
          productDetailsStyleTraitUseCase})
      : _productDetailsPricingUseCase = productDetailsPricingUseCase,
        _productDetailsStyleTraitUseCase = productDetailsStyleTraitUseCase,
        super(ProductDetailsPricingInitial()) {
    on<LoadProductDetailsPricing>(_fetchProductDetailsPricing);
  }

  Future<void> _fetchProductDetailsPricing(LoadProductDetailsPricing event,
      Emitter<ProductDetailsPricingState> emit) async {
    emit(ProductDetailsPricingLoading());

    var isOnline = await _productDetailsPricingUseCase.isOnline();

    if (!isOnline) {
      emit(ProductDetailsPricingErrorState(
          LocalizationConstants.noInternet.localized()));
      return;
    }

    var productDetailsPricingEntity = event.productDetailsPricingEntity;
    var product = event.productDetailsDataEntity.product!;
    final styledProduct = event.productDetailsDataEntity.styledProduct;
    final quantity = event.quantity;
    final productPricingEnabled =
        event.productDetailsDataEntity.productPricingEnabled;
    final chosenUnitOfMeasure =
        event.productDetailsDataEntity.chosenUnitOfMeasure;
    final realtimeProductAvailabilityEnabled =
        event.productDetailsDataEntity.realtimeProductAvailabilityEnabled!;
    final realtimeProductPricingEnabled =
        event.productDetailsDataEntity.realtimeProductPricingEnabled!;
    final productSettings = event.productDetailsDataEntity.productSettings!;
    final selectedConfigurations =
        event.productDetailsDataEntity.selectedConfigurations!;
    final selectedStyleValues =
        event.productDetailsDataEntity.selectedStyleValues;
    final hasCheckout = event.productDetailsDataEntity.hasCheckout!;
    final addToCartEnabled = event.productDetailsDataEntity.addToCartEnabled!;
    final choosenUnitOfMeasure =
        event.productDetailsDataEntity.chosenUnitOfMeasure;

    final result = await _productDetailsPricingUseCase.loadProductPricing(
        product,
        styledProduct,
        chosenUnitOfMeasure,
        realtimeProductPricingEnabled,
        productPricingEnabled!,
        quantity!,
        selectedConfigurations);

    ProductPriceEntity? data =
        (result is Success) ? (result as Success).value : null;

    if (productPricingEnabled != null && productPricingEnabled) {
      var priceValueText =
          (data != null && data.isOnSale != null && data.isOnSale!)
              ? data.unitNetPriceDisplay
              : data.getPriceValue(allowZeroPricing: product.allowZeroPricing);
      var discountMessage = data.getDiscountValue();

      var selectedUnitOfMeasureValueText = '';
      if (chosenUnitOfMeasure?.description?.isNotEmpty ?? false) {
        selectedUnitOfMeasureValueText = chosenUnitOfMeasure!.description!;
      } else if (chosenUnitOfMeasure?.unitOfMeasureDisplay?.isNotEmpty ??
          false) {
        selectedUnitOfMeasureValueText =
            chosenUnitOfMeasure!.unitOfMeasureDisplay!;
      } else {
        selectedUnitOfMeasureValueText = '';
      }

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

    productDetailsPricingEntity =
        await _loadQuantityPricingAndShowInventoryData(
            productDetailsPricingEntity,
            productSettings,
            productDetailsPricingEntity.styledProduct,
            productDetailsPricingEntity.product!,
            data,
            selectedConfigurations,
            selectedStyleValues,
            hasCheckout,
            addToCartEnabled,
            quantity,
            choosenUnitOfMeasure);
    this.productDetailsPricingEntity = productDetailsPricingEntity;
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

    return productDetailsPricingEntity;
  }

  Future<ProductDetailsPriceEntity> _loadQuantityPricingAndShowInventoryData(
      ProductDetailsPriceEntity productDetailsPricingEntity,
      ProductSettings productSettings,
      StyledProductEntity? styledProduct,
      ProductEntity product,
      ProductPriceEntity? productPricing,
      Map<String, ConfigSectionOptionEntity?> selectedConfigurations,
      Map<String, StyleValueEntity?>? selectedStyleValues,
      bool hasCheckout,
      bool addToCartEnabled,
      int quantity,
      ProductUnitOfMeasureEntity? choosenUnitOfMeasure) async {
    var availability = styledProduct == null
        ? product.availability
        : styledProduct.availability;

    var isProductConfigurable = _isProductConfigurable(selectedConfigurations);
    var isProductConfigurationCompleted =
        _isProductConfigurationCompleted(selectedConfigurations);
    var isAddToCartAllowed = await _addToCartUseCase.getAddToCartVisibility(
        quantity,
        hasCheckout,
        addToCartEnabled,
        product,
        styledProduct,
        selectedStyleValues,
        isProductConfigurable,
        isProductConfigurationCompleted);

    var isAddToCartEnable = await _addToCartUseCase.getAddToCartEnableState(
        quantity,
        hasCheckout,
        addToCartEnabled,
        product,
        styledProduct,
        selectedStyleValues,
        isProductConfigurable,
        isProductConfigurationCompleted);

    productDetailsPricingEntity = productDetailsPricingEntity.copyWith(
        availability: availability,
        addToCartEnabled: isAddToCartEnable,
        addToCartVisible: isAddToCartAllowed);

    if (productSettings.showInventoryAvailability!) {
      var showAvailabilityMessage = true;
      var showAvailabilityPerWarehouseLink = true;

      if (_productDetailsStyleTraitUseCase
          .isProductStyleable(selectedStyleValues)) {
        var isStyleSelectionComplete = _productDetailsStyleTraitUseCase
            .isProductStyleSelectionCompleted(selectedStyleValues);
        showAvailabilityMessage = isStyleSelectionComplete!;
        showAvailabilityPerWarehouseLink = isStyleSelectionComplete;
      } else if (isProductConfigurable) {
        var configurationCompleted = isProductConfigurationCompleted;

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
        chosenUnitOfMeasure: choosenUnitOfMeasure,
        viewQuantityPricingButtonShown: (product.canShowPrice == true) &&
            !(product.quoteRequired == true) &&
            productPricing != null &&
            (productPricing.unitRegularBreakPrices?.length ?? 0) > 1);
    return productDetailsPricingEntity;
  }

  bool _isProductConfigurable(
      Map<String, ConfigSectionOptionEntity?> selectedConfigurations) {
    return selectedConfigurations.keys.isNotEmpty;
  }

  bool _isProductConfigurationCompleted(
      Map<String, ConfigSectionOptionEntity?> selectedConfigurations) {
    if (selectedConfigurations.isEmpty) {
      return false;
    }

    return selectedConfigurations.keys
        .every((k) => selectedConfigurations[k] != null);
  }
}
