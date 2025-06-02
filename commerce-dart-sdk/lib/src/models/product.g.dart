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

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('orderLineId', instance.orderLineId);
  writeNotNull('name', instance.name);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('erpNumber', instance.erpNumber);
  writeNotNull('erpDescription', instance.erpDescription);
  writeNotNull('urlSegment', instance.urlSegment);
  writeNotNull('basicListPrice', instance.basicListPrice);
  writeNotNull('basicSalePrice', instance.basicSalePrice);
  writeNotNull(
      'basicSaleStartDate', instance.basicSaleStartDate?.toIso8601String());
  writeNotNull(
      'basicSaleEndDate', instance.basicSaleEndDate?.toIso8601String());
  writeNotNull('smallImagePath', instance.smallImagePath);
  writeNotNull('mediumImagePath', instance.mediumImagePath);
  writeNotNull('largeImagePath', instance.largeImagePath);
  writeNotNull('pricing', instance.pricing?.toJson());
  writeNotNull('currencySymbol', instance.currencySymbol);
  writeNotNull('qtyOnHand', instance.qtyOnHand);
  writeNotNull('isConfigured', instance.isConfigured);
  writeNotNull('isFixedConfiguration', instance.isFixedConfiguration);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('isHazardousGood', instance.isHazardousGood);
  writeNotNull('isDiscontinued', instance.isDiscontinued);
  writeNotNull('isSpecialOrder', instance.isSpecialOrder);
  writeNotNull('isGiftCard', instance.isGiftCard);
  writeNotNull('isBeingCompared', instance.isBeingCompared);
  writeNotNull('isSponsored', instance.isSponsored);
  writeNotNull('isSubscription', instance.isSubscription);
  writeNotNull('quoteRequired', instance.quoteRequired);
  writeNotNull('manufacturerItem', instance.manufacturerItem);
  writeNotNull('packDescription', instance.packDescription);
  writeNotNull('altText', instance.altText);
  writeNotNull('customerUnitOfMeasure', instance.customerUnitOfMeasure);
  writeNotNull('canBackOrder', instance.canBackOrder);
  writeNotNull('trackInventory', instance.trackInventory);
  writeNotNull('multipleSaleQty', instance.multipleSaleQty);
  writeNotNull('minimumOrderQty', instance.minimumOrderQty);
  writeNotNull('htmlContent', instance.htmlContent);
  writeNotNull('productCode', instance.productCode);
  writeNotNull('priceCode', instance.priceCode);
  writeNotNull('sku', instance.sku);
  writeNotNull('upcCode', instance.upcCode);
  writeNotNull('modelNumber', instance.modelNumber);
  writeNotNull('taxCode1', instance.taxCode1);
  writeNotNull('taxCode2', instance.taxCode2);
  writeNotNull('taxCategory', instance.taxCategory);
  writeNotNull('shippingClassification', instance.shippingClassification);
  writeNotNull('shippingLength', instance.shippingLength);
  writeNotNull('shippingWidth', instance.shippingWidth);
  writeNotNull('shippingHeight', instance.shippingHeight);
  writeNotNull('shippingWeight', instance.shippingWeight);
  writeNotNull('qtyPerShippingPackage', instance.qtyPerShippingPackage);
  writeNotNull('shippingAmountOverride', instance.shippingAmountOverride);
  writeNotNull('handlingAmountOverride', instance.handlingAmountOverride);
  writeNotNull('metaDescription', instance.metaDescription);
  writeNotNull('metaKeywords', instance.metaKeywords);
  writeNotNull('pageTitle', instance.pageTitle);
  writeNotNull('allowAnyGiftCardAmount', instance.allowAnyGiftCardAmount);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('hasMsds', instance.hasMsds);
  writeNotNull('unspsc', instance.unspsc);
  writeNotNull('roundingRule', instance.roundingRule);
  writeNotNull('vendorNumber', instance.vendorNumber);
  writeNotNull('configurationDto', instance.configurationDto?.toJson());
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('unitOfMeasureDisplay', instance.unitOfMeasureDisplay);
  writeNotNull('unitOfMeasureDescription', instance.unitOfMeasureDescription);
  writeNotNull('selectedUnitOfMeasure', instance.selectedUnitOfMeasure);
  writeNotNull(
      'selectedUnitOfMeasureDisplay', instance.selectedUnitOfMeasureDisplay);
  writeNotNull('productDetailUrl', instance.productDetailUrl);
  writeNotNull('canAddToCart', instance.canAddToCart);
  writeNotNull('allowedAddToCart', instance.allowedAddToCart);
  writeNotNull('canAddToWishlist', instance.canAddToWishlist);
  writeNotNull('canViewDetails', instance.canViewDetails);
  writeNotNull('canShowPrice', instance.canShowPrice);
  writeNotNull('canShowUnitOfMeasure', instance.canShowUnitOfMeasure);
  writeNotNull('canEnterQuantity', instance.canEnterQuantity);
  writeNotNull('canConfigure', instance.canConfigure);
  writeNotNull('isStyleProductParent', instance.isStyleProductParent);
  writeNotNull('styleParentId', instance.styleParentId);
  writeNotNull('requiresRealTimeInventory', instance.requiresRealTimeInventory);
  writeNotNull('availability', instance.availability?.toJson());
  writeNotNull(
      'styleTraits', instance.styleTraits?.map((e) => e.toJson()).toList());
  writeNotNull('styledProducts',
      instance.styledProducts?.map((e) => e.toJson()).toList());
  writeNotNull('attributeTypes',
      instance.attributeTypes?.map((e) => e.toJson()).toList());
  writeNotNull(
      'documents', instance.documents?.map((e) => e.toJson()).toList());
  writeNotNull('specifications',
      instance.specifications?.map((e) => e.toJson()).toList());
  writeNotNull(
      'crossSells', instance.crossSells?.map((e) => e.toJson()).toList());
  writeNotNull(
      'accessories', instance.accessories?.map((e) => e.toJson()).toList());
  writeNotNull('productUnitOfMeasures',
      instance.productUnitOfMeasures?.map((e) => e.toJson()).toList());
  writeNotNull(
      'productImages', instance.productImages?.map((e) => e.toJson()).toList());
  writeNotNull('score', instance.score);
  writeNotNull('searchBoost', instance.searchBoost);
  writeNotNull('salePriceLabel', instance.salePriceLabel);
  writeNotNull('productSubscription', instance.productSubscription?.toJson());
  writeNotNull('replacementProductId', instance.replacementProductId);
  writeNotNull(
      'warehouses', instance.warehouses?.map((e) => e.toJson()).toList());
  writeNotNull('brand', instance.brand?.toJson());
  writeNotNull('productNumber', instance.productNumber);
  writeNotNull('customerProductNumber', instance.customerProductNumber);
  writeNotNull('productTitle', instance.productTitle);
  writeNotNull('canonicalUrl', instance.canonicalUrl);
  writeNotNull('unitListPrice', instance.unitListPrice);
  writeNotNull('unitListPriceDisplay', instance.unitListPriceDisplay);
  writeNotNull('priceFacet', instance.priceFacet);
  writeNotNull('imageAltText', instance.imageAltText);
  writeNotNull('configurationType', instance.configurationType);
  writeNotNull('isVariantParent', instance.isVariantParent);
  writeNotNull('variantTypeId', instance.variantTypeId);
  writeNotNull('cantBuy', instance.cantBuy);
  writeNotNull('productLine', instance.productLine?.toJson());
  writeNotNull('unitOfMeasures',
      instance.unitOfMeasures?.map((e) => e.toJson()).toList());
  writeNotNull('scoreExplanation', instance.scoreExplanation?.toJson());
  writeNotNull('detail', instance.detail?.toJson());
  writeNotNull('content', instance.content?.toJson());
  writeNotNull('images', instance.images?.map((e) => e.toJson()).toList());
  writeNotNull(
      'variantTraits', instance.variantTraits?.map((e) => e.toJson()).toList());
  writeNotNull('childTraitValues',
      instance.childTraitValues?.map((e) => e.toJson()).toList());
  writeNotNull('allowZeroPricing', instance.allowZeroPricing);
  return val;
}
