import 'package:commerce_flutter_app/features/domain/entity/child_trait_value_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ChildTraitValueEntityMapper {
  ChildTraitValueEntity toEntity(ChildTraitValue model) =>
      ChildTraitValueEntity(
        id: model.id,
        styleTraitId: model.styleTraitId,
        value: model.value,
        valueDisplay: model.valueDisplay,
      );

  ChildTraitValue toModel(ChildTraitValueEntity entity) => ChildTraitValue(
        id: entity.id,
        styleTraitId: entity.styleTraitId,
        value: entity.value,
        valueDisplay: entity.valueDisplay,
      );
}
