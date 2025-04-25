import 'package:commerce_flutter_sdk/features/domain/entity/attribute_value_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AttributeValueEntityMapper {
  AttributeValueEntity toEntity(AttributeValue model) => AttributeValueEntity(
        attributeValueId: model.attributeValueId,
        value: model.value,
        valueDisplay: model.valueDisplay,
        sortOrder: model.sortOrder,
        isActive: model.isActive,
        id: model.id,
        count: model.count,
        selected: model.selected,
      );
  AttributeValue toModel(AttributeValueEntity entity) => AttributeValue(
        attributeValueId: entity.attributeValueId,
        value: entity.value,
        valueDisplay: entity.valueDisplay,
        sortOrder: entity.sortOrder,
        isActive: entity.isActive,
        id: entity.id,
        count: entity.count,
        selected: entity.selected,
      );
}
