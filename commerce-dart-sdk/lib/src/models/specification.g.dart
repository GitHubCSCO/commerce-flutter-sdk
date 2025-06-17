// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specification _$SpecificationFromJson(Map<String, dynamic> json) =>
    Specification(
      description: json['description'] as String?,
      htmlContent: json['htmlContent'] as String?,
      isActive: json['isActive'] as bool?,
      name: json['name'] as String?,
      nameDisplay: json['nameDisplay'] as String?,
      parentSpecification: json['parentSpecification'] == null
          ? null
          : Specification.fromJson(
              json['parentSpecification'] as Map<String, dynamic>),
      sortOrder: (json['sortOrder'] as num?)?.toDouble(),
      specificationId: json['specificationId'] as String?,
      specifications: json['specifications'] == null
          ? null
          : Specification.fromJson(
              json['specifications'] as Map<String, dynamic>),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$SpecificationToJson(Specification instance) =>
    <String, dynamic>{
      if (instance.specificationId case final value?) 'specificationId': value,
      if (instance.name case final value?) 'name': value,
      if (instance.nameDisplay case final value?) 'nameDisplay': value,
      if (instance.value case final value?) 'value': value,
      if (instance.description case final value?) 'description': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.parentSpecification?.toJson() case final value?)
        'parentSpecification': value,
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.specifications?.toJson() case final value?)
        'specifications': value,
    };
