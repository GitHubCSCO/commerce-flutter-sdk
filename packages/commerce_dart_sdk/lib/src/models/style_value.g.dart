// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleValue _$StyleValueFromJson(Map<String, dynamic> json) => StyleValue(
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool?,
      sortOrder: json['sortOrder'] as int?,
      styleTraitId: json['styleTraitId'] as String?,
      styleTraitName: json['styleTraitName'] as String?,
      styleTraitValueId: json['styleTraitValueId'] as String?,
      value: json['value'] as String?,
      valueDisplay: json['valueDisplay'] as String?,
    );

Map<String, dynamic> _$StyleValueToJson(StyleValue instance) =>
    <String, dynamic>{
      'styleTraitName': instance.styleTraitName,
      'styleTraitId': instance.styleTraitId,
      'styleTraitValueId': instance.styleTraitValueId,
      'value': instance.value,
      'valueDisplay': instance.valueDisplay,
      'sortOrder': instance.sortOrder,
      'isDefault': instance.isDefault,
      'id': instance.id,
    };
