// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_unit_of_measure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductUnitOfMeasure _$ProductUnitOfMeasureFromJson(
        Map<String, dynamic> json) =>
    ProductUnitOfMeasure(
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
      description: json['description'] as String?,
      isDefault: json['isDefault'] as bool?,
      productUnitOfMeasureId: json['productUnitOfMeasureId'] as String?,
      qtyPerBaseUnitOfMeasure:
          (json['qtyPerBaseUnitOfMeasure'] as num?)?.toDouble(),
      roundingRule: json['roundingRule'] as String?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      unitOfMeasureDisplay: json['unitOfMeasureDisplay'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$ProductUnitOfMeasureToJson(
        ProductUnitOfMeasure instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'productUnitOfMeasureId': instance.productUnitOfMeasureId,
      'unitOfMeasure': instance.unitOfMeasure,
      'unitOfMeasureDisplay': instance.unitOfMeasureDisplay,
      'description': instance.description,
      'qtyPerBaseUnitOfMeasure': instance.qtyPerBaseUnitOfMeasure,
      'roundingRule': instance.roundingRule,
      'isDefault': instance.isDefault,
      'availability': instance.availability?.toJson(),
    };
