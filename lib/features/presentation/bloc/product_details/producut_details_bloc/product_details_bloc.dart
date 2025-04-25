import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_data_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/product_details/producut_details_bloc/produc_details_state.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
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
    var cartLineOfProduct = AddCartLine(
      productId: productDetailDataEntity.styledProduct?.productId ??
          productDetailDataEntity.product?.id,
      qtyOrdered: productDetailDataEntity.product?.qtyOrdered,
      unitOfMeasure: productDetailDataEntity.product?.unitOfMeasure,
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
        _extractValuesFromData(data!);
        await _makeAllDetailsItems(data, emit);
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
  }

  void _extractValuesFromData(ProductEntity productEntity) {
    var product = productEntity;
    StyledProductEntity? styledProduct;
    if (product.styledProducts != null) {
      if (product.styleParentId != null) {
        styledProduct = product.styledProducts
            ?.firstWhere((o) => o.productId == product.id);
      }
    }
    chosenUnitOfMeasure = styledProduct != null &&
            styledProduct.productUnitOfMeasures != null &&
            styledProduct.productUnitOfMeasures!.isNotEmpty
        ? styledProduct.productUnitOfMeasures?.first
        : product.productUnitOfMeasures != null &&
                product.productUnitOfMeasures!.isNotEmpty &&
                product.productUnitOfMeasures!.firstWhere(
                    // ignore: unnecessary_null_comparison
                    (p) => p.unitOfMeasure == product.unitOfMeasure) != null
            ? product.productUnitOfMeasures
                ?.firstWhere((p) => p.unitOfMeasure == product.unitOfMeasure)
            : null;
    Map<String, ConfigSectionOptionEntity?> selectedConfigurations = {};
    if (!(product.styleTraits != null && product.styleTraits!.isNotEmpty) &&
        product.configurationDto != null &&
        product.configurationDto!.sections != null &&
        product.configurationDto!.sections!.isNotEmpty &&
        !product.isFixedConfiguration!) {
      for (var s in product.configurationDto!.sections!) {
        if (selectedConfigurations.containsKey(s.sectionName)) {
          selectedConfigurations[s.sectionName!] = null;
        } else {
          selectedConfigurations[s.sectionName!] = null;
        }
      }
    }

    var selectedStyleValues = _productDetailsStyleTraitsUseCase
        .getSelectedStyleValues(product, styledProduct, null);
    var availableStyleValues =
        _productDetailsStyleTraitsUseCase.getAvailableStyleValues(product);

    var isProductConfigurable = _isProductConfigurable(selectedConfigurations);
    var isProductConfigurationCompleted =
        _isProductConfigurationCompleted(selectedConfigurations);

    productDetailDataEntity = productDetailDataEntity.copyWith(
        product: productEntity,
        styledProduct: styledProduct,
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
      productDetailDataEntity.styledProduct,
      productDetailDataEntity.productPricingEnabled!,
      productDetailDataEntity.availableStyleValues!,
      productDetailDataEntity.selectedStyleValues!,
      productDetailDataEntity.isProductConfigurable!,
      productDetailDataEntity.isProductConfigurationCompleted!,
      productDetailDataEntity.hasCheckout!,
      productDetailDataEntity.addToCartEnabled!,
    );

    emit(
        ProductDetailsLoaded(productDetailsEntities: productDetailsEntotities));
  }

  void onSelectedConfiguration(ConfigSectionOptionEntity option) {
    if (option.sectionOptionId == null || option.sectionOptionId!.isEmpty) {
      productDetailDataEntity.selectedConfigurations?[option.sectionName!] =
          null;
    } else {
      productDetailDataEntity.selectedConfigurations?[option.sectionName!] =
          option;
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
      productDetailDataEntity.styledProduct = null;
      productDetailDataEntity.selectedStyleValues =
          _productDetailsStyleTraitsUseCase.getSelectedStyleValues(
              product, null, productDetailDataEntity.selectedStyleValues);

      await _makeAllDetailsItems(product, emit);
      return;
    }

    var styledProduct =
        _productDetailsStyleTraitsUseCase.getStyledProductBasedOnSelection(
            selectedStyletraitId,
            selectedStyleValue,
            productDetailDataEntity.product!,
            productDetailDataEntity.availableStyleValues!,
            productDetailDataEntity.selectedStyleValues);

    if (styledProduct != null) {
      if (chosenUnitOfMeasure?.unitOfMeasure != null) {
        chosenUnitOfMeasure = styledProduct.productUnitOfMeasures?.firstWhere(
            (p) => p.unitOfMeasure == chosenUnitOfMeasure?.unitOfMeasure);
      } else {
        chosenUnitOfMeasure =
            styledProduct.productUnitOfMeasures?.firstWhere((element) => true);
      }
    } else {
      if (product.productUnitOfMeasures!.isNotEmpty) {
        chosenUnitOfMeasure = product.productUnitOfMeasures
            ?.firstWhere((p) => p.unitOfMeasure == product.unitOfMeasure);
      }
    }
    productDetailDataEntity = productDetailDataEntity.copyWith(
        styledProduct: styledProduct, chosenUnitOfMeasure: chosenUnitOfMeasure);

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
