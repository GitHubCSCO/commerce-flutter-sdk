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

Map<String, dynamic> _$AttributeTypeToJson(AttributeType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('attributeTypeId', instance.attributeTypeId);
  writeNotNull('name', instance.name);
  writeNotNull('nameDisplay', instance.nameDisplay);
  writeNotNull('sort', instance.sort);
  writeNotNull('attributeValueFacets',
      instance.attributeValueFacets?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id);
  writeNotNull('label', instance.label);
  writeNotNull('isFilter', instance.isFilter);
  writeNotNull('isComparable', instance.isComparable);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('attributeValues',
      instance.attributeValues?.map((e) => e.toJson()).toList());
  return val;
}
