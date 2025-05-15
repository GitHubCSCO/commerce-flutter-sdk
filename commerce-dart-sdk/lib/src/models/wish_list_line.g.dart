// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListLine _$WishListLineFromJson(Map<String, dynamic> json) => WishListLine(
      id: json['id'] as String?,
      productUri: json['productUri'] as String?,
      productId: json['productId'] as String?,
      smallImagePath: json['smallImagePath'] as String?,
      altText: json['altText'] as String?,
      productName: json['productName'] as String?,
      manufacturerItem: json['manufacturerItem'] as String?,
      customerName: json['customerName'] as String?,
      shortDescription: json['shortDescription'] as String?,
      qtyOnHand: json['qtyOnHand'] as num?,
      qtyOrdered: json['qtyOrdered'] as num?,
      erpNumber: json['erpNumber'] as String?,
      pricing: json['pricing'] == null
          ? null
          : ProductPrice.fromJson(json['pricing'] as Map<String, dynamic>),
      quoteRequired: json['quoteRequired'] as bool?,
      isActive: json['isActive'] as bool?,
      canEnterQuantity: json['canEnterQuantity'] as bool?,
      canShowPrice: json['canShowPrice'] as bool?,
      canAddToCart: json['canAddToCart'] as bool?,
      canShowUnitOfMeasure: json['canShowUnitOfMeasure'] as bool?,
      canBackOrder: json['canBackOrder'] as bool?,
      trackInventory: json['trackInventory'] as bool?,
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
      breakPrices: (json['breakPrices'] as List<dynamic>?)
          ?.map((e) => BreakPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitOfMeasure: json['unitOfMeasure'] as String?,
      unitOfMeasureDisplay: json['unitOfMeasureDisplay'] as String?,
      unitOfMeasureDescription: json['unitOfMeasureDescription'] as String?,
      baseUnitOfMeasure: json['baseUnitOfMeasure'] as String?,
      baseUnitOfMeasureDisplay: json['baseUnitOfMeasureDisplay'] as String?,
      qtyPerBaseUnitOfMeasure: json['qtyPerBaseUnitOfMeasure'] as num?,
      selectedUnitOfMeasure: json['selectedUnitOfMeasure'] as String?,
      productUnitOfMeasures: (json['productUnitOfMeasures'] as List<dynamic>?)
          ?.map((e) => ProductUnitOfMeasure.fromJson(e as Map<String, dynamic>))
          .toList(),
      packDescription: json['packDescription'] as String?,
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      notes: json['notes'] as String?,
      createdByDisplayName: json['createdByDisplayName'] as String?,
      isSharedLine: json['isSharedLine'] as bool?,
      isVisible: json['isVisible'] as bool?,
      isDiscontinued: json['isDiscontinued'] as bool?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      isQtyAdjusted: json['isQtyAdjusted'] as bool?,
      allowZeroPricing: json['allowZeroPricing'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WishListLineToJson(WishListLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('productUri', instance.productUri);
  writeNotNull('productId', instance.productId);
  writeNotNull('smallImagePath', instance.smallImagePath);
  writeNotNull('altText', instance.altText);
  writeNotNull('productName', instance.productName);
  writeNotNull('manufacturerItem', instance.manufacturerItem);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('qtyOnHand', instance.qtyOnHand);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  writeNotNull('erpNumber', instance.erpNumber);
  writeNotNull('pricing', instance.pricing?.toJson());
  writeNotNull('quoteRequired', instance.quoteRequired);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('canEnterQuantity', instance.canEnterQuantity);
  writeNotNull('canShowPrice', instance.canShowPrice);
  writeNotNull('canAddToCart', instance.canAddToCart);
  writeNotNull('canShowUnitOfMeasure', instance.canShowUnitOfMeasure);
  writeNotNull('canBackOrder', instance.canBackOrder);
  writeNotNull('trackInventory', instance.trackInventory);
  writeNotNull('availability', instance.availability?.toJson());
  writeNotNull(
      'breakPrices', instance.breakPrices?.map((e) => e.toJson()).toList());
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('unitOfMeasureDisplay', instance.unitOfMeasureDisplay);
  writeNotNull('unitOfMeasureDescription', instance.unitOfMeasureDescription);
  writeNotNull('baseUnitOfMeasure', instance.baseUnitOfMeasure);
  writeNotNull('baseUnitOfMeasureDisplay', instance.baseUnitOfMeasureDisplay);
  writeNotNull('qtyPerBaseUnitOfMeasure', instance.qtyPerBaseUnitOfMeasure);
  writeNotNull('selectedUnitOfMeasure', instance.selectedUnitOfMeasure);
  writeNotNull('productUnitOfMeasures',
      instance.productUnitOfMeasures?.map((e) => e.toJson()).toList());
  writeNotNull('packDescription', instance.packDescription);
  writeNotNull('createdOn', instance.createdOn?.toIso8601String());
  writeNotNull('notes', instance.notes);
  writeNotNull('createdByDisplayName', instance.createdByDisplayName);
  writeNotNull('isSharedLine', instance.isSharedLine);
  writeNotNull('isVisible', instance.isVisible);
  writeNotNull('isDiscontinued', instance.isDiscontinued);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('brand', instance.brand?.toJson());
  writeNotNull('isQtyAdjusted', instance.isQtyAdjusted);
  writeNotNull('allowZeroPricing', instance.allowZeroPricing);
  return val;
}
