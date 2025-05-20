import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';

extension ProductUnitOfMeasureExtension on ProductUnitOfMeasureEntity {
  String getUnitOfMeasureTextDisplayWithQuantity() {
    String? dataSourceItem;
    if (description != null && description!.isNotEmpty) {
      dataSourceItem = qtyPerBaseUnitOfMeasure! > 1
          ? '$description /$qtyPerBaseUnitOfMeasure'
          : description;
    } else if (unitOfMeasureDisplay != null &&
        unitOfMeasureDisplay!.isNotEmpty) {
      dataSourceItem = qtyPerBaseUnitOfMeasure! > 1
          ? '$unitOfMeasureDisplay /$qtyPerBaseUnitOfMeasure'
          : unitOfMeasureDisplay;
    }
    return dataSourceItem ?? '';
  }
}
