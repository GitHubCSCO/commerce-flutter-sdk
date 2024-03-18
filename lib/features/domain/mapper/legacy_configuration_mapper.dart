import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LegacyConfigurationEntityMapper {
  LegacyConfigurationEntity toEntity(LegacyConfiguration? model) =>
      LegacyConfigurationEntity(
        sections: model?.sections
            ?.map((section) => ConfigSectionEntityMapper().toEntity(section))
            .toList(),
        hasDefaults: model?.hasDefaults,
        isKit: model?.isKit,
      );

  LegacyConfiguration? toModel(LegacyConfigurationEntity? entity) =>
      entity == null
          ? null
          : LegacyConfiguration(
              sections: entity.sections
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
        options: model.options
            ?.map(
                (option) => ConfigSectionOptionEntityMapper().toEntity(option))
            .toList(),
        id: model.id,
        sortOrder: model.sortOrder,
      );
  ConfigSection toModel(ConfigSectionEntity entity) => ConfigSection(
        sectionName: entity.sectionName,
        options: entity.options
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
        sectionOptionId: model.sectionOptionId,
        sectionName: model.sectionName,
        productName: model.productName,
        productId: model.productId,
        description: model.description,
        price: model.price,
        userProductPrice: model.userProductPrice,
        selected: model.selected,
        sortOrder: model.sortOrder,
        id: model.id,
        name: model.name,
        quantity: model.quantity,
      );

  ConfigSectionOption toModel(ConfigSectionOptionEntity entity) =>
      ConfigSectionOption(
        sectionOptionId: entity.sectionOptionId,
        sectionName: entity.sectionName,
        productName: entity.productName,
        productId: entity.productId,
        description: entity.description,
        price: entity.price,
        userProductPrice: entity.userProductPrice,
        selected: entity.selected,
        sortOrder: entity.sortOrder,
        id: entity.id,
        name: entity.name,
        quantity: entity.quantity,
      );
}
