// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleTrait _$StyleTraitFromJson(Map<String, dynamic> json) => StyleTrait(
      id: json['id'] as String?,
      name: json['name'] as String?,
      nameDisplay: json['nameDisplay'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      styleTraitId: json['styleTraitId'] as String?,
      styleValues: (json['styleValues'] as List<dynamic>?)
          ?.map((e) => StyleValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      traitValues: (json['traitValues'] as List<dynamic>?)
          ?.map((e) => StyleValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      unselectedValue: json['unselectedValue'] as String?,
      displayType: json['displayType'] as String?,
      numberOfSwatchesVisible:
          (json['numberOfSwatchesVisible'] as num?)?.toInt(),
      displayTextWithSwatch: json['displayTextWithSwatch'] as bool?,
    );

Map<String, dynamic> _$StyleTraitToJson(StyleTrait instance) =>
    <String, dynamic>{
      if (instance.styleTraitId case final value?) 'styleTraitId': value,
      if (instance.name case final value?) 'name': value,
      if (instance.nameDisplay case final value?) 'nameDisplay': value,
      if (instance.unselectedValue case final value?) 'unselectedValue': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.styleValues?.map((e) => e.toJson()).toList()
          case final value?)
        'styleValues': value,
      if (instance.displayType case final value?) 'displayType': value,
      if (instance.numberOfSwatchesVisible case final value?)
        'numberOfSwatchesVisible': value,
      if (instance.displayTextWithSwatch case final value?)
        'displayTextWithSwatch': value,
      if (instance.id case final value?) 'id': value,
      if (instance.traitValues?.map((e) => e.toJson()).toList()
          case final value?)
        'traitValues': value,
    };
