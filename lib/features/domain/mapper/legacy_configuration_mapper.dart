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
}
