// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      accessories: (json['accessories'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowAnyGiftCardAmount: json['allowAnyGiftCardAmount'] as bool?,
      allowedAddToCart: json['allowedAddToCart'] as bool?,
      altText: json['altText'] as String?,
      attributeTypes: (json['attributeTypes'] as List<dynamic>?)
          ?.map((e) => AttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
      basicListPrice: json['basicListPrice'] as num?,
      basicSaleEndDate: json['basicSaleEndDate'] == null
          ? null
          : DateTime.parse(json['basicSaleEndDate'] as String),
      basicSalePrice: json['basicSalePrice'] as num?,
      basicSaleStartDate: json['basicSaleStartDate'] == null
          ? null
          : DateTime.parse(json['basicSaleStartDate'] as String),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      canAddToCart: json['canAddToCart'] as bool?,
      canAddToWishlist: json['canAddToWishlist'] as bool?,
      canBackOrder: json['canBackOrder'] as bool?,
      canConfigure: json['canConfigure'] as bool?,
      canEnterQuantity: json['canEnterQuantity'] as bool?,
      canShowPrice: json['canShowPrice'] as bool?,
      canShowUnitOfMeasure: json['canShowUnitOfMeasure'] as bool?,
      canViewDetails: json['canViewDetails'] as bool?,
      canonicalUrl: json['canonicalUrl'] as String?,
      cantBuy: json['cantBuy'] as bool?,
      childTraitValues: (json['childTraitValues'] as List<dynamic>?)
          ?.map((e) => ChildTraitValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      configurationDto: json['configurationDto'] == null
          ? null
          : LegacyConfiguration.fromJson(
              json['configurationDto'] as Map<String, dynamic>),
      configurationType: json['configurationType'] as String?,
      content: json['content'] == null
          ? null
          : ProductContent.fromJson(json['content'] as Map<String, dynamic>),
      crossSells: (json['crossSells'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      currencySymbol: json['currencySymbol'] as String?,
      customerName: json['customerName'] as String?,
      customerProductNumber: json['customerProductNumber'] as String?,
      customerUnitOfMeasure: json['customerUnitOfMeasure'] as String?,
      detail: json['detail'] == null
          ? null
          : ProductDetail.fromJson(json['detail'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
      erpDescription: json['erpDescription'] as String?,
      erpNumber: json['erpNumber'] as String?,
      handlingAmountOverride: json['handlingAmountOverride'] as num?,
      hasMsds: json['hasMsds'] as bool?,
      htmlContent: json['htmlContent'] as String?,
      id: json['id'] as String?,
      imageAltText: json['imageAltText'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool?,
      isBeingCompared: json['isBeingCompared'] as bool?,
      isConfigured: json['isConfigured'] as bool?,
      isDiscontinued: json['isDiscontinued'] as bool?,
      isFixedConfiguration: json['isFixedConfiguration'] as bool?,
      isGiftCard: json['isGiftCard'] as bool?,
      isHazardousGood: json['isHazardousGood'] as bool?,
      isSpecialOrder: json['isSpecialOrder'] as bool?,
      isSponsored: json['isSponsored'] as bool?,
      isStyleProductParent: json['isStyleProductParent'] as bool?,
      isSubscription: json['isSubscription'] as bool?,
      isVariantParent: json['isVariantParent'] as bool?,
      largeImagePath: json['largeImagePath'] as String?,
      manufacturerItem: json['manufacturerItem'] as String?,
      mediumImagePath: json['mediumImagePath'] as String?,
      metaDescription: json['metaDescription'] as String?,
      metaKeywords: json['metaKeywords'] as String?,
      minimumOrderQty: json['minimumOrderQty'] as int?,
      modelNumber: json['modelNumber'] as String?,
      multipleSaleQty: json['multipleSaleQty'] as int?,
      name: json['name'] as String?,
      orderLineId: json['orderLineId'] as String?,
      packDescription: json['packDescription'] as String?,
      pageTitle: json['pageTitle'] as String?,
      priceCode: json['priceCode'] as String?,
      priceFacet: json['priceFacet'] as int?,
      pricing: json['pricing'] == null
          ? null
          : ProductPrice.fromJson(json['pricing'] as Map<String, dynamic>),
      productCode: json['productCode'] as String?,
      productDetailUrl: json['productDetailUrl'] as String?,
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      productLine: json['productLine'] == null
          ? null
          : ProductLine.fromJson(json['productLine'] as Map<String, dynamic>),
      productNumber: json['productNumber'] as String?,
      productSubscription: json['productSubscription'] == null
          ? null
          : ProductSubscriptionDto.fromJson(
              json['productSubscription'] as Map<String, dynamic>),
      productTitle: json['productTitle'] as String?,
      productUnitOfMeasures: (json['productUnitOfMeasures'] as List<dynamic>?)
          ?.map((e) => ProductUnitOfMeasure.fromJson(e as Map<String, dynamic>))
          .toList(),
      qtyOnHand: json['qtyOnHand'] as num?,
      qtyPerShippingPackage: json['qtyPerShippingPackage'] as num?,
      quoteRequired: json['quoteRequired'] as bool?,
      replacementProductId: json['replacementProductId'] as String?,
      requiresRealTimeInventory: json['requiresRealTimeInventory'] as bool?,
      roundingRule: json['roundingRule'] as String?,
      salePriceLabel: json['salePriceLabel'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      scoreExplanation: json['scoreExplanation'] == null
          ? null
          : ScoreExplanation.fromJson(
              json['scoreExplanation'] as Map<String, dynamic>),
      searchBoost: json['searchBoost'] as int?,
      selectedUnitOfMeasure: json['selectedUnitOfMeasure'] as String?,
      selectedUnitOfMeasureDisplay:
          json['selectedUnitOfMeasureDisplay'] as String?,
      shippingAmountOverride: json['shippingAmountOverride'] as num?,
      shippingClassification: json['shippingClassification'] as String?,
      shippingHeight: json['shippingHeight'] as String?,
      shippingLength: json['shippingLength'] as String?,
      shippingWeight: json['shippingWeight'] as String?,
      shippingWidth: json['shippingWidth'] as String?,
      shortDescription: json['shortDescription'] as String?,
      sku: json['sku'] as String?,
      smallImagePath: json['smallImagePath'] as String?,
      sortOrder: json['sortOrder'] as int?,
      specifications: (json['specifications'] as List<dynamic>?)
          ?.map((e) => Specification.fromJson(e as Map<String, dynamic>))
          .toList(),
      styleParentId: json['styleParentId'] as String?,
      styleTraits: (json['styleTraits'] as List<dynamic>?)
          ?.map((e) => StyleTrait.fromJson(e as Map<String, dynamic>))
          .toList(),
      styledProducts: (json['styledProducts'] as List<dynamic>?)
          ?.map((e) => StyledProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      taxCategory: json['taxCategory'] as String?,
      taxCode1: json['taxCode1'] as String?,
      taxCode2: json['taxCode2'] as String?,
      trackInventory: json['trackInventory'] as bool?,
      unitListPrice: json['unitListPrice'] as num?,
      unitListPriceDisplay: json['unitListPriceDisplay'] as String?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      unitOfMeasureDescription: json['unitOfMeasureDescription'] as String?,
      unitOfMeasureDisplay: json['unitOfMeasureDisplay'] as String?,
      unitOfMeasures: (json['unitOfMeasures'] as List<dynamic>?)
          ?.map((e) => ProductUnitOfMeasure.fromJson(e as Map<String, dynamic>))
          .toList(),
      unspsc: json['unspsc'] as String?,
      upcCode: json['upcCode'] as String?,
      urlSegment: json['urlSegment'] as String?,
      variantTraits: (json['variantTraits'] as List<dynamic>?)
          ?.map((e) => StyleTrait.fromJson(e as Map<String, dynamic>))
          .toList(),
      variantTypeId: json['variantTypeId'] as String?,
      vendorNumber: json['vendorNumber'] as String?,
      warehouses: (json['warehouses'] as List<dynamic>?)
          ?.map((e) => InventoryWarehouse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'id': instance.id,
      'orderLineId': instance.orderLineId,
      'name': instance.name,
      'customerName': instance.customerName,
      'shortDescription': instance.shortDescription,
      'erpNumber': instance.erpNumber,
      'erpDescription': instance.erpDescription,
      'urlSegment': instance.urlSegment,
      'basicListPrice': instance.basicListPrice,
      'basicSalePrice': instance.basicSalePrice,
      'basicSaleStartDate': instance.basicSaleStartDate?.toIso8601String(),
      'basicSaleEndDate': instance.basicSaleEndDate?.toIso8601String(),
      'smallImagePath': instance.smallImagePath,
      'mediumImagePath': instance.mediumImagePath,
      'largeImagePath': instance.largeImagePath,
      'pricing': instance.pricing?.toJson(),
      'currencySymbol': instance.currencySymbol,
      'qtyOnHand': instance.qtyOnHand,
      'isConfigured': instance.isConfigured,
      'isFixedConfiguration': instance.isFixedConfiguration,
      'isActive': instance.isActive,
      'isHazardousGood': instance.isHazardousGood,
      'isDiscontinued': instance.isDiscontinued,
      'isSpecialOrder': instance.isSpecialOrder,
      'isGiftCard': instance.isGiftCard,
      'isBeingCompared': instance.isBeingCompared,
      'isSponsored': instance.isSponsored,
      'isSubscription': instance.isSubscription,
      'quoteRequired': instance.quoteRequired,
      'manufacturerItem': instance.manufacturerItem,
      'packDescription': instance.packDescription,
      'altText': instance.altText,
      'customerUnitOfMeasure': instance.customerUnitOfMeasure,
      'canBackOrder': instance.canBackOrder,
      'trackInventory': instance.trackInventory,
      'multipleSaleQty': instance.multipleSaleQty,
      'minimumOrderQty': instance.minimumOrderQty,
      'htmlContent': instance.htmlContent,
      'productCode': instance.productCode,
      'priceCode': instance.priceCode,
      'sku': instance.sku,
      'upcCode': instance.upcCode,
      'modelNumber': instance.modelNumber,
      'taxCode1': instance.taxCode1,
      'taxCode2': instance.taxCode2,
      'taxCategory': instance.taxCategory,
      'shippingClassification': instance.shippingClassification,
      'shippingLength': instance.shippingLength,
      'shippingWidth': instance.shippingWidth,
      'shippingHeight': instance.shippingHeight,
      'shippingWeight': instance.shippingWeight,
      'qtyPerShippingPackage': instance.qtyPerShippingPackage,
      'shippingAmountOverride': instance.shippingAmountOverride,
      'handlingAmountOverride': instance.handlingAmountOverride,
      'metaDescription': instance.metaDescription,
      'metaKeywords': instance.metaKeywords,
      'pageTitle': instance.pageTitle,
      'allowAnyGiftCardAmount': instance.allowAnyGiftCardAmount,
      'sortOrder': instance.sortOrder,
      'hasMsds': instance.hasMsds,
      'unspsc': instance.unspsc,
      'roundingRule': instance.roundingRule,
      'vendorNumber': instance.vendorNumber,
      'configurationDto': instance.configurationDto?.toJson(),
      'unitOfMeasure': instance.unitOfMeasure,
      'unitOfMeasureDisplay': instance.unitOfMeasureDisplay,
      'unitOfMeasureDescription': instance.unitOfMeasureDescription,
      'selectedUnitOfMeasure': instance.selectedUnitOfMeasure,
      'selectedUnitOfMeasureDisplay': instance.selectedUnitOfMeasureDisplay,
      'productDetailUrl': instance.productDetailUrl,
      'canAddToCart': instance.canAddToCart,
      'allowedAddToCart': instance.allowedAddToCart,
      'canAddToWishlist': instance.canAddToWishlist,
      'canViewDetails': instance.canViewDetails,
      'canShowPrice': instance.canShowPrice,
      'canShowUnitOfMeasure': instance.canShowUnitOfMeasure,
      'canEnterQuantity': instance.canEnterQuantity,
      'canConfigure': instance.canConfigure,
      'isStyleProductParent': instance.isStyleProductParent,
      'styleParentId': instance.styleParentId,
      'requiresRealTimeInventory': instance.requiresRealTimeInventory,
      'availability': instance.availability?.toJson(),
      'styleTraits': instance.styleTraits?.map((e) => e.toJson()).toList(),
      'styledProducts':
          instance.styledProducts?.map((e) => e.toJson()).toList(),
      'attributeTypes':
          instance.attributeTypes?.map((e) => e.toJson()).toList(),
      'documents': instance.documents?.map((e) => e.toJson()).toList(),
      'specifications':
          instance.specifications?.map((e) => e.toJson()).toList(),
      'crossSells': instance.crossSells?.map((e) => e.toJson()).toList(),
      'accessories': instance.accessories?.map((e) => e.toJson()).toList(),
      'productUnitOfMeasures':
          instance.productUnitOfMeasures?.map((e) => e.toJson()).toList(),
      'productImages': instance.productImages?.map((e) => e.toJson()).toList(),
      'score': instance.score,
      'searchBoost': instance.searchBoost,
      'salePriceLabel': instance.salePriceLabel,
      'productSubscription': instance.productSubscription?.toJson(),
      'replacementProductId': instance.replacementProductId,
      'warehouses': instance.warehouses?.map((e) => e.toJson()).toList(),
      'brand': instance.brand?.toJson(),
      'productNumber': instance.productNumber,
      'customerProductNumber': instance.customerProductNumber,
      'productTitle': instance.productTitle,
      'canonicalUrl': instance.canonicalUrl,
      'unitListPrice': instance.unitListPrice,
      'unitListPriceDisplay': instance.unitListPriceDisplay,
      'priceFacet': instance.priceFacet,
      'imageAltText': instance.imageAltText,
      'configurationType': instance.configurationType,
      'isVariantParent': instance.isVariantParent,
      'variantTypeId': instance.variantTypeId,
      'cantBuy': instance.cantBuy,
      'productLine': instance.productLine?.toJson(),
      'unitOfMeasures':
          instance.unitOfMeasures?.map((e) => e.toJson()).toList(),
      'scoreExplanation': instance.scoreExplanation?.toJson(),
      'detail': instance.detail?.toJson(),
      'content': instance.content?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'variantTraits': instance.variantTraits?.map((e) => e.toJson()).toList(),
      'childTraitValues':
          instance.childTraitValues?.map((e) => e.toJson()).toList(),
    };
