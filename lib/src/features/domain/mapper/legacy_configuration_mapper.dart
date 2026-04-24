import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LegacyConfigurationEntityMapper {
  LegacyConfigurationEntity toEntity(LegacyConfiguration? model) =>
      LegacyConfigurationEntity(
        sections: model?.configSections
            ?.map((section) => ConfigSectionEntityMapper().toEntity(section))
            .toList(),
        hasDefaults: model?.hasDefaults,
        isKit: model?.isKit,
      );

  LegacyConfiguration? toModel(LegacyConfigurationEntity? entity) =>
      entity == null
          ? null
          : LegacyConfiguration(
              configSections: entity.sections
                  ?.map((sectionEntity) =>
                      ConfigSectionEntityMapper().toModel(sectionEntity))
                  .toList(),
              hasDefaults: entity.hasDefaults,
              isKit: entity.isKit,
            );
}

class ConfigSectionEntityMapper {
  ConfigSectionEntity toEntity(ConfigSection model) => ConfigSectionEntity(
        sectionName: model.sectionName,
        options: model.sectionOptions
            ?.map(
                (option) => ConfigSectionOptionEntityMapper().toEntity(option))
            .toList(),
        id: model.id,
        sortOrder: model.sortOrder,
      );
  ConfigSection toModel(ConfigSectionEntity entity) => ConfigSection(
        sectionName: entity.sectionName,
        sectionOptions: entity.options
            ?.map((optionEntity) =>
                ConfigSectionOptionEntityMapper().toModel(optionEntity))
            .toList(),
        id: entity.id,
        sortOrder: entity.sortOrder,
      );
}

class ConfigSectionOptionEntityMapper {
  ConfigSectionOptionEntity toEntity(ConfigSectionOption model) =>
      ConfigSectionOptionEntity(
        sectionOptionId: model.id,
        productId: model.productId,
        description: model.description,
        price: model.price,
        selected: model.selected,
        sortOrder: model.sortOrder,
        id: model.id,
        name: model.name,
        quantity: model.quantity,
        sectionName: null,
        productName: null,
        userProductPrice: null,
      );

  ConfigSectionOption toModel(ConfigSectionOptionEntity entity) =>
      ConfigSectionOption(
        id: entity.id,
        productId: entity.productId,
        description: entity.description,
        price: entity.price,
        selected: entity.selected,
        sortOrder: entity.sortOrder,
        name: entity.name,
        quantity: entity.quantity,
      );
}
