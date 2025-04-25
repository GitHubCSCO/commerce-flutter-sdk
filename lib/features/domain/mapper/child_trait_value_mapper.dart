import 'package:commerce_flutter_sdk/features/domain/entity/child_trait_value_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ChildTraitValueEntityMapper {
  static ChildTraitValueEntity toEntity(ChildTraitValue model) =>
      ChildTraitValueEntity(
        id: model.id,
        styleTraitId: model.styleTraitId,
        value: model.value,
        valueDisplay: model.valueDisplay,
      );

  static ChildTraitValue toModel(ChildTraitValueEntity entity) =>
      ChildTraitValue(
        id: entity.id,
        styleTraitId: entity.styleTraitId,
        value: entity.value,
        valueDisplay: entity.valueDisplay,
      );
}
