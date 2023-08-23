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
      'specificationId': instance.specificationId,
      'name': instance.name,
      'nameDisplay': instance.nameDisplay,
      'value': instance.value,
      'description': instance.description,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'parentSpecification': instance.parentSpecification?.toJson(),
      'htmlContent': instance.htmlContent,
      'specifications': instance.specifications?.toJson(),
    };
