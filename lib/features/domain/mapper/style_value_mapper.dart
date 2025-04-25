import 'package:commerce_flutter_sdk/features/domain/entity/style_value_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class StyleValueEntityMapper {
  static StyleValueEntity toEntity(StyleValue model) => StyleValueEntity(
        styleTraitName: model.styleTraitName,
        styleTraitId: model.styleTraitId,
        styleTraitValueId: model.styleTraitValueId,
        value: model.value,
        valueDisplay: model.valueDisplay,
        sortOrder: model.sortOrder,
        isDefault: model.isDefault,
        id: model.id,
        swatchColorValue: model.swatchColorValue,
        swatchImageValue: model.swatchImageValue,
        swatchType: model.swatchType,
      );

  static StyleValue toModel(StyleValueEntity entity) => StyleValue(
        styleTraitName: entity.styleTraitName,
        styleTraitId: entity.styleTraitId,
        styleTraitValueId: entity.styleTraitValueId,
        value: entity.value,
        valueDisplay: entity.valueDisplay,
        sortOrder: entity.sortOrder,
        isDefault: entity.isDefault,
        id: entity.id,
        // swatchColorValue: entity.swatchColorValue,
        // swatchImageValue: entity.swatchImageValue,
        // swatchType: entity.swatchType,
      );
}
