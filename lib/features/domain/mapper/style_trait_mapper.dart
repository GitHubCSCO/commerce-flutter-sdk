import 'package:commerce_flutter_app/features/domain/entity/style_trait_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/style_value_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class StyleTraitEntityMapper {
  StyleTraitEntity toEntity(StyleTrait model) => StyleTraitEntity(
        styleTraitId: model.styleTraitId,
        name: model.name,
        nameDisplay: model.nameDisplay,
        unselectedValue: model.unselectedValue,
        sortOrder: model.sortOrder,
        styleValues: model.styleValues
            ?.map((styleValue) => StyleValueEntityMapper().toEntity(styleValue))
            .toList(),
        id: model.id,
        traitValues: model.traitValues
            ?.map((traitValue) => StyleValueEntityMapper().toEntity(traitValue))
            .toList(),
      );

  StyleTrait toModel(StyleTraitEntity entity) => StyleTrait(
        styleTraitId: entity.styleTraitId,
        name: entity.name,
        nameDisplay: entity.nameDisplay,
        unselectedValue: entity.unselectedValue,
        sortOrder: entity.sortOrder,
        styleValues: entity.styleValues
            ?.map((styleValueEntity) =>
                StyleValueEntityMapper().toModel(styleValueEntity))
            .toList(),
        id: entity.id,
        traitValues: entity.traitValues
            ?.map((traitValueEntity) =>
                StyleValueEntityMapper().toModel(traitValueEntity))
            .toList(),
      );
}
