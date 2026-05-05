import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/style_trait/style_trait_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StyleTraitCubit extends Cubit<StyleTraitState> {
  final ProductDetailsStyleTraitsUseCase _styleTraitsUseCase;
  late ProductEntity product;
  ProductEntity? selectedVariantChild;
  List<ProductEntity> variantChildren = [];
  Map<String, List<StyleValueEntity>?> availableStyleValues = {};
  Map<String, StyleValueEntity?>? selectedStyleValues = {};

  StyleTraitCubit(
      {required ProductDetailsStyleTraitsUseCase styleTraitsUseCase})
      : _styleTraitsUseCase = styleTraitsUseCase,
        super(StyleTraitStateLoading());

  void initSelectedAvailableTraitValues(ProductEntity product,
      {List<ProductEntity>? variantChildren}) {
    this.product = product;
    this.variantChildren = variantChildren ?? [];

    if (product.isVariantParent == true &&
        this.variantChildren.isNotEmpty &&
        product.defaultChildProductId != null) {
      selectedVariantChild = this.variantChildren.firstWhere(
          (child) => child.id == product.defaultChildProductId,
          orElse: () => this.variantChildren.first);
    } else {
      selectedVariantChild = null;
    }
    availableStyleValues = _styleTraitsUseCase.getAvailableStyleValues(product);
    selectedStyleValues = _styleTraitsUseCase.getSelectedStyleValues(
        product, selectedVariantChild, null);
  }

  Future<void> fetchStyleTraitValues(ProductEntity product) async {
    if (product.variantTraits == null || product.variantTraits!.isEmpty) {
      return;
    }
    emit(StyleTraitStateLoading());
    this.product = product;
    final List<ProductDetailStyleTrait> styleTraitsEntity = [];

    for (var styleTrait in product.variantTraits!) {
      var styleTraitNullValue =
          _styleTraitsUseCase.createStyleTraitNullValue(styleTrait);
      List<ProductDetailStyleValue> styleValues = [styleTraitNullValue];

      for (var styleValue in styleTrait.styleValues!) {
        styleValue = _styleTraitsUseCase.updateStyleValueAvailability(
            styleValue, availableStyleValues);
        var styleValueEntity = _styleTraitsUseCase.createStyleValueEntity(
            styleValue, availableStyleValues);
        styleValues.add(styleValueEntity);
      }

      var selectedStyle = _styleTraitsUseCase.getSelectedStyle(
          styleValues, styleTrait, selectedStyleValues, styleTraitNullValue);
      var styleTraitEntity = _styleTraitsUseCase.createStyleTraitEntity(
          styleTrait, styleValues, selectedStyle);

      styleTraitsEntity.add(styleTraitEntity);
    }

    emit(StyleTraitStateLoaded(styleTraitsEntity: styleTraitsEntity));
  }

  void updateVariantChildBasedOnSelection(StyleValueEntity selectedStyleValue) {
    var variantChild = _styleTraitsUseCase.getVariantChildBasedOnSelection(
        null,
        selectedStyleValue,
        product,
        variantChildren,
        availableStyleValues,
        selectedStyleValues);

    selectedVariantChild = variantChild;

    fetchStyleTraitValues(product);
  }

  bool isVariantChildSelected() {
    return selectedVariantChild != null;
  }

  bool isAllTraitSelected() {
    return selectedStyleValues?.values.every((value) => value != null) ?? false;
  }

  ProductDetailStyleTrait? getProductListColorTrait(
      List<ProductDetailStyleTrait> styleTraitsEntities) {
    if (styleTraitsEntities.isNotEmpty) {
      for (var styletrait in styleTraitsEntities) {
        for (var styleValue in styletrait.styleValues!) {
          if (styleValue.styleValue?.swatchType == "Color") {
            return styletrait;
          }
        }
      }
    }
    return null;
  }
}
