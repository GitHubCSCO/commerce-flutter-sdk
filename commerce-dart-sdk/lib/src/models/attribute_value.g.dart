// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) =>
    AttributeValue(
      attributeValueId: json['attributeValueId'] as String?,
      count: (json['count'] as num?)?.toInt(),
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
      selected: json['selected'] as bool?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      value: json['value'] as String?,
      valueDisplay: json['valueDisplay'] as String?,
    );

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) =>
    <String, dynamic>{
      if (instance.attributeValueId case final value?)
        'attributeValueId': value,
      if (instance.value case final value?) 'value': value,
      if (instance.valueDisplay case final value?) 'valueDisplay': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.id case final value?) 'id': value,
      if (instance.count case final value?) 'count': value,
      if (instance.selected case final value?) 'selected': value,
    };
