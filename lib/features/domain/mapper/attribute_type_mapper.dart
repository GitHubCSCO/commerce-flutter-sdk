import 'package:commerce_flutter_app/features/domain/entity/attribute_type_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/attribute_value_mapper.dart';
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
}
