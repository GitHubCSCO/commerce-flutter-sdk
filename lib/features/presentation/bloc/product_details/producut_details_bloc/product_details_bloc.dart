import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
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
  late AccountSettings accountSettings;
  late ProductSettings productSettings;
  late bool addToCartEnabled;
  late bool productPricingEnabled;
  late RealTimeSupport realtimeSupport;
  late bool realtimeProductPricingEnabled;
  late bool realtimeProductAvailabilityEnabled;
  late bool alternateUnitsOfMeasureEnabled;
  late Session session;
  late bool hasCheckout;
  late ProductEntity product;
  StyledProductEntity? styledProduct;
  ProductUnitOfMeasureEntity? chosenUnitOfMeasure;
  Map<String, ConfigSectionOptionEntity?> selectedConfigurations = {};
  Map<String, List<StyleValueEntity>?> availableStyleValues = {};
  Map<String, StyleValueEntity?>? selectedStyleValues = {};

  int quantity = 1;

  ProductDetailsBloc({required ProductDetailsUseCase productDetailsUseCase})
      : _productDetailsUseCase = productDetailsUseCase,
        super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_fetchProductDetails);
    on<StyleTraitSelectedEvent>(_onStyleTraitSelected);
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

    this.session = session!;
    this.productSettings = productSettings!;
    this.accountSettings = accountSettings!;
    this.addToCartEnabled = addToCartEnabled;
    this.productPricingEnabled = productPricingEnabled;
    this.realtimeSupport = realtimeSupport!;

    realtimeProductPricingEnabled = this.realtimeSupport ==
            RealTimeSupport.RealTimePricingOnly ||
        realtimeSupport == RealTimeSupport.RealTimePricingAndInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingWithInventoryIncluded;

    realtimeProductAvailabilityEnabled = realtimeSupport ==
            RealTimeSupport.RealTimeInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingAndInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingWithInventoryIncluded;

    this.hasCheckout = hasCheckout;
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
        _makeAllDetailsItems(product, emit);
      case Failure(errorResponse: final errorResponse):
        emit(ProductDetailsErrorState(errorResponse.errorDescription ?? ''));
    }
  }

  void _extractValuesFromData(ProductEntity productEntity) {
    product = productEntity;
    if (product.styledProducts != null) {
      if (product.styleParentId != null) {
        styledProduct = product.styledProducts
            ?.firstWhere((o) => o.productId == product.id);
      }
    }
    chosenUnitOfMeasure = styledProduct != null &&
            styledProduct?.productUnitOfMeasures != null &&
            styledProduct!.productUnitOfMeasures!.isNotEmpty
        ? styledProduct?.productUnitOfMeasures?.first
        : product.productUnitOfMeasures != null &&
                product.productUnitOfMeasures!.isNotEmpty &&
                product.productUnitOfMeasures!.firstWhere(
                    // ignore: unnecessary_null_comparison
                    (p) => p.unitOfMeasure == product.unitOfMeasure) != null
            ? product.productUnitOfMeasures
                ?.firstWhere((p) => p.unitOfMeasure == product.unitOfMeasure)
            : null;

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

    selectedStyleValues = _productDetailsStyleTraitsUseCase
        .getSelectedStyleValues(product, styledProduct);
    availableStyleValues =
        _productDetailsStyleTraitsUseCase.getAvailableStyleValues(product);
  }

  Future<void> _makeAllDetailsItems(
      ProductEntity productData, Emitter<ProductDetailsState> emit) async {
    final productDetailsEntotities = _productDetailsUseCase.makeAllDetailsItems(
        productData,
        styledProduct,
        productPricingEnabled,
        availableStyleValues,
        selectedStyleValues);
    emit(
        ProductDetailsLoaded(productDetailsEntities: productDetailsEntotities));
  }

  void onSelectedConfiguration(ConfigSectionOptionEntity option) {
    if (option.sectionOptionId!.isEmpty) {
      selectedConfigurations[option.sectionName!] = null;
    } else {
      selectedConfigurations[option.sectionName!] = option;
    }
  }

  void _onStyleTraitSelected(
      StyleTraitSelectedEvent event, Emitter<ProductDetailsState> emit) async {
    var selectedStyleValue = event.selectedStyleValue;
    if (selectedStyleValue.styleTraitValueId!.isEmpty) {
      selectedStyleValues?[selectedStyleValue.styleTraitId!] = null;
    } else {
      selectedStyleValues?[selectedStyleValue.styleTraitId!] =
          selectedStyleValue;
    }

    var isStyleSelectionComplete = isProductStyleSelectionCompleted();

    if (isStyleSelectionComplete!) {
      List<StyledProductEntity>? filteredStyledProducts = [];
      if (product.styledProducts != null) {
        for (var o in product.styledProducts!) {
          if (o.styleValues != null) {
            bool allValuesMatch = true;
            for (var v in o.styleValues!) {
              if (selectedStyleValues != null) {
                bool anyMatch = false;
                for (var s in selectedStyleValues!.values) {
                  if (s != null && s.styleTraitValueId == v.styleTraitValueId) {
                    anyMatch = true;
                    break;
                  }
                }
                if (!anyMatch) {
                  allValuesMatch = false;
                  break;
                }
              } else {
                allValuesMatch = false;
                break;
              }
            }
            if (allValuesMatch) {
              filteredStyledProducts.add(o);
            }
          }
        }
      }

      for (var styleProd in product.styledProducts!) {
        for (var styleVal in styleProd.styleValues!) {
          if (styleVal.styleTraitValueId ==
              selectedStyleValue.styleTraitValueId) {
            styledProduct = styleProd;
            break;
          }
        }
      }
      styledProduct = filteredStyledProducts?.firstWhere((element) => true);
      chosenUnitOfMeasure =
          styledProduct?.productUnitOfMeasures?.firstWhere((element) => true);

      // this.loadProductPricing();
      // this.loadRealTimeInventory();
    } else {
      // not all traits has value => the product variant cannot be identified
      styledProduct = null;
      if (product.productUnitOfMeasures!.isNotEmpty) {
        chosenUnitOfMeasure = product.productUnitOfMeasures
            ?.firstWhere((p) => p.unitOfMeasure == product.unitOfMeasure);
      }
    }

    resetAvailabilityStyleTraitsValues();

    _makeAllDetailsItems(product, emit);
  }

  void resetAvailabilityStyleTraitsValues() {
    // Reset available style traits values
    for (var s in product.styleTraits!) {
      availableStyleValues[s.styleTraitId!] =
          List<StyleValueEntity>.from(s.styleValues!);
    }

    if (selectedStyleValues != null) {
      for (var styleTraitId1 in selectedStyleValues!.keys) {
        var styleTraitSelectedStyleValue = selectedStyleValues![styleTraitId1];

        // Given trait has style value => filter
        if (styleTraitSelectedStyleValue != null) {
          for (var styleTraitId2 in selectedStyleValues!.keys) {
            // Include all available values for the current trait
            if (styleTraitId2 != styleTraitSelectedStyleValue.styleTraitId) {
              var styleValues =
                  List<StyleValueEntity>.from(availableStyleValues[styleTraitId2]!);
              for (var styleValue in styleValues) {
                // Styled products grouped by style value
                var styleValueProducts = product.styledProducts!
                    .where((o) => o.styleValues!.any((s) =>
                        s.styleTraitValueId == styleValue.styleTraitValueId))
                    .toList();
                var currentlySelectedStyleValues = selectedStyleValues!.values
                    .where((v) => v != null && v.styleTraitId != styleTraitId2)
                    .toList();

                var hasSelectedStyleValues = styleValueProducts.any((p) =>
                    currentlySelectedStyleValues.every((s) => p.styleValues!
                        .any((v) =>
                            v.styleTraitValueId == s!.styleTraitValueId)));

                // Check if the filtered product list has ANY object with the selected style values
                // If not, remove style value as not available
                if (!hasSelectedStyleValues) {
                  availableStyleValues[styleTraitId2]!.removeWhere((v) =>
                      v.styleTraitValueId == styleValue.styleTraitValueId);
                }
              }
            }
          }
        }
      }
    }
  }

  bool? isProductStyleSelectionCompleted() {
    if (selectedStyleValues!.isEmpty) {
      return false;
    }

    return selectedStyleValues?.keys
        .every((k) => selectedStyleValues?[k] != null);
  }

  void updateQuantity(int quantity) {
    this.quantity = quantity;
  }
}
