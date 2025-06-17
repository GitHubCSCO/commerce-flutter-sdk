// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleValue _$StyleValueFromJson(Map<String, dynamic> json) => StyleValue(
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      styleTraitId: json['styleTraitId'] as String?,
      styleTraitName: json['styleTraitName'] as String?,
      styleTraitValueId: json['styleTraitValueId'] as String?,
      value: json['value'] as String?,
      valueDisplay: json['valueDisplay'] as String?,
      swatchColorValue: json['swatchColorValue'] as String?,
      swatchImageValue: json['swatchImageValue'] as String?,
      swatchType: json['swatchType'] as String?,
    );

Map<String, dynamic> _$StyleValueToJson(StyleValue instance) =>
    <String, dynamic>{
      if (instance.styleTraitName case final value?) 'styleTraitName': value,
      if (instance.styleTraitId case final value?) 'styleTraitId': value,
      if (instance.styleTraitValueId case final value?)
        'styleTraitValueId': value,
      if (instance.value case final value?) 'value': value,
      if (instance.valueDisplay case final value?) 'valueDisplay': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.isDefault case final value?) 'isDefault': value,
      if (instance.swatchColorValue case final value?)
        'swatchColorValue': value,
      if (instance.swatchImageValue case final value?)
        'swatchImageValue': value,
      if (instance.swatchType case final value?) 'swatchType': value,
      if (instance.id case final value?) 'id': value,
    };
