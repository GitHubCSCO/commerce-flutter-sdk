import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_trait_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsStyleTraitsUseCase {
  ProductDetailsStyleTraitsUseCase();

  bool isProductStyleable(Map<String, StyleValueEntity?>? selectedStyleValues) {
    return selectedStyleValues!.keys.isNotEmpty;
  }

  bool isProductStyleSelectionCompleted(
      Map<String, StyleValueEntity?>? selectedStyleValues) {
    if (selectedStyleValues!.isEmpty) {
      return false;
    }

    return selectedStyleValues.keys
        .every((k) => selectedStyleValues[k] != null);
  }

  Map<String, List<StyleValueEntity>?> getAvailableStyleValues(
      ProductEntity product) {
    Map<String, List<StyleValueEntity>?> availableStyleValues = {};
    if (product.styleParentId.isNullOrEmpty && product.styleTraits != null) {
      for (var s in product.styleTraits!) {
        availableStyleValues[s.styleTraitId!] = s.styleValues;
      }
    }
    return availableStyleValues;
  }

  Map<String, StyleValueEntity?>? getSelectedStyleValues(
      ProductEntity product,
      StyledProductEntity? styledProduct,
      Map<String, StyleValueEntity?>? selectedStyleValuesPersisted) {
    Map<String, StyleValueEntity?>? selectedStyleValues = {};
    if (selectedStyleValuesPersisted != null) {
      selectedStyleValues = selectedStyleValuesPersisted;
    }

    if (product.styleParentId != null) {
      selectedStyleValues = styledProduct?.styleValues
          ?.asMap()
          .map((_, item) => MapEntry(item.styleTraitId!, item));
    }

    if (selectedStyleValues == null || selectedStyleValues.isEmpty) {
      product.styleTraits?.forEach((s) {
        selectedStyleValues?[s.styleTraitId!] = null;
      });
    }

    return selectedStyleValues;
  }

  StyledProductEntity? getStyledProductBasedOnSelection(
      String? selectedStyletraitId,
      StyleValueEntity selectedStyleValue,
      ProductEntity product,
      Map<String, List<StyleValueEntity>?> availableStyleValues,
      Map<String, StyleValueEntity?>? selectedStyleValues) {
    StyledProductEntity? styledProduct;
    if (selectedStyleValue.styleTraitValueId != null &&
        selectedStyleValue.styleTraitValueId!.isEmpty) {
      selectedStyleValues?[selectedStyleValue.styleTraitId!] = null;
    } else if (selectedStyleValue.styleTraitValueId != null) {
      selectedStyleValues?[selectedStyleValue.styleTraitId!] =
          selectedStyleValue;
    } else {
      selectedStyleValues?[selectedStyletraitId!] = null;
    }

    var isStyleSelectionComplete =
        isProductStyleSelectionCompleted(selectedStyleValues);

    if (isStyleSelectionComplete!) {
      List<StyledProductEntity>? filteredStyledProducts = [];
      if (product.styledProducts != null) {
        for (var o in product.styledProducts!) {
          if (o.styleValues != null) {
            bool allValuesMatch = true;
            for (var v in o.styleValues!) {
              if (selectedStyleValues != null) {
                bool anyMatch = false;
                for (var s in selectedStyleValues.values) {
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
      styledProduct = filteredStyledProducts.firstWhere((element) => true);
    } else {
      // not all traits has value => the product variant cannot be identified
      styledProduct = null;
    }

    resetAvailabilityStyleTraitsValues(
        availableStyleValues, selectedStyleValues, product);

    return styledProduct;
  }

  ProductDetailStyleValue createStyleTraitNullValue(
      StyleTraitEntity styleTrait) {
    return ProductDetailStyleValue(
        styleValue: StyleValueEntity(
            styleTraitId: styleTrait.id,
            valueDisplay: LocalizationConstants.selectSomething.localized() +
                styleTrait.nameDisplay!),
        displayName: LocalizationConstants.selectSomething.localized() +
            styleTrait.nameDisplay!,
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
    return selectedStyleValues?[styleTrait.styleTraitId] == null
        ? getDefaultStyleTrait(styleValues, styleTraitNullValue)
        : styleValues.firstWhere((x) =>
            selectedStyleValues?[styleTrait.styleTraitId]?.styleTraitValueId ==
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
        styleTraitId: styleTrait.styleTraitId,
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
      ProductEntity product) {
    // Reset available style traits values
    for (var s in product.styleTraits!) {
      availableStyleValues[s.styleTraitId!] =
          List<StyleValueEntity>.from(s.styleValues!);
    }

    if (selectedStyleValues != null) {
      for (var styleTraitId1 in selectedStyleValues.keys) {
        var styleTraitSelectedStyleValue = selectedStyleValues[styleTraitId1];

        // Given trait has style value => filter
        if (styleTraitSelectedStyleValue != null) {
          for (var styleTraitId2 in selectedStyleValues.keys) {
            // Include all available values for the current trait
            if (styleTraitId2 != styleTraitSelectedStyleValue.styleTraitId) {
              var styleValues = List<StyleValueEntity>.from(
                  availableStyleValues[styleTraitId2]!);
              for (var styleValue in styleValues) {
                // Styled products grouped by style value
                var styleValueProducts = product.styledProducts!
                    .where((o) => o.styleValues!.any((s) =>
                        s.styleTraitValueId == styleValue.styleTraitValueId))
                    .toList();
                var currentlySelectedStyleValues = selectedStyleValues.values
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
}
