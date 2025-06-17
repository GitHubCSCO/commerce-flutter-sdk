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
      multipleSaleQty: (json['multipleSaleQty'] as num?)?.toInt(),
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
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      taxCategory: json['taxCategory'] as String?,
      taxCode1: json['taxCode1'] as String?,
      taxCode2: json['taxCode2'] as String?,
      unspsc: json['unspsc'] as String?,
      upcCode: json['upcCode'] as String?,
      vatCodeId: json['vatCodeId'] as String?,
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.modelNumber case final value?) 'modelNumber': value,
      if (instance.sku case final value?) 'sku': value,
      if (instance.upcCode case final value?) 'upcCode': value,
      if (instance.unspsc case final value?) 'unspsc': value,
      if (instance.productCode case final value?) 'productCode': value,
      if (instance.priceCode case final value?) 'priceCode': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.multipleSaleQty case final value?) 'multipleSaleQty': value,
      if (instance.canBackOrder case final value?) 'canBackOrder': value,
      if (instance.roundingRule case final value?) 'roundingRule': value,
      if (instance.replacementProductId case final value?)
        'replacementProductId': value,
      if (instance.isHazardousGood case final value?) 'isHazardousGood': value,
      if (instance.hasMsds case final value?) 'hasMsds': value,
      if (instance.isSpecialOrder case final value?) 'isSpecialOrder': value,
      if (instance.isGiftCard case final value?) 'isGiftCard': value,
      if (instance.allowAnyGiftCardAmount case final value?)
        'allowAnyGiftCardAmount': value,
      if (instance.taxCode1 case final value?) 'taxCode1': value,
      if (instance.taxCode2 case final value?) 'taxCode2': value,
      if (instance.taxCategory case final value?) 'taxCategory': value,
      if (instance.vatCodeId case final value?) 'vatCodeId': value,
      if (instance.shippingClassification case final value?)
        'shippingClassification': value,
      if (instance.shippingLength case final value?) 'shippingLength': value,
      if (instance.shippingWidth case final value?) 'shippingWidth': value,
      if (instance.shippingHeight case final value?) 'shippingHeight': value,
      if (instance.shippingWeight case final value?) 'shippingWeight': value,
      if (instance.configuration?.toJson() case final value?)
        'configuration': value,
    };
