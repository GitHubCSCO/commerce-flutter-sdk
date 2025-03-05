// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/attribute_type_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/child_trait_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/document._entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/inventory_warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_content_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_detail_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/score_explanation_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/specification_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_trait_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? orderLineId;
  final String? name;
  final String? customerName;
  final String? shortDescription;
  final String? erpNumber;
  final String? erpDescription;
  final String? urlSegment;
  final num? basicListPrice;
  final num? basicSalePrice;
  final DateTime? basicSaleStartDate;
  final DateTime? basicSaleEndDate;
  final String? smallImagePath;
  final String? mediumImagePath;
  final String? largeImagePath;
  ProductPriceEntity? pricing;
  final String? currencySymbol;
  final num? qtyOnHand;
  final bool? isConfigured;
  final bool? isFixedConfiguration;
  final bool? isActive;
  final bool? isHazardousGood;
  final bool? isDiscontinued;
  final bool? isSpecialOrder;
  final bool? isGiftCard;
  final bool? isBeingCompared;
  final bool? isSponsored;
  final bool? isSubscription;
  final bool? quoteRequired;
  final String? manufacturerItem;
  final String? packDescription;
  final String? altText;
  final String? customerUnitOfMeasure;
  final bool? canBackOrder;
  final bool? trackInventory;
  final int? multipleSaleQty;
  final int? minimumOrderQty;
  final String? htmlContent;
  final String? productCode;
  final String? priceCode;
  final String? sku;
  final String? upcCode;
  final String? modelNumber;
  final String? taxCode1;
  final String? taxCode2;
  final String? taxCategory;
  final String? shippingClassification;
  final String? shippingLength;
  final String? shippingWidth;
  final String? shippingHeight;
  final String? shippingWeight;
  final num? qtyPerShippingPackage;
  final num? shippingAmountOverride;
  final num? handlingAmountOverride;
  final String? metaDescription;
  final String? metaKeywords;
  final String? pageTitle;
  final bool? allowAnyGiftCardAmount;
  final int? sortOrder;
  final bool? hasMsds;
  final String? unspsc;
  final String? roundingRule;
  final String? vendorNumber;
  final LegacyConfigurationEntity? configurationDto;
  final String? unitOfMeasure;
  final String? unitOfMeasureDisplay;
  final String? unitOfMeasureDescription;
  final String? selectedUnitOfMeasure;
  final String? selectedUnitOfMeasureDisplay;
  final String? productDetailUrl;
  final bool? canAddToCart;
  final bool? allowedAddToCart;
  final bool? canAddToWishlist;
  final bool? canViewDetails;
  final bool? canShowPrice;

  final bool? canShowUnitOfMeasure;
  final bool? canEnterQuantity;
  final bool? canConfigure;
  final bool? isStyleProductParent;
  final String? styleParentId;
  final bool? requiresRealTimeInventory;
  final num? numberInCart;
  final num? qtyOrdered;
  AvailabilityEntity? availability;
  final List<StyleTraitEntity>? styleTraits;
  final List<StyledProductEntity>? styledProducts;
  final List<AttributeTypeEntity>? attributeTypes;
  final List<DocumentEntity>? documents;
  final List<SpecificationEntity>? specifications;
  final List<ProductEntity>? crossSells;
  final List<ProductEntity>? accessories;
  final List<ProductUnitOfMeasureEntity>? productUnitOfMeasures;
  final List<ProductImageEntity>? productImages;
  final double? score;
  final int? searchBoost;
  final String? salePriceLabel;
  final ProductSubscriptionEntity? productSubscription;
  final String? replacementProductId;
  final List<InventoryWarehouseEntity>? warehouses;
  final BrandEntity? brand;
  final String? productNumber;
  final String? customerProductNumber;
  final String? productTitle;
  final String? canonicalUrl;
  final num? unitListPrice;
  final String? unitListPriceDisplay;
  final int? priceFacet;
  final String? imageAltText;
  final String? configurationType;
  final bool? isVariantParent;
  final String? variantTypeId;
  final bool? cantBuy;
  final ProductLineEntity? productLine;
  final List<ProductUnitOfMeasureEntity>? unitOfMeasures;
  final ScoreExplanationEntity? scoreExplanation;
  final ProductDetailEntity? detail;
  final ProductContentEntity? content;
  final List<ProductImageEntity>? images;
  final List<StyleTraitEntity>? variantTraits;
  final List<ChildTraitValueEntity>? childTraitValues;
  final bool? allowZeroPricing;

  final Properties? properties;

  ProductEntity({
    this.id,
    this.orderLineId,
    this.name,
    this.customerName,
    this.shortDescription,
    this.erpNumber,
    this.erpDescription,
    this.urlSegment,
    this.basicListPrice,
    this.basicSalePrice,
    this.basicSaleStartDate,
    this.basicSaleEndDate,
    this.smallImagePath,
    this.mediumImagePath,
    this.largeImagePath,
    this.pricing,
    this.currencySymbol,
    this.qtyOnHand,
    this.isConfigured,
    this.isFixedConfiguration,
    this.isActive,
    this.isHazardousGood,
    this.isDiscontinued,
    this.isSpecialOrder,
    this.isGiftCard,
    this.isBeingCompared,
    this.isSponsored,
    this.isSubscription,
    this.quoteRequired,
    this.manufacturerItem,
    this.packDescription,
    this.altText,
    this.customerUnitOfMeasure,
    this.canBackOrder,
    this.trackInventory,
    this.multipleSaleQty,
    this.minimumOrderQty,
    this.htmlContent,
    this.productCode,
    this.priceCode,
    this.sku,
    this.upcCode,
    this.modelNumber,
    this.taxCode1,
    this.taxCode2,
    this.taxCategory,
    this.shippingClassification,
    this.shippingLength,
    this.shippingWidth,
    this.shippingHeight,
    this.shippingWeight,
    this.qtyPerShippingPackage,
    this.shippingAmountOverride,
    this.handlingAmountOverride,
    this.metaDescription,
    this.metaKeywords,
    this.pageTitle,
    this.allowAnyGiftCardAmount,
    this.sortOrder,
    this.hasMsds,
    this.unspsc,
    this.roundingRule,
    this.vendorNumber,
    this.configurationDto,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
    this.unitOfMeasureDescription,
    this.selectedUnitOfMeasure,
    this.selectedUnitOfMeasureDisplay,
    this.productDetailUrl,
    this.canAddToCart,
    this.allowedAddToCart,
    this.canAddToWishlist,
    this.canViewDetails,
    this.canShowPrice,
    this.canShowUnitOfMeasure,
    this.canEnterQuantity,
    this.canConfigure,
    this.isStyleProductParent,
    this.styleParentId,
    this.requiresRealTimeInventory,
    this.numberInCart,
    this.qtyOrdered,
    this.availability,
    this.styleTraits,
    this.styledProducts,
    this.attributeTypes,
    this.documents,
    this.specifications,
    this.crossSells,
    this.accessories,
    this.productUnitOfMeasures,
    this.productImages,
    this.score,
    this.searchBoost,
    this.salePriceLabel,
    this.productSubscription,
    this.replacementProductId,
    this.warehouses,
    this.brand,
    this.productNumber,
    this.customerProductNumber,
    this.productTitle,
    this.canonicalUrl,
    this.unitListPrice,
    this.unitListPriceDisplay,
    this.priceFacet,
    this.imageAltText,
    this.configurationType,
    this.isVariantParent,
    this.variantTypeId,
    this.cantBuy,
    this.productLine,
    this.unitOfMeasures,
    this.scoreExplanation,
    this.detail,
    this.content,
    this.images,
    this.variantTraits,
    this.childTraitValues,
    this.properties,
    this.allowZeroPricing,
  });

  ProductEntity copyWith({
    String? id,
    String? orderLineId,
    String? name,
    String? customerName,
    String? shortDescription,
    String? erpNumber,
    String? erpDescription,
    String? urlSegment,
    num? basicListPrice,
    num? basicSalePrice,
    DateTime? basicSaleStartDate,
    DateTime? basicSaleEndDate,
    String? smallImagePath,
    String? mediumImagePath,
    String? largeImagePath,
    ProductPriceEntity? pricing,
    String? currencySymbol,
    num? qtyOnHand,
    bool? isConfigured,
    bool? isFixedConfiguration,
    bool? isActive,
    bool? isHazardousGood,
    bool? isDiscontinued,
    bool? isSpecialOrder,
    bool? isGiftCard,
    bool? isBeingCompared,
    bool? isSponsored,
    bool? isSubscription,
    bool? quoteRequired,
    String? manufacturerItem,
    String? packDescription,
    String? altText,
    String? customerUnitOfMeasure,
    bool? canBackOrder,
    bool? trackInventory,
    int? multipleSaleQty,
    int? minimumOrderQty,
    String? htmlContent,
    String? productCode,
    String? priceCode,
    String? sku,
    String? upcCode,
    String? modelNumber,
    String? taxCode1,
    String? taxCode2,
    String? taxCategory,
    String? shippingClassification,
    String? shippingLength,
    String? shippingWidth,
    String? shippingHeight,
    String? shippingWeight,
    num? qtyPerShippingPackage,
    num? shippingAmountOverride,
    num? handlingAmountOverride,
    String? metaDescription,
    String? metaKeywords,
    String? pageTitle,
    bool? allowAnyGiftCardAmount,
    int? sortOrder,
    bool? hasMsds,
    String? unspsc,
    String? roundingRule,
    String? vendorNumber,
    LegacyConfigurationEntity? configurationDto,
    String? unitOfMeasure,
    String? unitOfMeasureDisplay,
    String? unitOfMeasureDescription,
    String? selectedUnitOfMeasure,
    String? selectedUnitOfMeasureDisplay,
    String? productDetailUrl,
    bool? canAddToCart,
    bool? allowedAddToCart,
    bool? canAddToWishlist,
    bool? canViewDetails,
    bool? canShowPrice,
    bool? canShowUnitOfMeasure,
    bool? canEnterQuantity,
    bool? canConfigure,
    bool? isStyleProductParent,
    String? styleParentId,
    bool? requiresRealTimeInventory,
    num? numberInCart,
    num? qtyOrdered,
    AvailabilityEntity? availability,
    List<StyleTraitEntity>? styleTraits,
    List<StyledProductEntity>? styledProducts,
    List<AttributeTypeEntity>? attributeTypes,
    List<DocumentEntity>? documents,
    List<SpecificationEntity>? specifications,
    List<ProductEntity>? crossSells,
    List<ProductEntity>? accessories,
    List<ProductUnitOfMeasureEntity>? productUnitOfMeasures,
    List<ProductImageEntity>? productImages,
    double? score,
    int? searchBoost,
    String? salePriceLabel,
    ProductSubscriptionEntity? productSubscription,
    String? replacementProductId,
    List<InventoryWarehouseEntity>? warehouses,
    BrandEntity? brand,
    String? productNumber,
    String? customerProductNumber,
    String? productTitle,
    String? canonicalUrl,
    num? unitListPrice,
    String? unitListPriceDisplay,
    int? priceFacet,
    String? imageAltText,
    String? configurationType,
    bool? isVariantParent,
    String? variantTypeId,
    bool? cantBuy,
    ProductLineEntity? productLine,
    List<ProductUnitOfMeasureEntity>? unitOfMeasures,
    ScoreExplanationEntity? scoreExplanation,
    ProductDetailEntity? detail,
    ProductContentEntity? content,
    List<ProductImageEntity>? images,
    List<StyleTraitEntity>? variantTraits,
    List<ChildTraitValueEntity>? childTraitValues,
    Properties? properties,
    bool? allowZeroPricing,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      orderLineId: orderLineId ?? this.orderLineId,
      name: name ?? this.name,
      customerName: customerName ?? this.customerName,
      shortDescription: shortDescription ?? this.shortDescription,
      erpNumber: erpNumber ?? this.erpNumber,
      erpDescription: erpDescription ?? this.erpDescription,
      urlSegment: urlSegment ?? this.urlSegment,
      basicListPrice: basicListPrice ?? this.basicListPrice,
      basicSalePrice: basicSalePrice ?? this.basicSalePrice,
      basicSaleStartDate: basicSaleStartDate ?? this.basicSaleStartDate,
      basicSaleEndDate: basicSaleEndDate ?? this.basicSaleEndDate,
      smallImagePath: smallImagePath ?? this.smallImagePath,
      mediumImagePath: mediumImagePath ?? this.mediumImagePath,
      largeImagePath: largeImagePath ?? this.largeImagePath,
      pricing: pricing ?? this.pricing,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      qtyOnHand: qtyOnHand ?? this.qtyOnHand,
      isConfigured: isConfigured ?? this.isConfigured,
      isFixedConfiguration: isFixedConfiguration ?? this.isFixedConfiguration,
      isActive: isActive ?? this.isActive,
      isHazardousGood: isHazardousGood ?? this.isHazardousGood,
      isDiscontinued: isDiscontinued ?? this.isDiscontinued,
      isSpecialOrder: isSpecialOrder ?? this.isSpecialOrder,
      isGiftCard: isGiftCard ?? this.isGiftCard,
      isBeingCompared: isBeingCompared ?? this.isBeingCompared,
      isSponsored: isSponsored ?? this.isSponsored,
      isSubscription: isSubscription ?? this.isSubscription,
      quoteRequired: quoteRequired ?? this.quoteRequired,
      manufacturerItem: manufacturerItem ?? this.manufacturerItem,
      packDescription: packDescription ?? this.packDescription,
      altText: altText ?? this.altText,
      customerUnitOfMeasure:
          customerUnitOfMeasure ?? this.customerUnitOfMeasure,
      canBackOrder: canBackOrder ?? this.canBackOrder,
      trackInventory: trackInventory ?? this.trackInventory,
      multipleSaleQty: multipleSaleQty ?? this.multipleSaleQty,
      minimumOrderQty: minimumOrderQty ?? this.minimumOrderQty,
      htmlContent: htmlContent ?? this.htmlContent,
      productCode: productCode ?? this.productCode,
      priceCode: priceCode ?? this.priceCode,
      sku: sku ?? this.sku,
      upcCode: upcCode ?? this.upcCode,
      modelNumber: modelNumber ?? this.modelNumber,
      taxCode1: taxCode1 ?? this.taxCode1,
      taxCode2: taxCode2 ?? this.taxCode2,
      taxCategory: taxCategory ?? this.taxCategory,
      shippingClassification:
          shippingClassification ?? this.shippingClassification,
      shippingLength: shippingLength ?? this.shippingLength,
      shippingWidth: shippingWidth ?? this.shippingWidth,
      shippingHeight: shippingHeight ?? this.shippingHeight,
      shippingWeight: shippingWeight ?? this.shippingWeight,
      qtyPerShippingPackage:
          qtyPerShippingPackage ?? this.qtyPerShippingPackage,
      shippingAmountOverride:
          shippingAmountOverride ?? this.shippingAmountOverride,
      handlingAmountOverride:
          handlingAmountOverride ?? this.handlingAmountOverride,
      metaDescription: metaDescription ?? this.metaDescription,
      metaKeywords: metaKeywords ?? this.metaKeywords,
      pageTitle: pageTitle ?? this.pageTitle,
      allowAnyGiftCardAmount:
          allowAnyGiftCardAmount ?? this.allowAnyGiftCardAmount,
      sortOrder: sortOrder ?? this.sortOrder,
      hasMsds: hasMsds ?? this.hasMsds,
      unspsc: unspsc ?? this.unspsc,
      roundingRule: roundingRule ?? this.roundingRule,
      vendorNumber: vendorNumber ?? this.vendorNumber,
      configurationDto: configurationDto ?? this.configurationDto,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      unitOfMeasureDisplay: unitOfMeasureDisplay ?? this.unitOfMeasureDisplay,
      unitOfMeasureDescription:
          unitOfMeasureDescription ?? this.unitOfMeasureDescription,
      selectedUnitOfMeasure:
          selectedUnitOfMeasure ?? this.selectedUnitOfMeasure,
      selectedUnitOfMeasureDisplay:
          selectedUnitOfMeasureDisplay ?? this.selectedUnitOfMeasureDisplay,
      productDetailUrl: productDetailUrl ?? this.productDetailUrl,
      canAddToCart: canAddToCart ?? this.canAddToCart,
      allowedAddToCart: allowedAddToCart ?? this.allowedAddToCart,
      canAddToWishlist: canAddToWishlist ?? this.canAddToWishlist,
      canViewDetails: canViewDetails ?? this.canViewDetails,
      canShowPrice: canShowPrice ?? this.canShowPrice,
      canShowUnitOfMeasure: canShowUnitOfMeasure ?? this.canShowUnitOfMeasure,
      canEnterQuantity: canEnterQuantity ?? this.canEnterQuantity,
      canConfigure: canConfigure ?? this.canConfigure,
      isStyleProductParent: isStyleProductParent ?? this.isStyleProductParent,
      styleParentId: styleParentId ?? this.styleParentId,
      requiresRealTimeInventory:
          requiresRealTimeInventory ?? this.requiresRealTimeInventory,
      numberInCart: numberInCart ?? this.numberInCart,
      qtyOrdered: qtyOrdered ?? this.qtyOrdered,
      availability: availability ?? this.availability,
      styleTraits: styleTraits ?? this.styleTraits,
      styledProducts: styledProducts ?? this.styledProducts,
      attributeTypes: attributeTypes ?? this.attributeTypes,
      documents: documents ?? this.documents,
      specifications: specifications ?? this.specifications,
      crossSells: crossSells ?? this.crossSells,
      accessories: accessories ?? this.accessories,
      productUnitOfMeasures:
          productUnitOfMeasures ?? this.productUnitOfMeasures,
      productImages: productImages ?? this.productImages,
      score: score ?? this.score,
      searchBoost: searchBoost ?? this.searchBoost,
      salePriceLabel: salePriceLabel ?? this.salePriceLabel,
      productSubscription: productSubscription ?? this.productSubscription,
      replacementProductId: replacementProductId ?? this.replacementProductId,
      warehouses: warehouses ?? this.warehouses,
      brand: brand ?? this.brand,
      productNumber: productNumber ?? this.productNumber,
      customerProductNumber:
          customerProductNumber ?? this.customerProductNumber,
      productTitle: productTitle ?? this.productTitle,
      canonicalUrl: canonicalUrl ?? this.canonicalUrl,
      unitListPrice: unitListPrice ?? this.unitListPrice,
      unitListPriceDisplay: unitListPriceDisplay ?? this.unitListPriceDisplay,
      priceFacet: priceFacet ?? this.priceFacet,
      imageAltText: imageAltText ?? this.imageAltText,
      configurationType: configurationType ?? this.configurationType,
      isVariantParent: isVariantParent ?? this.isVariantParent,
      variantTypeId: variantTypeId ?? this.variantTypeId,
      cantBuy: cantBuy ?? this.cantBuy,
      productLine: productLine ?? this.productLine,
      unitOfMeasures: unitOfMeasures ?? this.unitOfMeasures,
      scoreExplanation: scoreExplanation ?? this.scoreExplanation,
      detail: detail ?? this.detail,
      content: content ?? this.content,
      images: images ?? this.images,
      variantTraits: variantTraits ?? this.variantTraits,
      childTraitValues: childTraitValues ?? this.childTraitValues,
      properties: properties ?? this.properties,
      allowZeroPricing: allowZeroPricing ?? this.allowZeroPricing,
    );
  }

  @override
  List<Object?> get props => [id];

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      ProductEntityMapper.toEntity(Product.fromJson(json));

  Map<String, dynamic> toJson() => ProductEntityMapper.toModel(this).toJson();
}
