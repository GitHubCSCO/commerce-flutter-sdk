import 'package:collection/collection.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/attribute_type_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/badge_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/child_trait_value_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/document_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/inventory_warehouse_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/legacy_configuration_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_content_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_detail_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_image_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_unit_of_measure_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/score_explanation_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/specification_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/style_trait_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductEntityMapper {
  static ProductEntity toEntity(Product model) => ProductEntity(
        // V2 root fields (direct mapping)
        id: model.id,
        productNumber: model.productNumber,
        customerProductNumber: model.customerProductNumber,
        productTitle: model.productTitle,
        urlSegment: model.urlSegment,
        canonicalUrl: model.canonicalUrl,
        smallImagePath: model.smallImagePath,
        mediumImagePath: model.mediumImagePath,
        largeImagePath: model.largeImagePath,
        imageAltText: model.imageAltText,
        manufacturerItem: model.manufacturerItem,
        packDescription: model.packDescription,
        customerUnitOfMeasure: model.customerUnitOfMeasure,
        unitListPrice: model.unitListPrice,
        unitListPriceDisplay: model.unitListPriceDisplay,
        priceFacet: model.priceFacet,
        isDiscontinued: model.isDiscontinued,
        quoteRequired: model.quoteRequired,
        minimumOrderQty: model.minimumOrderQty,
        isSponsored: model.isSponsored,
        trackInventory: model.trackInventory,
        configurationType: model.configurationType,
        canConfigure: model.canConfigure,
        canAddToCart: model.canAddToCart,
        canAddToWishlist: model.canAddToWishlist,
        canShowPrice: model.canShowPrice,
        canShowUnitOfMeasure: model.canShowUnitOfMeasure,
        isVariantParent: model.isVariantParent,
        variantTypeId: model.variantTypeId,
        salePriceLabel: model.salePriceLabel,
        cantBuy: model.cantBuy,
        allowZeroPricing: model.allowZeroPricing,
        score: model.score,

        // V1 entity fields populated from V2 nested detail
        name: model.detail?.name ?? model.productTitle,
        erpNumber: model.productNumber,
        sku: model.detail?.sku,
        upcCode: model.detail?.upcCode,
        modelNumber: model.detail?.modelNumber,
        productCode: model.detail?.productCode,
        priceCode: model.detail?.priceCode,
        unspsc: model.detail?.unspsc,
        sortOrder: model.detail?.sortOrder,
        multipleSaleQty: model.detail?.multipleSaleQty,
        canBackOrder: model.detail?.canBackOrder,
        roundingRule: model.detail?.roundingRule,
        replacementProductId: model.detail?.replacementProductId,
        isHazardousGood: model.detail?.isHazardousGood,
        hasMsds: model.detail?.hasMsds,
        isSpecialOrder: model.detail?.isSpecialOrder,
        isGiftCard: model.detail?.isGiftCard,
        isSubscription: model.detail?.isSubscription,
        allowAnyGiftCardAmount: model.detail?.allowAnyGiftCardAmount,
        taxCode1: model.detail?.taxCode1,
        taxCode2: model.detail?.taxCode2,
        taxCategory: model.detail?.taxCategory,
        shippingClassification: model.detail?.shippingClassification,
        shippingLength: model.detail?.shippingLength?.toString(),
        shippingWidth: model.detail?.shippingWidth?.toString(),
        shippingHeight: model.detail?.shippingHeight?.toString(),
        shippingWeight: model.detail?.shippingWeight?.toString(),
        configurationDto: model.detail?.configuration != null
            ? LegacyConfigurationEntityMapper()
                .toEntity(model.detail!.configuration)
            : null,

        // V1 entity fields populated from V2 nested content
        htmlContent: model.content?.htmlContent,
        pageTitle: model.content?.pageTitle,
        metaDescription: model.content?.metaDescription,
        metaKeywords: model.content?.metaKeywords,

        // V1 fields with no V2 equivalent (null/defaults)
        shortDescription: model.productTitle ?? model.detail?.name,
        erpDescription: null,
        customerName: null,
        basicListPrice: null,
        basicSalePrice: null,
        basicSaleStartDate: null,
        basicSaleEndDate: null,
        pricing: null,
        availability: null,
        qtyOnHand: null,
        isConfigured: model.configurationType != null &&
            model.configurationType!.toLowerCase() != 'none',
        isFixedConfiguration: model.configurationType?.toLowerCase() == 'fixed',
        isActive: null,
        isBeingCompared: false,
        isStyleProductParent: model.isVariantParent,
        styleParentId: null,
        crossSells: null,
        accessories: null,
        unitOfMeasure: model.unitOfMeasures
            ?.firstWhereOrNull((u) => u.isDefault == true)
            ?.unitOfMeasure,
        unitOfMeasureDisplay: model.unitOfMeasures
            ?.firstWhereOrNull((u) => u.isDefault == true)
            ?.unitOfMeasureDisplay,
        unitOfMeasureDescription: model.unitOfMeasures
            ?.firstWhereOrNull((u) => u.isDefault == true)
            ?.description,
        selectedUnitOfMeasure: null,
        selectedUnitOfMeasureDisplay: null,
        productDetailUrl: model.canonicalUrl,
        searchBoost: null,
        vendorNumber: null,
        currencySymbol: null,
        shippingAmountOverride: null,
        handlingAmountOverride: null,
        orderLineId: null,
        numberInCart: null,
        qtyOrdered: null,
        canViewDetails: true,
        canEnterQuantity: true,
        allowedAddToCart: model.canAddToCart,
        requiresRealTimeInventory: null,
        qtyPerShippingPackage: null,

        // V2 list fields
        variantTraits: model.variantTraits
            ?.map((e) => StyleTraitEntityMapper.toEntity(e))
            .toList(),
        childTraitValues: model.childTraitValues
            ?.map((e) => ChildTraitValueEntityMapper.toEntity(e))
            .toList(),
        unitOfMeasures: model.unitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toEntity(e))
            .toList(),
        productUnitOfMeasures: model.unitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toEntity(e))
            .toList(),
        images: model.images
            ?.map((e) => ProductImageEntityMapper.toEntity(e))
            .toList(),
        productImages: model.images
            ?.map((e) => ProductImageEntityMapper.toEntity(e))
            .toList(),
        attributeTypes: model.attributeTypes
            ?.map((e) => AttributeTypeEntityMapper().toEntity(e))
            .toList(),
        documents: model.documents
            ?.map((e) => DocumentEntityMapper().toEntity(e))
            .toList(),
        specifications: model.specifications
            ?.map((e) => SpecificationEntityMapper().toEntity(e))
            .toList(),
        warehouses: model.warehouses
            ?.map((e) => InventoryWarehouseEntityMapper().toEntity(e))
            .toList(),

        // Nested objects
        brand: model.brand != null
            ? BrandEntityMapper.toEntity(model.brand)
            : null,
        productLine: model.productLine != null
            ? ProductLineEntityMapper.toEntity(model.productLine)
            : null,
        detail: model.detail != null
            ? ProductDetailEntityMapper.toEntity(model.detail)
            : null,
        content: model.content != null
            ? ProductContentEntityMapper().toEntity(model.content)
            : null,
        scoreExplanation: model.scoreExplanation != null
            ? ScoreExplanationEntityMapper.toEntity(model.scoreExplanation)
            : null,
        productSubscription: model.detail?.subscription != null
            ? ProductSubscriptionEntityMapper.toEntity(
                model.detail!.subscription)
            : null,
        badges: model.badges
            ?.map((e) => BadgeEntityMapper.toEntity(e))
            .toList(),
        displayUrl: model.displayUrl,
        defaultChildProductId: model.defaultChildProductId,
        properties: model.properties,
      );

  static Product toModel(ProductEntity entity) => Product(
        id: entity.id,
        productNumber: entity.productNumber ?? entity.erpNumber,
        customerProductNumber: entity.customerProductNumber,
        productTitle: entity.productTitle ?? entity.name,
        urlSegment: entity.urlSegment,
        displayUrl: entity.displayUrl,
        canonicalUrl: entity.canonicalUrl ?? entity.productDetailUrl,
        smallImagePath: entity.smallImagePath,
        mediumImagePath: entity.mediumImagePath,
        largeImagePath: entity.largeImagePath,
        imageAltText: entity.imageAltText ?? entity.altText,
        manufacturerItem: entity.manufacturerItem,
        packDescription: entity.packDescription,
        customerUnitOfMeasure: entity.customerUnitOfMeasure,
        unitListPrice: entity.unitListPrice,
        unitListPriceDisplay: entity.unitListPriceDisplay,
        priceFacet: entity.priceFacet,
        isDiscontinued: entity.isDiscontinued,
        quoteRequired: entity.quoteRequired,
        minimumOrderQty: entity.minimumOrderQty,
        isSponsored: entity.isSponsored,
        trackInventory: entity.trackInventory,
        configurationType: entity.configurationType,
        canConfigure: entity.canConfigure,
        canAddToCart: entity.canAddToCart,
        canAddToWishlist: entity.canAddToWishlist,
        canShowPrice: entity.canShowPrice,
        canShowUnitOfMeasure: entity.canShowUnitOfMeasure,
        isVariantParent: entity.isVariantParent ?? entity.isStyleProductParent,
        defaultChildProductId: entity.defaultChildProductId,
        variantTypeId: entity.variantTypeId,
        salePriceLabel: entity.salePriceLabel,
        cantBuy: entity.cantBuy,
        allowZeroPricing: entity.allowZeroPricing,
        score: entity.score,
        brand: entity.brand != null
            ? BrandEntityMapper.toModel(entity.brand!)
            : null,
        productLine: entity.productLine != null
            ? ProductLineEntityMapper.toModel(entity.productLine!)
            : null,
        unitOfMeasures: entity.unitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toModel(e))
            .toList(),
        scoreExplanation: entity.scoreExplanation != null
            ? ScoreExplanationEntityMapper.toModel(entity.scoreExplanation!)
            : null,
        detail: entity.detail != null
            ? ProductDetailEntityMapper.toModel(entity.detail!)
            : null,
        content: entity.content != null
            ? ProductContentEntityMapper().toModel(entity.content!)
            : null,
        images: entity.images
            ?.map((e) => ProductImageEntityMapper.toModel(e))
            .toList(),
        variantTraits: entity.variantTraits
            ?.map((e) => StyleTraitEntityMapper.toModel(e))
            .toList(),
        childTraitValues: entity.childTraitValues
            ?.map((e) => ChildTraitValueEntityMapper.toModel(e))
            .toList(),
        attributeTypes: entity.attributeTypes
            ?.map((e) => AttributeTypeEntityMapper().toModel(e))
            .toList(),
        documents: entity.documents
            ?.map((e) => DocumentEntityMapper().toModel(e))
            .toList(),
        specifications: entity.specifications
            ?.map((e) => SpecificationEntityMapper().toModel(e))
            .toList(),
        warehouses: entity.warehouses
            ?.map((e) => InventoryWarehouseEntityMapper().toModel(e))
            .toList(),
        badges: entity.badges
            ?.map((e) => BadgeEntityMapper.toModel(e))
            .toList(),
      )..properties = entity.properties;
}
