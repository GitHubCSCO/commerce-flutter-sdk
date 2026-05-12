import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/style_trait_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsStyleTraitsUseCase {
  ProductDetailsStyleTraitsUseCase();

  bool isProductStyleable(Map<String, StyleValueEntity?>? selectedStyleValues) {
    return selectedStyleValues != null && selectedStyleValues.keys.isNotEmpty;
  }

  bool isProductStyleSelectionCompleted(
      Map<String, StyleValueEntity?>? selectedStyleValues) {
    if (selectedStyleValues == null || selectedStyleValues.isEmpty) {
      return false;
    }

    return selectedStyleValues.keys
        .every((k) => selectedStyleValues[k] != null);
  }

  Map<String, List<StyleValueEntity>?> getAvailableStyleValues(
      ProductEntity product) {
    Map<String, List<StyleValueEntity>?> availableStyleValues = {};
    if (product.isVariantParent == true && product.variantTraits != null) {
      for (var s in product.variantTraits!) {
        availableStyleValues[s.id!] = s.traitValues;
      }
    }
    return availableStyleValues;
  }

  Map<String, StyleValueEntity?>? getSelectedStyleValues(
      ProductEntity product,
      ProductEntity? selectedVariantChild,
      Map<String, StyleValueEntity?>? selectedStyleValuesPersisted) {
    Map<String, StyleValueEntity?>? selectedStyleValues = {};
    if (selectedStyleValuesPersisted != null) {
      selectedStyleValues = selectedStyleValuesPersisted;
    }

    if (selectedVariantChild != null &&
        selectedVariantChild.childTraitValues != null) {
      selectedStyleValues = {};
      for (var ctv in selectedVariantChild.childTraitValues!) {
        selectedStyleValues[ctv.styleTraitId!] = StyleValueEntity(
          styleTraitId: ctv.styleTraitId,
          styleTraitValueId: ctv.id,
          value: ctv.value,
          valueDisplay: ctv.valueDisplay,
        );
      }
    }

    if (selectedStyleValues == null || selectedStyleValues.isEmpty) {
      product.variantTraits?.forEach((s) {
        selectedStyleValues?[s.id!] = null;
      });
    }

    return selectedStyleValues;
  }

  ProductEntity? getVariantChildBasedOnSelection(
      String? selectedStyletraitId,
      StyleValueEntity selectedStyleValue,
      ProductEntity product,
      List<ProductEntity> variantChildren,
      Map<String, List<StyleValueEntity>?> availableStyleValues,
      Map<String, StyleValueEntity?>? selectedStyleValues) {
    ProductEntity? selectedVariantChild;
    if (selectedStyleValue.styleTraitValueId != null &&
        selectedStyleValue.styleTraitValueId!.isEmpty) {
      selectedStyleValues?[selectedStyleValue.styleTraitId!] = null;
    } else if (selectedStyleValue.styleTraitValueId != null) {
      selectedStyleValues?[selectedStyleValue.styleTraitId!] =
          selectedStyleValue;
    } else {
      var traitId = selectedStyletraitId ?? selectedStyleValue.styleTraitId;
      if (traitId != null) {
        selectedStyleValues?[traitId] = null;
      }
    }

    var isStyleSelectionComplete =
        isProductStyleSelectionCompleted(selectedStyleValues);

    if (isStyleSelectionComplete!) {
      for (var child in variantChildren) {
        if (child.childTraitValues != null) {
          bool allMatch = true;
          for (var selectedValue in selectedStyleValues!.values) {
            if (selectedValue == null) {
              allMatch = false;
              break;
            }
            final hasMatch = child.childTraitValues!.any(
              (ctv) =>
                  ctv.styleTraitId == selectedValue.styleTraitId &&
                  ctv.id == selectedValue.styleTraitValueId,
            );
            if (!hasMatch) {
              allMatch = false;
              break;
            }
          }
          if (allMatch) {
            selectedVariantChild = child;
            break;
          }
        }
      }
    } else {
      selectedVariantChild = null;
    }

    resetAvailabilityStyleTraitsValues(
        availableStyleValues, selectedStyleValues, product, variantChildren);

    return selectedVariantChild;
  }

  ProductDetailStyleValue createStyleTraitNullValue(
      StyleTraitEntity styleTrait) {
    return ProductDetailStyleValue(
        styleValue: StyleValueEntity(
            styleTraitId: styleTrait.id,
            valueDisplay:
                '${LocalizationConstants.selectSomething.localized()} ${styleTrait.nameDisplay ?? ''}'),
        displayName:
            '${LocalizationConstants.selectSomething.localized()} ${styleTrait.nameDisplay ?? ''}',
        isAvailable: true);
  }

  StyleValueEntity updateStyleValueAvailability(StyleValueEntity styleValue,
      Map<String, List<StyleValueEntity>?> availableStyleValues) {
    return styleValue.copyWith(
        isAvailable: availableStyleValues[styleValue.styleTraitId]!
            .any((x) => x.styleTraitValueId == styleValue.styleTraitValueId));
  }

  ProductDetailStyleValue createStyleValueEntity(StyleValueEntity styleValue,
      Map<String, List<StyleValueEntity>?> availableStyleValues) {
    return ProductDetailStyleValue(
        styleValue: styleValue,
        displayName: availableStyleValues[styleValue.styleTraitId] != null &&
                availableStyleValues[styleValue.styleTraitId]!.any(
                    (x) => x.styleTraitValueId == styleValue.styleTraitValueId)
            ? styleValue.valueDisplay
            : "N/A - ${styleValue.valueDisplay!}",
        isAvailable: availableStyleValues[styleValue.styleTraitId]!
            .any((x) => x.styleTraitValueId == styleValue.styleTraitValueId));
  }

  ProductDetailStyleValue getSelectedStyle(
      List<ProductDetailStyleValue> styleValues,
      StyleTraitEntity styleTrait,
      Map<String, StyleValueEntity?>? selectedStyleValues,
      ProductDetailStyleValue styleTraitNullValue) {
    return selectedStyleValues?[styleTrait.id] == null
        ? getDefaultStyleTrait(styleValues, styleTraitNullValue)
        : styleValues.firstWhere((x) =>
            selectedStyleValues?[styleTrait.id]?.styleTraitValueId ==
            x.styleValue?.styleTraitValueId);
  }

  ProductDetailStyleValue getDefaultStyleTrait(
      List<ProductDetailStyleValue> styleValues,
      ProductDetailStyleValue styleTraitNullValue) {
    return styleValues.firstWhere(
      (x) => x.styleValue?.isDefault == true,
      orElse: () => styleTraitNullValue,
    );
  }

  ProductDetailStyleTrait createStyleTraitEntity(
      StyleTraitEntity styleTrait,
      List<ProductDetailStyleValue> styleValues,
      ProductDetailStyleValue selectedStyle) {
    return ProductDetailStyleTrait(
        styleTraitId: styleTrait.id,
        styleTraitName: styleTrait.nameDisplay,
        styleValues: styleValues,
        selectedStyleValue: selectedStyle,
        displayTextWithSwatch: styleTrait.displayTextWithSwatch,
        displayType: styleTrait.displayType,
        numberOfSwatchesVisible: styleTrait.numberOfSwatchesVisible);
  }

  void resetAvailabilityStyleTraitsValues(
      Map<String, List<StyleValueEntity>?> availableStyleValues,
      Map<String, StyleValueEntity?>? selectedStyleValues,
      ProductEntity product,
      List<ProductEntity> variantChildren) {
    for (var s in product.variantTraits!) {
      availableStyleValues[s.id!] =
          List<StyleValueEntity>.from(s.traitValues!);
    }

    if (selectedStyleValues != null) {
      for (var styleTraitId1 in selectedStyleValues.keys) {
        var styleTraitSelectedStyleValue = selectedStyleValues[styleTraitId1];

        if (styleTraitSelectedStyleValue != null) {
          for (var styleTraitId2 in selectedStyleValues.keys) {
            if (styleTraitId2 != styleTraitSelectedStyleValue.styleTraitId) {
              var styleValues = List<StyleValueEntity>.from(
                  availableStyleValues[styleTraitId2]!);
              for (var styleValue in styleValues) {
                var styleValueChildren = variantChildren
                    .where((child) =>
                        child.childTraitValues != null &&
                        child.childTraitValues!.any((ctv) =>
                            ctv.styleTraitId == styleValue.styleTraitId &&
                            ctv.id == styleValue.styleTraitValueId))
                    .toList();
                var currentlySelectedStyleValues = selectedStyleValues.values
                    .where((v) => v != null && v.styleTraitId != styleTraitId2)
                    .toList();

                var hasSelectedStyleValues = styleValueChildren.any((child) =>
                    currentlySelectedStyleValues.every((s) =>
                        child.childTraitValues!.any((ctv) =>
                            ctv.styleTraitId == s!.styleTraitId &&
                            ctv.id == s.styleTraitValueId)));

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
}
