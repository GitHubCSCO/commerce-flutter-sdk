// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleTrait _$StyleTraitFromJson(Map<String, dynamic> json) => StyleTrait(
      id: json['id'] as String?,
      name: json['name'] as String?,
      nameDisplay: json['nameDisplay'] as String?,
      sortOrder: json['sortOrder'] as int?,
      styleTraitId: json['styleTraitId'] as String?,
      styleValues: (json['styleValues'] as List<dynamic>?)
          ?.map((e) => StyleValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      traitValues: (json['traitValues'] as List<dynamic>?)
          ?.map((e) => StyleValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      unselectedValue: json['unselectedValue'] as String?,
    );

Map<String, dynamic> _$StyleTraitToJson(StyleTrait instance) =>
    <String, dynamic>{
      'styleTraitId': instance.styleTraitId,
      'name': instance.name,
      'nameDisplay': instance.nameDisplay,
      'unselectedValue': instance.unselectedValue,
      'sortOrder': instance.sortOrder,
      'styleValues': instance.styleValues?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'traitValues': instance.traitValues?.map((e) => e.toJson()).toList(),
    };
