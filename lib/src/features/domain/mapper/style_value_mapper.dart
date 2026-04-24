import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class StyleValueEntityMapper {
  static StyleValueEntity toEntity(StyleValue model) => StyleValueEntity(
        styleTraitValueId: model.id,
        value: model.value,
        valueDisplay: model.valueDisplay,
        sortOrder: model.sortOrder,
        isDefault: model.isDefault,
        id: model.id,
        swatchColorValue: model.swatchColorValue,
        swatchImageValue: model.swatchImageValue,
        swatchType: model.swatchType,
        styleTraitName: null,
        styleTraitId: null,
      );

  static StyleValue toModel(StyleValueEntity entity) => StyleValue(
        id: entity.id ?? entity.styleTraitValueId,
        value: entity.value,
        valueDisplay: entity.valueDisplay,
        sortOrder: entity.sortOrder,
        isDefault: entity.isDefault,
        swatchColorValue: entity.swatchColorValue,
        swatchImageValue: entity.swatchImageValue,
        swatchType: entity.swatchType,
      );
}
