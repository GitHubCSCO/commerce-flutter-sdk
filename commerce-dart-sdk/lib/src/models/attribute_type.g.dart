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
      sort: (json['sort'] as num?)?.toInt(),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttributeTypeToJson(AttributeType instance) =>
    <String, dynamic>{
      if (instance.attributeTypeId case final value?) 'attributeTypeId': value,
      if (instance.name case final value?) 'name': value,
      if (instance.nameDisplay case final value?) 'nameDisplay': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.attributeValueFacets?.map((e) => e.toJson()).toList()
          case final value?)
        'attributeValueFacets': value,
      if (instance.id case final value?) 'id': value,
      if (instance.label case final value?) 'label': value,
      if (instance.isFilter case final value?) 'isFilter': value,
      if (instance.isComparable case final value?) 'isComparable': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.attributeValues?.map((e) => e.toJson()).toList()
          case final value?)
        'attributeValues': value,
    };
