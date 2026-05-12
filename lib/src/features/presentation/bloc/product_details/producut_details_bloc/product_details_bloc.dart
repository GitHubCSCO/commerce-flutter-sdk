import 'package:collection/collection.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_data_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/producut_details_bloc/produc_details_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsUseCase _productDetailsUseCase;
  final ProductDetailsStyleTraitsUseCase _productDetailsStyleTraitsUseCase =
      ProductDetailsStyleTraitsUseCase();
  ProductUnitOfMeasureEntity? chosenUnitOfMeasure;
  ProductDetailsDataEntity productDetailDataEntity = ProductDetailsDataEntity();
  late Session? session;
  late AccountSettings? accountSettings;
  int quantity = 1;

  ProductDetailsBloc({required ProductDetailsUseCase productDetailsUseCase})
      : _productDetailsUseCase = productDetailsUseCase,
        super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_fetchProductDetails);
    on<StyleTraitSelectedEvent>(_onStyleTraitSelected);
    on<UnitOfMeasuteChangeEvent>(_changeUnitOfMeasureEvent);
    on<ProductDetailsReloadEvent>(_onProductDetailsReloadEvent);
  }

  void _onProductDetailsReloadEvent(
      ProductDetailsReloadEvent event, Emitter<ProductDetailsState> emit) {
    emit(ProductDetailsReloadState());
  }

  List<AddCartLine> getAddCartLineForWistlist() {
    final selectedUom =
        productDetailDataEntity.chosenUnitOfMeasure?.unitOfMeasure ??
            productDetailDataEntity.selectedVariantChild?.productUnitOfMeasures
                ?.firstOrNull?.unitOfMeasure ??
            productDetailDataEntity.product?.unitOfMeasure;

    final cartLineOfProduct = AddCartLine(
      productId: productDetailDataEntity.selectedVariantChild?.id ??
          productDetailDataEntity.product?.id,
      qtyOrdered: null,
      unitOfMeasure: selectedUom,
    );
    return [cartLineOfProduct];
  }

  Future<void> _loadSettings() async {
    var futures = [
      _productDetailsUseCase.getCurrentSession(),
      _productDetailsUseCase.loadSetting(),
      _productDetailsUseCase.getCurrentAccountSettings(),
      _productDetailsUseCase.addToCartEnabled(),
      _productDetailsUseCase.productPricingEnabled(),
      _productDetailsUseCase.getRealtimeSupportType(),
      _productDetailsUseCase.hasCheckout(),
    ];

    var results = await Future.wait(futures);

    var sessionResult = results[0];
    var productSettingsResult = results[1];
    var accountSettingsResult = results[2];
    var addToCartEnabledResult = results[3] as bool?;
    var productPricingEnabledResult = results[4] as bool?;
    var currentRealtimeSupportResult = results[5] as RealTimeSupport?;
    var hasCheckout = results[6] as bool;

    ProductSettings? productSettings =
        (productSettingsResult is Success) ? productSettingsResult.value : null;
    AccountSettings? accountSettings =
        (accountSettingsResult is Success) ? accountSettingsResult.value : null;
    bool addToCartEnabled = addToCartEnabledResult ?? false;
    bool productPricingEnabled = productPricingEnabledResult ?? false;
    RealTimeSupport? realtimeSupport = currentRealtimeSupportResult;
    Session? session = (sessionResult is Success) ? sessionResult.value : null;

    var realtimeProductPricingEnabled = realtimeSupport ==
            RealTimeSupport.RealTimePricingOnly ||
        realtimeSupport == RealTimeSupport.RealTimePricingAndInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingWithInventoryIncluded;

    var realtimeProductAvailabilityEnabled = realtimeSupport ==
            RealTimeSupport.RealTimeInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingAndInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingWithInventoryIncluded;

    this.accountSettings = accountSettings;
    this.session = session;
    productDetailDataEntity = productDetailDataEntity.copyWith(
        session: session,
        productSettings: productSettings,
        accountSettings: accountSettings,
        addToCartEnabled: addToCartEnabled,
        productPricingEnabled: productPricingEnabled,
        realtimeSupport: realtimeSupport,
        realtimeProductPricingEnabled: realtimeProductPricingEnabled,
        realtimeProductAvailabilityEnabled: realtimeProductAvailabilityEnabled,
        hasCheckout: hasCheckout);
  }

  Future<void> _fetchProductDetails(
      FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());

    var isOnline = await _productDetailsUseCase.isOnline();

    if (!isOnline) {
      emit(ProductDetailsErrorState(
          LocalizationConstants.noInternet.localized()));
      return;
    }

    await _loadSettings();

    final result = await _productDetailsUseCase.getProductDetails(
        event.productId, event.product, accountSettings, session);

    switch (result) {
      case Success(value: final data):
        if (event.trackScreen == true) {
          _trackViewScreen(data);
        }

        if (data!.isVariantParent == true && data.id != null) {
          try {
            final variantChildren =
                await _productDetailsUseCase.getVariantChildren(data.id!);
            productDetailDataEntity = productDetailDataEntity.copyWith(
                variantChildren: variantChildren);
          } catch (e) {
            // variant children fetch failed, continue without them
          }
        }

        if (data.id != null) {
          try {
            final relatedProducts =
                await _productDetailsUseCase.getRelatedProducts(data.id!);
            productDetailDataEntity = productDetailDataEntity.copyWith(
                relatedProducts: relatedProducts);
          } catch (e) {
            // related products fetch failed, continue without them
          }
        }

        try {
          _extractValuesFromData(data);
          await _makeAllDetailsItems(data, emit);
        } catch (e) {
          emit(ProductDetailsErrorState(e.toString()));
        }
      case Failure(errorResponse: final errorResponse):
        emit(ProductDetailsErrorState(
            LocalizationConstants.errorLoadingProductDetails.localized()));
    }
  }

  Future<void> _changeUnitOfMeasureEvent(
      UnitOfMeasuteChangeEvent event, Emitter<ProductDetailsState> emit) async {
    chosenUnitOfMeasure = event.productunitOfMeasureEntity;
    productDetailDataEntity = productDetailDataEntity.copyWith(
      chosenUnitOfMeasure: chosenUnitOfMeasure,
    );

    await _makeAllDetailsItems(productDetailDataEntity.product!, emit);
  }

  void _trackViewScreen(ProductEntity? product) {
    var viewScreenEvent = AnalyticsEvent(AnalyticsConstants.eventViewScreen,
            AnalyticsConstants.screenNameProductDetail)
        .withProperty(
            name: AnalyticsConstants.eventPropertyProductNumber,
            strValue: product?.getProductNumber());
    _productDetailsUseCase.trackEvent(viewScreenEvent);

    var telemetryEvent =
        TelemetryEvent(screenName: AnalyticsConstants.screenNameProductDetail)
            .withProperty(
                name: AnalyticsConstants.eventPropertyProductNumber,
                strValue: product?.getProductNumber());
    _productDetailsUseCase.trackTelemetryEvent(telemetryEvent);
  }

  void _extractValuesFromData(ProductEntity productEntity) {
    var product = productEntity;
    ProductEntity? selectedVariantChild;
    final variantChildren = productDetailDataEntity.variantChildren;
    if (product.isVariantParent == true &&
        variantChildren != null &&
        variantChildren.isNotEmpty &&
        product.defaultChildProductId != null) {
      selectedVariantChild = variantChildren
          .firstWhereOrNull((o) => o.id == product.defaultChildProductId);
    }
    chosenUnitOfMeasure = selectedVariantChild != null &&
            selectedVariantChild.productUnitOfMeasures != null &&
            selectedVariantChild.productUnitOfMeasures!.isNotEmpty
        ? selectedVariantChild.productUnitOfMeasures?.first
        : product.productUnitOfMeasures
            ?.firstWhereOrNull((p) => p.unitOfMeasure == product.unitOfMeasure);
    Map<String, ConfigSectionOptionEntity?> selectedConfigurations = {};
    if (!(product.variantTraits != null && product.variantTraits!.isNotEmpty) &&
        product.configurationDto != null &&
        product.configurationDto!.sections != null &&
        product.configurationDto!.sections!.isNotEmpty &&
        !(product.isFixedConfiguration ?? false)) {
      for (var s in product.configurationDto!.sections!) {
        if (selectedConfigurations.containsKey(s.sectionName)) {
          selectedConfigurations[s.sectionName!] = null;
        } else {
          selectedConfigurations[s.sectionName!] = null;
        }
      }
    }

    var selectedStyleValues = _productDetailsStyleTraitsUseCase
        .getSelectedStyleValues(product, selectedVariantChild, null);
    var availableStyleValues =
        _productDetailsStyleTraitsUseCase.getAvailableStyleValues(product);

    var isProductConfigurable = _isProductConfigurable(selectedConfigurations);
    var isProductConfigurationCompleted =
        _isProductConfigurationCompleted(selectedConfigurations);

    productDetailDataEntity = productDetailDataEntity.copyWith(
        product: productEntity,
        selectedVariantChild: selectedVariantChild,
        chosenUnitOfMeasure: chosenUnitOfMeasure,
        selectedConfigurations: selectedConfigurations,
        selectedStyleValues: selectedStyleValues,
        availableStyleValues: availableStyleValues,
        isProductConfigurable: isProductConfigurable,
        isProductConfigurationCompleted: isProductConfigurationCompleted);
  }

  Future<void> _makeAllDetailsItems(
      ProductEntity productData, Emitter<ProductDetailsState> emit) async {
    final productDetailsEntotities =
        await _productDetailsUseCase.makeAllDetailsItems(
      productData,
      productDetailDataEntity.selectedVariantChild,
      productDetailDataEntity.productPricingEnabled ?? false,
      productDetailDataEntity.availableStyleValues ?? {},
      productDetailDataEntity.selectedStyleValues ?? {},
      productDetailDataEntity.isProductConfigurable ?? false,
      productDetailDataEntity.isProductConfigurationCompleted ?? false,
      productDetailDataEntity.hasCheckout ?? false,
      productDetailDataEntity.addToCartEnabled ?? false,
      relatedProducts: productDetailDataEntity.relatedProducts,
    );

    emit(
        ProductDetailsLoaded(productDetailsEntities: productDetailsEntotities));
  }

  void onSelectedConfiguration(ConfigSectionOptionEntity option) {
    final name = option.sectionName;
    if (name == null) {
      return;
    }
    if (option.sectionOptionId == null || option.sectionOptionId!.isEmpty) {
      productDetailDataEntity.selectedConfigurations?[name] = null;
    } else {
      productDetailDataEntity.selectedConfigurations?[name] = option;
    }
  }

  void _onStyleTraitSelected(
      StyleTraitSelectedEvent event, Emitter<ProductDetailsState> emit) async {
    var selectedStyleValue = event.selectedStyleValue;
    var selectedStyletraitId = event.styleTraitId;
    var product = productDetailDataEntity.product!;

    if (selectedStyleValue.styleTraitValueId != null &&
        selectedStyleValue.styleTraitValueId!.isEmpty) {
      productDetailDataEntity
          .selectedStyleValues?[selectedStyleValue.styleTraitId!] = null;
    } else if (selectedStyleValue.styleTraitValueId != null) {
      productDetailDataEntity
              .selectedStyleValues?[selectedStyleValue.styleTraitId!] =
          selectedStyleValue;
    } else {
      productDetailDataEntity.selectedStyleValues?[selectedStyletraitId!] =
          null;
    }

    if (productDetailDataEntity.selectedStyleValues == null ||
        (productDetailDataEntity.selectedStyleValues != null &&
            productDetailDataEntity.selectedStyleValues!.values
                .every((value) => value == null))) {
      productDetailDataEntity.selectedVariantChild = null;
      productDetailDataEntity.availableStyleValues =
          _productDetailsStyleTraitsUseCase.getAvailableStyleValues(product);
      productDetailDataEntity.selectedStyleValues =
          _productDetailsStyleTraitsUseCase.getSelectedStyleValues(
              product, null, productDetailDataEntity.selectedStyleValues);

      await _makeAllDetailsItems(product, emit);
      return;
    }

    var selectedVariantChild =
        _productDetailsStyleTraitsUseCase.getVariantChildBasedOnSelection(
            selectedStyletraitId,
            selectedStyleValue,
            productDetailDataEntity.product!,
            productDetailDataEntity.variantChildren ?? [],
            productDetailDataEntity.availableStyleValues!,
            productDetailDataEntity.selectedStyleValues);

    if (selectedVariantChild != null) {
      if (chosenUnitOfMeasure?.unitOfMeasure != null) {
        chosenUnitOfMeasure = selectedVariantChild.productUnitOfMeasures
            ?.firstWhereOrNull(
                (p) => p.unitOfMeasure == chosenUnitOfMeasure?.unitOfMeasure);
      } else {
        chosenUnitOfMeasure =
            selectedVariantChild.productUnitOfMeasures?.firstOrNull;
      }
    } else {
      if (product.productUnitOfMeasures!.isNotEmpty) {
        chosenUnitOfMeasure = product.productUnitOfMeasures
            ?.firstWhereOrNull((p) => p.unitOfMeasure == product.unitOfMeasure);
      }
    }
    productDetailDataEntity = productDetailDataEntity.copyWith(
        chosenUnitOfMeasure: chosenUnitOfMeasure);
    productDetailDataEntity.selectedVariantChild = selectedVariantChild;

    await _makeAllDetailsItems(product, emit);
  }

  void updateQuantity(int quantity) {
    this.quantity = quantity;
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

  bool get shouldShowAddToList {
    return productDetailDataEntity.product != null &&
        (productDetailDataEntity.product?.canAddToWishlist == true ||
            _productDetailsStyleTraitsUseCase.isProductStyleSelectionCompleted(
                productDetailDataEntity.selectedStyleValues));
  }
}
