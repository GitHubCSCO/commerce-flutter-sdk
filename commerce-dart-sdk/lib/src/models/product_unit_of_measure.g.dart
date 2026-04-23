// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_unit_of_measure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductUnitOfMeasure _$ProductUnitOfMeasureFromJson(
        Map<String, dynamic> json) =>
    ProductUnitOfMeasure(
      description: json['description'] as String?,
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool?,
      qtyPerBaseUnitOfMeasure:
          (json['qtyPerBaseUnitOfMeasure'] as num?)?.toDouble(),
      roundingRule: json['roundingRule'] as String?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      unitOfMeasureDisplay: json['unitOfMeasureDisplay'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$ProductUnitOfMeasureToJson(
        ProductUnitOfMeasure instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.unitOfMeasureDisplay case final value?)
        'unitOfMeasureDisplay': value,
      if (instance.description case final value?) 'description': value,
      if (instance.qtyPerBaseUnitOfMeasure case final value?)
        'qtyPerBaseUnitOfMeasure': value,
      if (instance.roundingRule case final value?) 'roundingRule': value,
      if (instance.isDefault case final value?) 'isDefault': value,
    };
