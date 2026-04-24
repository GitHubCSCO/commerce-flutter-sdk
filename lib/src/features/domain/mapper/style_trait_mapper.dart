import 'package:commerce_flutter_sdk/src/features/domain/entity/style_trait_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/style_value_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class StyleTraitEntityMapper {
  static StyleTraitEntity toEntity(StyleTrait model) => StyleTraitEntity(
        styleTraitId: model.id,
        name: model.name,
        nameDisplay: model.nameDisplay,
        unselectedValue: model.unselectedValue,
        sortOrder: model.sortOrder,
        displayType: model.displayType,
        numberOfSwatchesVisible: model.numberOfSwatchesVisible,
        displayTextWithSwatch: model.displayTextWithSwatch,
        styleValues: model.traitValues
            ?.map((traitValue) => StyleValueEntityMapper.toEntity(traitValue))
            .toList(),
        id: model.id,
        traitValues: model.traitValues
            ?.map((traitValue) => StyleValueEntityMapper.toEntity(traitValue))
            .toList(),
      );

  static StyleTrait toModel(StyleTraitEntity entity) => StyleTrait(
        id: entity.id ?? entity.styleTraitId,
        name: entity.name,
        nameDisplay: entity.nameDisplay,
        unselectedValue: entity.unselectedValue,
        sortOrder: entity.sortOrder,
        traitValues: (entity.traitValues ?? entity.styleValues)
            ?.map((traitValueEntity) =>
                StyleValueEntityMapper.toModel(traitValueEntity))
            .toList(),
      );
}
