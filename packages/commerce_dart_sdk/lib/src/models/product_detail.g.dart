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

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('modelNumber', instance.modelNumber);
  writeNotNull('sku', instance.sku);
  writeNotNull('upcCode', instance.upcCode);
  writeNotNull('unspsc', instance.unspsc);
  writeNotNull('productCode', instance.productCode);
  writeNotNull('priceCode', instance.priceCode);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('multipleSaleQty', instance.multipleSaleQty);
  writeNotNull('canBackOrder', instance.canBackOrder);
  writeNotNull('roundingRule', instance.roundingRule);
  writeNotNull('replacementProductId', instance.replacementProductId);
  writeNotNull('isHazardousGood', instance.isHazardousGood);
  writeNotNull('hasMsds', instance.hasMsds);
  writeNotNull('isSpecialOrder', instance.isSpecialOrder);
  writeNotNull('isGiftCard', instance.isGiftCard);
  writeNotNull('allowAnyGiftCardAmount', instance.allowAnyGiftCardAmount);
  writeNotNull('taxCode1', instance.taxCode1);
  writeNotNull('taxCode2', instance.taxCode2);
  writeNotNull('taxCategory', instance.taxCategory);
  writeNotNull('vatCodeId', instance.vatCodeId);
  writeNotNull('shippingClassification', instance.shippingClassification);
  writeNotNull('shippingLength', instance.shippingLength);
  writeNotNull('shippingWidth', instance.shippingWidth);
  writeNotNull('shippingHeight', instance.shippingHeight);
  writeNotNull('shippingWeight', instance.shippingWeight);
  writeNotNull('configuration', instance.configuration?.toJson());
  return val;
}
