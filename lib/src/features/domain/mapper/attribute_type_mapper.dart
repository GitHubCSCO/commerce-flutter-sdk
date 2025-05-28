import 'package:commerce_flutter_sdk/src/features/domain/entity/attribute_type_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/attribute_value_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AttributeTypeEntityMapper {
  AttributeTypeEntity toEntity(AttributeType model) => AttributeTypeEntity(
        attributeTypeId: model.attributeTypeId,
        name: model.name,
        nameDisplay: model.nameDisplay,
        sort: model.sort,
        attributeValueFacets: model.attributeValueFacets
            ?.map(AttributeValueEntityMapper().toEntity)
            .toList(),
        id: model.id,
        label: model.label,
        isFilter: model.isFilter,
        isComparable: model.isComparable,
        isActive: model.isActive,
        sortOrder: model.sortOrder,
        attributeValues: model.attributeValues
            ?.map(AttributeValueEntityMapper().toEntity)
            .toList(),
      );
  AttributeType toModel(AttributeTypeEntity entity) => AttributeType(
        attributeTypeId: entity.attributeTypeId,
        name: entity.name,
        nameDisplay: entity.nameDisplay,
        sort: entity.sort,
        attributeValueFacets: entity.attributeValueFacets
            ?.map((e) => AttributeValueEntityMapper().toModel(e))
            .toList(),
        id: entity.id,
        label: entity.label,
        isFilter: entity.isFilter,
        isComparable: entity.isComparable,
        isActive: entity.isActive,
        sortOrder: entity.sortOrder,
        attributeValues: entity.attributeValues
            ?.map((e) => AttributeValueEntityMapper().toModel(e))
            .toList(),
      );
}
