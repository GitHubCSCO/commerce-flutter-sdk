// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      productNumber: json['productNumber'] as String?,
      customerProductNumber: json['customerProductNumber'] as String?,
      customerUnitOfMeasure: json['customerUnitOfMeasure'] as String?,
      productTitle: json['productTitle'] as String?,
      urlSegment: json['urlSegment'] as String?,
      canonicalUrl: json['canonicalUrl'] as String?,
      displayUrl: json['displayUrl'] as String?,
      manufacturerItem: json['manufacturerItem'] as String?,
      packDescription: json['packDescription'] as String?,
      unitListPrice: json['unitListPrice'] as num?,
      unitListPriceDisplay: json['unitListPriceDisplay'] as String?,
      priceFacet: (json['priceFacet'] as num?)?.toInt(),
      smallImagePath: json['smallImagePath'] as String?,
      mediumImagePath: json['mediumImagePath'] as String?,
      largeImagePath: json['largeImagePath'] as String?,
      imageAltText: json['imageAltText'] as String?,
      isDiscontinued: json['isDiscontinued'] as bool?,
      quoteRequired: json['quoteRequired'] as bool?,
      minimumOrderQty: (json['minimumOrderQty'] as num?)?.toInt(),
      isSponsored: json['isSponsored'] as bool?,
      trackInventory: json['trackInventory'] as bool?,
      configurationType: json['configurationType'] as String?,
      canConfigure: json['canConfigure'] as bool?,
      canAddToCart: json['canAddToCart'] as bool?,
      canAddToWishlist: json['canAddToWishlist'] as bool?,
      canShowPrice: json['canShowPrice'] as bool?,
      canShowUnitOfMeasure: json['canShowUnitOfMeasure'] as bool?,
      isVariantParent: json['isVariantParent'] as bool?,
      variantTypeId: json['variantTypeId'] as String?,
      defaultChildProductId: json['defaultChildProductId'] as String?,
      salePriceLabel: json['salePriceLabel'] as String?,
      cantBuy: json['cantBuy'] as bool?,
      allowZeroPricing: json['allowZeroPricing'] as bool?,
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      productLine: json['productLine'] == null
          ? null
          : ProductLine.fromJson(json['productLine'] as Map<String, dynamic>),
      unitOfMeasures: (json['unitOfMeasures'] as List<dynamic>?)
          ?.map((e) => ProductUnitOfMeasure.fromJson(e as Map<String, dynamic>))
          .toList(),
      score: (json['score'] as num?)?.toDouble(),
      scoreExplanation: json['scoreExplanation'] == null
          ? null
          : ScoreExplanation.fromJson(
              json['scoreExplanation'] as Map<String, dynamic>),
      detail: json['detail'] == null
          ? null
          : ProductDetail.fromJson(json['detail'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : ProductContent.fromJson(json['content'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      badges: (json['badges'] as List<dynamic>?)
          ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
      specifications: (json['specifications'] as List<dynamic>?)
          ?.map((e) => Specification.fromJson(e as Map<String, dynamic>))
          .toList(),
      warehouses: (json['warehouses'] as List<dynamic>?)
          ?.map((e) => InventoryWarehouse.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributeTypes: (json['attributeTypes'] as List<dynamic>?)
          ?.map((e) => AttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      variantTraits: (json['variantTraits'] as List<dynamic>?)
          ?.map((e) => StyleTrait.fromJson(e as Map<String, dynamic>))
          .toList(),
      childTraitValues: (json['childTraitValues'] as List<dynamic>?)
          ?.map((e) => ChildTraitValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.productNumber case final value?) 'productNumber': value,
      if (instance.customerProductNumber case final value?)
        'customerProductNumber': value,
      if (instance.customerUnitOfMeasure case final value?)
        'customerUnitOfMeasure': value,
      if (instance.productTitle case final value?) 'productTitle': value,
      if (instance.urlSegment case final value?) 'urlSegment': value,
      if (instance.canonicalUrl case final value?) 'canonicalUrl': value,
      if (instance.displayUrl case final value?) 'displayUrl': value,
      if (instance.manufacturerItem case final value?)
        'manufacturerItem': value,
      if (instance.packDescription case final value?) 'packDescription': value,
      if (instance.unitListPrice case final value?) 'unitListPrice': value,
      if (instance.unitListPriceDisplay case final value?)
        'unitListPriceDisplay': value,
      if (instance.priceFacet case final value?) 'priceFacet': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.mediumImagePath case final value?) 'mediumImagePath': value,
      if (instance.largeImagePath case final value?) 'largeImagePath': value,
      if (instance.imageAltText case final value?) 'imageAltText': value,
      if (instance.isDiscontinued case final value?) 'isDiscontinued': value,
      if (instance.quoteRequired case final value?) 'quoteRequired': value,
      if (instance.minimumOrderQty case final value?) 'minimumOrderQty': value,
      if (instance.isSponsored case final value?) 'isSponsored': value,
      if (instance.trackInventory case final value?) 'trackInventory': value,
      if (instance.configurationType case final value?)
        'configurationType': value,
      if (instance.canConfigure case final value?) 'canConfigure': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.canAddToWishlist case final value?)
        'canAddToWishlist': value,
      if (instance.canShowPrice case final value?) 'canShowPrice': value,
      if (instance.canShowUnitOfMeasure case final value?)
        'canShowUnitOfMeasure': value,
      if (instance.isVariantParent case final value?) 'isVariantParent': value,
      if (instance.variantTypeId case final value?) 'variantTypeId': value,
      if (instance.defaultChildProductId case final value?)
        'defaultChildProductId': value,
      if (instance.salePriceLabel case final value?) 'salePriceLabel': value,
      if (instance.cantBuy case final value?) 'cantBuy': value,
      if (instance.allowZeroPricing case final value?)
        'allowZeroPricing': value,
      if (instance.brand?.toJson() case final value?) 'brand': value,
      if (instance.productLine?.toJson() case final value?)
        'productLine': value,
      if (instance.unitOfMeasures?.map((e) => e.toJson()).toList()
          case final value?)
        'unitOfMeasures': value,
      if (instance.score case final value?) 'score': value,
      if (instance.scoreExplanation?.toJson() case final value?)
        'scoreExplanation': value,
      if (instance.detail?.toJson() case final value?) 'detail': value,
      if (instance.content?.toJson() case final value?) 'content': value,
      if (instance.images?.map((e) => e.toJson()).toList() case final value?)
        'images': value,
      if (instance.badges?.map((e) => e.toJson()).toList() case final value?)
        'badges': value,
      if (instance.documents?.map((e) => e.toJson()).toList() case final value?)
        'documents': value,
      if (instance.specifications?.map((e) => e.toJson()).toList()
          case final value?)
        'specifications': value,
      if (instance.warehouses?.map((e) => e.toJson()).toList()
          case final value?)
        'warehouses': value,
      if (instance.attributeTypes?.map((e) => e.toJson()).toList()
          case final value?)
        'attributeTypes': value,
      if (instance.variantTraits?.map((e) => e.toJson()).toList()
          case final value?)
        'variantTraits': value,
      if (instance.childTraitValues?.map((e) => e.toJson()).toList()
          case final value?)
        'childTraitValues': value,
    };
