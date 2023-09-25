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

Map<String, dynamic> _$ChildTraitValueToJson(ChildTraitValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('styleTraitId', instance.styleTraitId);
  writeNotNull('value', instance.value);
  writeNotNull('valueDisplay', instance.valueDisplay);
  return val;
}
