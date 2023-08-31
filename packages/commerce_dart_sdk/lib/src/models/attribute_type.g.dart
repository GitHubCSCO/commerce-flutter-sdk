// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeType _$AttributeTypeFromJson(Map<String, dynamic> json) =>
    AttributeType(
      attributeTypeId: json['attributeTypeId'] as String?,
      attributeValueFacets: (json['attributeValueFacets'] as List<dynamic>?)
          ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributeValues: (json['attributeValues'] as List<dynamic>?)
          ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
      isComparable: json['isComparable'] as bool?,
      isFilter: json['isFilter'] as bool?,
      label: json['label'] as String?,
      name: json['name'] as String?,
      nameDisplay: json['nameDisplay'] as String?,
      sort: json['sort'] as int?,
      sortOrder: json['sortOrder'] as int?,
    );

Map<String, dynamic> _$AttributeTypeToJson(AttributeType instance) =>
    <String, dynamic>{
      'attributeTypeId': instance.attributeTypeId,
      'name': instance.name,
      'nameDisplay': instance.nameDisplay,
      'sort': instance.sort,
      'attributeValueFacets':
          instance.attributeValueFacets?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'label': instance.label,
      'isFilter': instance.isFilter,
      'isComparable': instance.isComparable,
      'isActive': instance.isActive,
      'sortOrder': instance.sortOrder,
      'attributeValues':
          instance.attributeValues?.map((e) => e.toJson()).toList(),
    };
