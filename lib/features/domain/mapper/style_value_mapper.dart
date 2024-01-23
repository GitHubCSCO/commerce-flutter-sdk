import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class StyleValueEntityMapper {
  StyleValueEntity toEntity(StyleValue model) => StyleValueEntity(
        styleTraitName: model.styleTraitName,
        styleTraitId: model.styleTraitId,
        styleTraitValueId: model.styleTraitValueId,
        value: model.value,
        valueDisplay: model.valueDisplay,
        sortOrder: model.sortOrder,
        isDefault: model.isDefault,
        id: model.id,
      );
}
