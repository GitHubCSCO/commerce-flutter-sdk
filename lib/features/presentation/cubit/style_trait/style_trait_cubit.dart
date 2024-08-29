import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/style_trait/style_trait_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StyleTraitCubit extends Cubit<StyleTraitState> {
  final ProductDetailsStyleTraitsUseCase _styleTraitsUseCase;
  late ProductEntity product;
  StyledProductEntity? styledProductEntity;
  Map<String, List<StyleValueEntity>?> availableStyleValues = {};
  Map<String, StyleValueEntity?>? selectedStyleValues = {};

  StyleTraitCubit(
      {required ProductDetailsStyleTraitsUseCase styleTraitsUseCase})
      : _styleTraitsUseCase = styleTraitsUseCase,
        super(StyleTraitStateLoading());

  void initSelectedAvailableTraitValues(ProductEntity product) {
    this.product = product;

    if (product.styledProducts != null) {
      if (product.styleParentId != null) {
        for (var styledProduct in product.styledProducts ?? []) {
          if (styledProduct.productId == product.id) {
            styledProductEntity = styledProduct;
            break;
          }
        }
      }
    }
    availableStyleValues = _styleTraitsUseCase.getAvailableStyleValues(product);
    selectedStyleValues = _styleTraitsUseCase.getSelectedStyleValues(
        product, styledProductEntity);
  }

  Future<void> fetchStyleTraitValues(ProductEntity product) async {
    if (product.styleTraits == null || product.styleTraits!.isEmpty) {
      return;
    }
    emit(StyleTraitStateLoading());
    this.product = product;
    final List<ProductDetailStyleTrait> styleTraitsEntity = [];

    for (var styleTrait in product.styleTraits!) {
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

  void updateStyledProductBasedOnSelection(
      StyleValueEntity selectedStyleValue) {
    var styledProduct = _styleTraitsUseCase.getStyledProductBasedOnSelection(
        selectedStyleValue, product, availableStyleValues, selectedStyleValues);

    styledProductEntity = styledProduct;

    fetchStyleTraitValues(product);
  }

  bool isStyledProductCreated() {
    return styledProductEntity != null;
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
