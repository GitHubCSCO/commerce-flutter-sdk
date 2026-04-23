// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleTrait _$StyleTraitFromJson(Map<String, dynamic> json) => StyleTrait(
      id: json['id'] as String?,
      name: json['name'] as String?,
      nameDisplay: json['nameDisplay'] as String?,
      unselectedValue: json['unselectedValue'] as String?,
      displayType: json['displayType'] as String?,
      numberOfSwatchesVisible:
          (json['numberOfSwatchesVisible'] as num?)?.toInt(),
      displayTextWithSwatch: json['displayTextWithSwatch'] as bool?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      traitValues: (json['traitValues'] as List<dynamic>?)
          ?.map((e) => StyleValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StyleTraitToJson(StyleTrait instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.nameDisplay case final value?) 'nameDisplay': value,
      if (instance.unselectedValue case final value?) 'unselectedValue': value,
      if (instance.displayType case final value?) 'displayType': value,
      if (instance.numberOfSwatchesVisible case final value?)
        'numberOfSwatchesVisible': value,
      if (instance.displayTextWithSwatch case final value?)
        'displayTextWithSwatch': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.traitValues?.map((e) => e.toJson()).toList()
          case final value?)
        'traitValues': value,
    };
