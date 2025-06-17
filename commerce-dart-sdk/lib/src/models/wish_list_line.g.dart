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

Map<String, dynamic> _$WishListLineToJson(WishListLine instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.productUri case final value?) 'productUri': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.altText case final value?) 'altText': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.manufacturerItem case final value?)
        'manufacturerItem': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.qtyOnHand case final value?) 'qtyOnHand': value,
      if (instance.qtyOrdered case final value?) 'qtyOrdered': value,
      if (instance.erpNumber case final value?) 'erpNumber': value,
      if (instance.pricing?.toJson() case final value?) 'pricing': value,
      if (instance.quoteRequired case final value?) 'quoteRequired': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.canEnterQuantity case final value?)
        'canEnterQuantity': value,
      if (instance.canShowPrice case final value?) 'canShowPrice': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.canShowUnitOfMeasure case final value?)
        'canShowUnitOfMeasure': value,
      if (instance.canBackOrder case final value?) 'canBackOrder': value,
      if (instance.trackInventory case final value?) 'trackInventory': value,
      if (instance.availability?.toJson() case final value?)
        'availability': value,
      if (instance.breakPrices?.map((e) => e.toJson()).toList()
          case final value?)
        'breakPrices': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.unitOfMeasureDisplay case final value?)
        'unitOfMeasureDisplay': value,
      if (instance.unitOfMeasureDescription case final value?)
        'unitOfMeasureDescription': value,
      if (instance.baseUnitOfMeasure case final value?)
        'baseUnitOfMeasure': value,
      if (instance.baseUnitOfMeasureDisplay case final value?)
        'baseUnitOfMeasureDisplay': value,
      if (instance.qtyPerBaseUnitOfMeasure case final value?)
        'qtyPerBaseUnitOfMeasure': value,
      if (instance.selectedUnitOfMeasure case final value?)
        'selectedUnitOfMeasure': value,
      if (instance.productUnitOfMeasures?.map((e) => e.toJson()).toList()
          case final value?)
        'productUnitOfMeasures': value,
      if (instance.packDescription case final value?) 'packDescription': value,
      if (instance.createdOn?.toIso8601String() case final value?)
        'createdOn': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.createdByDisplayName case final value?)
        'createdByDisplayName': value,
      if (instance.isSharedLine case final value?) 'isSharedLine': value,
      if (instance.isVisible case final value?) 'isVisible': value,
      if (instance.isDiscontinued case final value?) 'isDiscontinued': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.brand?.toJson() case final value?) 'brand': value,
      if (instance.isQtyAdjusted case final value?) 'isQtyAdjusted': value,
      if (instance.allowZeroPricing case final value?)
        'allowZeroPricing': value,
    };
