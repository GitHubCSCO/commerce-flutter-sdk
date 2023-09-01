// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$StyledProductToJson(StyledProduct instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'productId': instance.productId,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'erpNumber': instance.erpNumber,
      'mediumImagePath': instance.mediumImagePath,
      'smallImagePath': instance.smallImagePath,
      'largeImagePath': instance.largeImagePath,
      'qtyOnHand': instance.qtyOnHand,
      'numberInCart': instance.numberInCart,
      'pricing': instance.pricing?.toJson(),
      'quoteRequired': instance.quoteRequired,
      'styleValues': instance.styleValues?.map((e) => e.toJson()).toList(),
      'availability': instance.availability?.toJson(),
      'productUnitOfMeasures':
          instance.productUnitOfMeasures?.map((e) => e.toJson()).toList(),
      'productImages': instance.productImages?.map((e) => e.toJson()).toList(),
      'warehouses': instance.warehouses?.map((e) => e.toJson()).toList(),
      'trackInventory': instance.trackInventory,
    };
