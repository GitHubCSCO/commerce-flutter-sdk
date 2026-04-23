// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specification _$SpecificationFromJson(Map<String, dynamic> json) =>
    Specification(
      description: json['description'] as String?,
      htmlContent: json['htmlContent'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      nameDisplay: json['nameDisplay'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toDouble(),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$SpecificationToJson(Specification instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.nameDisplay case final value?) 'nameDisplay': value,
      if (instance.description case final value?) 'description': value,
      if (instance.value case final value?) 'value': value,
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
    };
