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
      minimumOrderQty: (json['minimumOrderQty'] as num?)?.toInt(),
      modelNumber: json['modelNumber'] as String?,
      multipleSaleQty: (json['multipleSaleQty'] as num?)?.toInt(),
      name: json['name'] as String?,
      orderLineId: json['orderLineId'] as String?,
      packDescription: json['packDescription'] as String?,
      pageTitle: json['pageTitle'] as String?,
      priceCode: json['priceCode'] as String?,
      priceFacet: (json['priceFacet'] as num?)?.toInt(),
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
      searchBoost: (json['searchBoost'] as num?)?.toInt(),
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
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
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
      allowZeroPricing: json['allowZeroPricing'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.orderLineId case final value?) 'orderLineId': value,
      if (instance.name case final value?) 'name': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.erpNumber case final value?) 'erpNumber': value,
      if (instance.erpDescription case final value?) 'erpDescription': value,
      if (instance.urlSegment case final value?) 'urlSegment': value,
      if (instance.basicListPrice case final value?) 'basicListPrice': value,
      if (instance.basicSalePrice case final value?) 'basicSalePrice': value,
      if (instance.basicSaleStartDate?.toIso8601String() case final value?)
        'basicSaleStartDate': value,
      if (instance.basicSaleEndDate?.toIso8601String() case final value?)
        'basicSaleEndDate': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.mediumImagePath case final value?) 'mediumImagePath': value,
      if (instance.largeImagePath case final value?) 'largeImagePath': value,
      if (instance.pricing?.toJson() case final value?) 'pricing': value,
      if (instance.currencySymbol case final value?) 'currencySymbol': value,
      if (instance.qtyOnHand case final value?) 'qtyOnHand': value,
      if (instance.isConfigured case final value?) 'isConfigured': value,
      if (instance.isFixedConfiguration case final value?)
        'isFixedConfiguration': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.isHazardousGood case final value?) 'isHazardousGood': value,
      if (instance.isDiscontinued case final value?) 'isDiscontinued': value,
      if (instance.isSpecialOrder case final value?) 'isSpecialOrder': value,
      if (instance.isGiftCard case final value?) 'isGiftCard': value,
      if (instance.isBeingCompared case final value?) 'isBeingCompared': value,
      if (instance.isSponsored case final value?) 'isSponsored': value,
      if (instance.isSubscription case final value?) 'isSubscription': value,
      if (instance.quoteRequired case final value?) 'quoteRequired': value,
      if (instance.manufacturerItem case final value?)
        'manufacturerItem': value,
      if (instance.packDescription case final value?) 'packDescription': value,
      if (instance.altText case final value?) 'altText': value,
      if (instance.customerUnitOfMeasure case final value?)
        'customerUnitOfMeasure': value,
      if (instance.canBackOrder case final value?) 'canBackOrder': value,
      if (instance.trackInventory case final value?) 'trackInventory': value,
      if (instance.multipleSaleQty case final value?) 'multipleSaleQty': value,
      if (instance.minimumOrderQty case final value?) 'minimumOrderQty': value,
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.productCode case final value?) 'productCode': value,
      if (instance.priceCode case final value?) 'priceCode': value,
      if (instance.sku case final value?) 'sku': value,
      if (instance.upcCode case final value?) 'upcCode': value,
      if (instance.modelNumber case final value?) 'modelNumber': value,
      if (instance.taxCode1 case final value?) 'taxCode1': value,
      if (instance.taxCode2 case final value?) 'taxCode2': value,
      if (instance.taxCategory case final value?) 'taxCategory': value,
      if (instance.shippingClassification case final value?)
        'shippingClassification': value,
      if (instance.shippingLength case final value?) 'shippingLength': value,
      if (instance.shippingWidth case final value?) 'shippingWidth': value,
      if (instance.shippingHeight case final value?) 'shippingHeight': value,
      if (instance.shippingWeight case final value?) 'shippingWeight': value,
      if (instance.qtyPerShippingPackage case final value?)
        'qtyPerShippingPackage': value,
      if (instance.shippingAmountOverride case final value?)
        'shippingAmountOverride': value,
      if (instance.handlingAmountOverride case final value?)
        'handlingAmountOverride': value,
      if (instance.metaDescription case final value?) 'metaDescription': value,
      if (instance.metaKeywords case final value?) 'metaKeywords': value,
      if (instance.pageTitle case final value?) 'pageTitle': value,
      if (instance.allowAnyGiftCardAmount case final value?)
        'allowAnyGiftCardAmount': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.hasMsds case final value?) 'hasMsds': value,
      if (instance.unspsc case final value?) 'unspsc': value,
      if (instance.roundingRule case final value?) 'roundingRule': value,
      if (instance.vendorNumber case final value?) 'vendorNumber': value,
      if (instance.configurationDto?.toJson() case final value?)
        'configurationDto': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.unitOfMeasureDisplay case final value?)
        'unitOfMeasureDisplay': value,
      if (instance.unitOfMeasureDescription case final value?)
        'unitOfMeasureDescription': value,
      if (instance.selectedUnitOfMeasure case final value?)
        'selectedUnitOfMeasure': value,
      if (instance.selectedUnitOfMeasureDisplay case final value?)
        'selectedUnitOfMeasureDisplay': value,
      if (instance.productDetailUrl case final value?)
        'productDetailUrl': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.allowedAddToCart case final value?)
        'allowedAddToCart': value,
      if (instance.canAddToWishlist case final value?)
        'canAddToWishlist': value,
      if (instance.canViewDetails case final value?) 'canViewDetails': value,
      if (instance.canShowPrice case final value?) 'canShowPrice': value,
      if (instance.canShowUnitOfMeasure case final value?)
        'canShowUnitOfMeasure': value,
      if (instance.canEnterQuantity case final value?)
        'canEnterQuantity': value,
      if (instance.canConfigure case final value?) 'canConfigure': value,
      if (instance.isStyleProductParent case final value?)
        'isStyleProductParent': value,
      if (instance.styleParentId case final value?) 'styleParentId': value,
      if (instance.requiresRealTimeInventory case final value?)
        'requiresRealTimeInventory': value,
      if (instance.availability?.toJson() case final value?)
        'availability': value,
      if (instance.styleTraits?.map((e) => e.toJson()).toList()
          case final value?)
        'styleTraits': value,
      if (instance.styledProducts?.map((e) => e.toJson()).toList()
          case final value?)
        'styledProducts': value,
      if (instance.attributeTypes?.map((e) => e.toJson()).toList()
          case final value?)
        'attributeTypes': value,
      if (instance.documents?.map((e) => e.toJson()).toList() case final value?)
        'documents': value,
      if (instance.specifications?.map((e) => e.toJson()).toList()
          case final value?)
        'specifications': value,
      if (instance.crossSells?.map((e) => e.toJson()).toList()
          case final value?)
        'crossSells': value,
      if (instance.accessories?.map((e) => e.toJson()).toList()
          case final value?)
        'accessories': value,
      if (instance.productUnitOfMeasures?.map((e) => e.toJson()).toList()
          case final value?)
        'productUnitOfMeasures': value,
      if (instance.productImages?.map((e) => e.toJson()).toList()
          case final value?)
        'productImages': value,
      if (instance.score case final value?) 'score': value,
      if (instance.searchBoost case final value?) 'searchBoost': value,
      if (instance.salePriceLabel case final value?) 'salePriceLabel': value,
      if (instance.productSubscription?.toJson() case final value?)
        'productSubscription': value,
      if (instance.replacementProductId case final value?)
        'replacementProductId': value,
      if (instance.warehouses?.map((e) => e.toJson()).toList()
          case final value?)
        'warehouses': value,
      if (instance.brand?.toJson() case final value?) 'brand': value,
      if (instance.productNumber case final value?) 'productNumber': value,
      if (instance.customerProductNumber case final value?)
        'customerProductNumber': value,
      if (instance.productTitle case final value?) 'productTitle': value,
      if (instance.canonicalUrl case final value?) 'canonicalUrl': value,
      if (instance.unitListPrice case final value?) 'unitListPrice': value,
      if (instance.unitListPriceDisplay case final value?)
        'unitListPriceDisplay': value,
      if (instance.priceFacet case final value?) 'priceFacet': value,
      if (instance.imageAltText case final value?) 'imageAltText': value,
      if (instance.configurationType case final value?)
        'configurationType': value,
      if (instance.isVariantParent case final value?) 'isVariantParent': value,
      if (instance.variantTypeId case final value?) 'variantTypeId': value,
      if (instance.cantBuy case final value?) 'cantBuy': value,
      if (instance.productLine?.toJson() case final value?)
        'productLine': value,
      if (instance.unitOfMeasures?.map((e) => e.toJson()).toList()
          case final value?)
        'unitOfMeasures': value,
      if (instance.scoreExplanation?.toJson() case final value?)
        'scoreExplanation': value,
      if (instance.detail?.toJson() case final value?) 'detail': value,
      if (instance.content?.toJson() case final value?) 'content': value,
      if (instance.images?.map((e) => e.toJson()).toList() case final value?)
        'images': value,
      if (instance.variantTraits?.map((e) => e.toJson()).toList()
          case final value?)
        'variantTraits': value,
      if (instance.childTraitValues?.map((e) => e.toJson()).toList()
          case final value?)
        'childTraitValues': value,
      if (instance.allowZeroPricing case final value?)
        'allowZeroPricing': value,
    };
