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

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('attributeValueId', instance.attributeValueId);
  writeNotNull('value', instance.value);
  writeNotNull('valueDisplay', instance.valueDisplay);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('id', instance.id);
  writeNotNull('count', instance.count);
  writeNotNull('selected', instance.selected);
  return val;
}
