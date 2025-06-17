// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_trait_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildTraitValue _$ChildTraitValueFromJson(Map<String, dynamic> json) =>
    ChildTraitValue(
      id: json['id'] as String?,
      styleTraitId: json['styleTraitId'] as String?,
      value: json['value'] as String?,
      valueDisplay: json['valueDisplay'] as String?,
    );

Map<String, dynamic> _$ChildTraitValueToJson(ChildTraitValue instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.styleTraitId case final value?) 'styleTraitId': value,
      if (instance.value case final value?) 'value': value,
      if (instance.valueDisplay case final value?) 'valueDisplay': value,
    };
