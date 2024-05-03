import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsStyleTraitsUseCase {
  ProductDetailsStyleTraitsUseCase();

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
      ProductEntity product, StyledProductEntity? styledProduct) {
    Map<String, StyleValueEntity?>? selectedStyleValues = {};

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
}
