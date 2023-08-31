// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    ProductDetail(
      allowAnyGiftCardAmount: json['allowAnyGiftCardAmount'] as bool?,
      canBackOrder: json['canBackOrder'] as bool?,
      configuration: json['configuration'] == null
          ? null
          : LegacyConfiguration.fromJson(
              json['configuration'] as Map<String, dynamic>),
      hasMsds: json['hasMsds'] as bool?,
      isGiftCard: json['isGiftCard'] as bool?,
      isHazardousGood: json['isHazardousGood'] as bool?,
      isSpecialOrder: json['isSpecialOrder'] as bool?,
      modelNumber: json['modelNumber'] as String?,
      multipleSaleQty: json['multipleSaleQty'] as int?,
      name: json['name'] as String?,
      priceCode: json['priceCode'] as String?,
      productCode: json['productCode'] as String?,
      replacementProductId: json['replacementProductId'] as String?,
      roundingRule: json['roundingRule'] as String?,
      shippingClassification: json['shippingClassification'] as String?,
      shippingHeight: json['shippingHeight'] as num?,
      shippingLength: json['shippingLength'] as num?,
      shippingWeight: json['shippingWeight'] as num?,
      shippingWidth: json['shippingWidth'] as num?,
      sku: json['sku'] as String?,
      sortOrder: json['sortOrder'] as int?,
      taxCategory: json['taxCategory'] as String?,
      taxCode1: json['taxCode1'] as String?,
      taxCode2: json['taxCode2'] as String?,
      unspsc: json['unspsc'] as String?,
      upcCode: json['upcCode'] as String?,
      vatCodeId: json['vatCodeId'] as String?,
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'modelNumber': instance.modelNumber,
      'sku': instance.sku,
      'upcCode': instance.upcCode,
      'unspsc': instance.unspsc,
      'productCode': instance.productCode,
      'priceCode': instance.priceCode,
      'sortOrder': instance.sortOrder,
      'multipleSaleQty': instance.multipleSaleQty,
      'canBackOrder': instance.canBackOrder,
      'roundingRule': instance.roundingRule,
      'replacementProductId': instance.replacementProductId,
      'isHazardousGood': instance.isHazardousGood,
      'hasMsds': instance.hasMsds,
      'isSpecialOrder': instance.isSpecialOrder,
      'isGiftCard': instance.isGiftCard,
      'allowAnyGiftCardAmount': instance.allowAnyGiftCardAmount,
      'taxCode1': instance.taxCode1,
      'taxCode2': instance.taxCode2,
      'taxCategory': instance.taxCategory,
      'vatCodeId': instance.vatCodeId,
      'shippingClassification': instance.shippingClassification,
      'shippingLength': instance.shippingLength,
      'shippingWidth': instance.shippingWidth,
      'shippingHeight': instance.shippingHeight,
      'shippingWeight': instance.shippingWeight,
      'configuration': instance.configuration?.toJson(),
    };
