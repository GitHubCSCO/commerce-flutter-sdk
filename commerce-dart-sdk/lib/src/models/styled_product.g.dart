// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'styled_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyledProduct _$StyledProductFromJson(Map<String, dynamic> json) =>
    StyledProduct(
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
      erpNumber: json['erpNumber'] as String?,
      largeImagePath: json['largeImagePath'] as String?,
      mediumImagePath: json['mediumImagePath'] as String?,
      name: json['name'] as String?,
      numberInCart: json['numberInCart'] as num?,
      pricing: json['pricing'] == null
          ? null
          : ProductPrice.fromJson(json['pricing'] as Map<String, dynamic>),
      productId: json['productId'] as String?,
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      productUnitOfMeasures: (json['productUnitOfMeasures'] as List<dynamic>?)
          ?.map((e) => ProductUnitOfMeasure.fromJson(e as Map<String, dynamic>))
          .toList(),
      qtyOnHand: json['qtyOnHand'] as num?,
      quoteRequired: json['quoteRequired'] as bool?,
      shortDescription: json['shortDescription'] as String?,
      smallImagePath: json['smallImagePath'] as String?,
      styleValues: (json['styleValues'] as List<dynamic>?)
          ?.map((e) => StyleValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      trackInventory: json['trackInventory'] as bool?,
      warehouses: (json['warehouses'] as List<dynamic>?)
          ?.map((e) => Warehouse.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowZeroPricing: json['allowZeroPricing'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$StyledProductToJson(StyledProduct instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('productId', instance.productId);
  writeNotNull('name', instance.name);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('erpNumber', instance.erpNumber);
  writeNotNull('mediumImagePath', instance.mediumImagePath);
  writeNotNull('smallImagePath', instance.smallImagePath);
  writeNotNull('largeImagePath', instance.largeImagePath);
  writeNotNull('qtyOnHand', instance.qtyOnHand);
  writeNotNull('numberInCart', instance.numberInCart);
  writeNotNull('pricing', instance.pricing?.toJson());
  writeNotNull('quoteRequired', instance.quoteRequired);
  writeNotNull(
      'styleValues', instance.styleValues?.map((e) => e.toJson()).toList());
  writeNotNull('availability', instance.availability?.toJson());
  writeNotNull('productUnitOfMeasures',
      instance.productUnitOfMeasures?.map((e) => e.toJson()).toList());
  writeNotNull(
      'productImages', instance.productImages?.map((e) => e.toJson()).toList());
  writeNotNull(
      'warehouses', instance.warehouses?.map((e) => e.toJson()).toList());
  writeNotNull('trackInventory', instance.trackInventory);
  writeNotNull('allowZeroPricing', instance.allowZeroPricing);
  return val;
}
