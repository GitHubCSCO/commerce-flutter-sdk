// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) =>
    AttributeValue(
      attributeValueId: json['attributeValueId'] as String?,
      count: json['count'] as int?,
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
      selected: json['selected'] as bool?,
      sortOrder: json['sortOrder'] as int?,
      value: json['value'] as String?,
      valueDisplay: json['valueDisplay'] as String?,
    );

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) =>
    <String, dynamic>{
      'attributeValueId': instance.attributeValueId,
      'value': instance.value,
      'valueDisplay': instance.valueDisplay,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'id': instance.id,
      'count': instance.count,
      'selected': instance.selected,
    };
