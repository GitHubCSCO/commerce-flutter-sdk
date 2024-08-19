import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/produc_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsUseCase _productDetailsUseCase;
  final ProductDetailsStyleTraitsUseCase _productDetailsStyleTraitsUseCase =
      ProductDetailsStyleTraitsUseCase();
  ProductUnitOfMeasureEntity? chosenUnitOfMeasure;
  ProductDetailsDataEntity productDetailDataEntity = ProductDetailsDataEntity();
  late Session session;
  late AccountSettings accountSettings;
  int quantity = 1;

  ProductDetailsBloc({required ProductDetailsUseCase productDetailsUseCase})
      : _productDetailsUseCase = productDetailsUseCase,
        super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_fetchProductDetails);
    on<StyleTraitSelectedEvent>(_onStyleTraitSelected);
    on<UnitOfMeasuteChangeEvent>(_changeUnitOfMeasureEvent);
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

    this.accountSettings = accountSettings!;
    this.session = session!;
    productDetailDataEntity = productDetailDataEntity.copyWith(
        session: session,
        productSettings: productSettings!,
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

    await _loadSettings();

    final result = await _productDetailsUseCase.getProductDetails(
        event.productId, event.product, accountSettings, session);

    switch (result) {
      case Success(value: final data):
        _extractValuesFromData(data!);
        await _makeAllDetailsItems(data, emit);
      case Failure(errorResponse: final errorResponse):
        emit(ProductDetailsErrorState(errorResponse.errorDescription ?? ''));
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
        .getSelectedStyleValues(product, styledProduct);
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
    if (option.sectionOptionId!.isEmpty) {
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
    var product = productDetailDataEntity.product!;

    if (event.selectedStyleValue.styleTraitId == null) {
      productDetailDataEntity.styledProduct = null;
      productDetailDataEntity.selectedStyleValues =
          _productDetailsStyleTraitsUseCase.getSelectedStyleValues(
              product, null);
      await _makeAllDetailsItems(product, emit);
      return;
    }

    var styledProduct =
        _productDetailsStyleTraitsUseCase.getStyledProductBasedOnSelection(
            selectedStyleValue,
            productDetailDataEntity.product!,
            productDetailDataEntity.availableStyleValues!,
            productDetailDataEntity.selectedStyleValues);

    if (styledProduct != null) {
      chosenUnitOfMeasure =
          styledProduct.productUnitOfMeasures?.firstWhere((element) => true);
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
