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

Map<String, dynamic> _$StyledProductToJson(StyledProduct instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.name case final value?) 'name': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.erpNumber case final value?) 'erpNumber': value,
      if (instance.mediumImagePath case final value?) 'mediumImagePath': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.largeImagePath case final value?) 'largeImagePath': value,
      if (instance.qtyOnHand case final value?) 'qtyOnHand': value,
      if (instance.numberInCart case final value?) 'numberInCart': value,
      if (instance.pricing?.toJson() case final value?) 'pricing': value,
      if (instance.quoteRequired case final value?) 'quoteRequired': value,
      if (instance.styleValues?.map((e) => e.toJson()).toList()
          case final value?)
        'styleValues': value,
      if (instance.availability?.toJson() case final value?)
        'availability': value,
      if (instance.productUnitOfMeasures?.map((e) => e.toJson()).toList()
          case final value?)
        'productUnitOfMeasures': value,
      if (instance.productImages?.map((e) => e.toJson()).toList()
          case final value?)
        'productImages': value,
      if (instance.warehouses?.map((e) => e.toJson()).toList()
          case final value?)
        'warehouses': value,
      if (instance.trackInventory case final value?) 'trackInventory': value,
      if (instance.allowZeroPricing case final value?)
        'allowZeroPricing': value,
    };
