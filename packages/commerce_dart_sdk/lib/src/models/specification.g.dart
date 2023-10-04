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

Map<String, dynamic> _$SpecificationToJson(Specification instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('specificationId', instance.specificationId);
  writeNotNull('name', instance.name);
  writeNotNull('nameDisplay', instance.nameDisplay);
  writeNotNull('value', instance.value);
  writeNotNull('description', instance.description);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('parentSpecification', instance.parentSpecification?.toJson());
  writeNotNull('htmlContent', instance.htmlContent);
  writeNotNull('specifications', instance.specifications?.toJson());
  return val;
}
