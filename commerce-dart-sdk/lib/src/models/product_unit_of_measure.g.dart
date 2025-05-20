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
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$ProductUnitOfMeasureToJson(
    ProductUnitOfMeasure instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('productUnitOfMeasureId', instance.productUnitOfMeasureId);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('unitOfMeasureDisplay', instance.unitOfMeasureDisplay);
  writeNotNull('description', instance.description);
  writeNotNull('qtyPerBaseUnitOfMeasure', instance.qtyPerBaseUnitOfMeasure);
  writeNotNull('roundingRule', instance.roundingRule);
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull('availability', instance.availability?.toJson());
  return val;
}
