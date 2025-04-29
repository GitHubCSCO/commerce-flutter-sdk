import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_content_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_detail_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/score_explanation_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/attribute_type_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/child_trait_value_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/document_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/inventory_warehouse_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/legacy_configuration_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_content_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_detail_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_image_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_unit_of_measure_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/score_explanation_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/specification_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/style_trait_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/styled_prodct_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductEntityMapper {
  static ProductEntity toEntity(Product model) => ProductEntity(
        id: model.id,
        orderLineId: model.orderLineId,
        name: model.name,
        customerName: model.customerName,
        shortDescription: model.shortDescription,
        erpNumber: model.erpNumber,
        erpDescription: model.erpDescription,
        urlSegment: model.urlSegment,
        basicListPrice: model.basicListPrice,
        basicSalePrice: model.basicSalePrice,
        basicSaleStartDate: model.basicSaleStartDate,
        basicSaleEndDate: model.basicSaleEndDate,
        smallImagePath: model.smallImagePath,
        mediumImagePath: model.mediumImagePath,
        largeImagePath: model.largeImagePath,
        pricing: model.pricing != null
            ? ProductPriceEntityMapper.toEntity(model.pricing)
            : null,
        currencySymbol: model.currencySymbol,
        qtyOnHand: model.qtyOnHand,
        isConfigured: model.isConfigured,
        isFixedConfiguration: model.isFixedConfiguration,
        isActive: model.isActive,
        isHazardousGood: model.isHazardousGood,
        isDiscontinued: model.isDiscontinued,
        isSpecialOrder: model.isSpecialOrder,
        isGiftCard: model.isGiftCard,
        isBeingCompared: model.isBeingCompared,
        isSponsored: model.isSponsored,
        isSubscription: model.isSubscription,
        quoteRequired: model.quoteRequired,
        manufacturerItem: model.manufacturerItem,
        packDescription: model.packDescription,
        altText: model.altText,
        customerUnitOfMeasure: model.customerUnitOfMeasure,
        canBackOrder: model.canBackOrder,
        trackInventory: model.trackInventory,
        multipleSaleQty: model.multipleSaleQty,
        minimumOrderQty: model.minimumOrderQty,
        htmlContent: model.htmlContent,
        productCode: model.productCode,
        priceCode: model.priceCode,
        sku: model.sku,
        upcCode: model.upcCode,
        modelNumber: model.modelNumber,
        taxCode1: model.taxCode1,
        taxCode2: model.taxCode2,
        taxCategory: model.taxCategory,
        shippingClassification: model.shippingClassification,
        shippingLength: model.shippingLength,
        shippingWidth: model.shippingWidth,
        shippingHeight: model.shippingHeight,
        shippingWeight: model.shippingWeight,
        qtyPerShippingPackage: model.qtyPerShippingPackage,
        shippingAmountOverride: model.shippingAmountOverride,
        handlingAmountOverride: model.handlingAmountOverride,
        metaDescription: model.metaDescription,
        metaKeywords: model.metaKeywords,
        pageTitle: model.pageTitle,
        allowAnyGiftCardAmount: model.allowAnyGiftCardAmount,
        sortOrder: model.sortOrder,
        hasMsds: model.hasMsds,
        unspsc: model.unspsc,
        roundingRule: model.roundingRule,
        vendorNumber: model.vendorNumber,
        configurationDto: model.configurationDto != null
            ? LegacyConfigurationEntityMapper().toEntity(model.configurationDto)
            : null,
        unitOfMeasure: model.unitOfMeasure,
        unitOfMeasureDisplay: model.unitOfMeasureDisplay,
        unitOfMeasureDescription: model.unitOfMeasureDescription,
        selectedUnitOfMeasure: model.selectedUnitOfMeasure,
        selectedUnitOfMeasureDisplay: model.selectedUnitOfMeasureDisplay,
        productDetailUrl: model.productDetailUrl,
        canAddToCart: model.canAddToCart,
        allowedAddToCart: model.allowedAddToCart,
        canAddToWishlist: model.canAddToWishlist,
        canViewDetails: model.canViewDetails,
        canShowPrice: model.canShowPrice,
        canShowUnitOfMeasure: model.canShowUnitOfMeasure,
        canEnterQuantity: model.canEnterQuantity,
        canConfigure: model.canConfigure,
        isStyleProductParent: model.isStyleProductParent,
        styleParentId: model.styleParentId,
        requiresRealTimeInventory: model.requiresRealTimeInventory,
        numberInCart: model.numberInCart,
        qtyOrdered: model.qtyOrdered,
        availability: model.availability != null
            ? AvailabilityEntityMapper.toEntity(model.availability)
            : null,
        styleTraits: model.styleTraits
            ?.map((e) => StyleTraitEntityMapper.toEntity(e))
            .toList(),
        styledProducts: model.styledProducts
            ?.map((e) => StyledProductEntityMapper().toEntity(e))
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
        crossSells: model.crossSells
            ?.map((e) => ProductEntityMapper.toEntity(e))
            .toList(),
        accessories: model.accessories
            ?.map((e) => ProductEntityMapper.toEntity(e))
            .toList(),
        productUnitOfMeasures: model.productUnitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toEntity(e))
            .toList(),
        productImages: model.productImages
            ?.map((e) => ProductImageEntityMapper.toEntity(e))
            .toList(),
        score: model.score,
        searchBoost: model.searchBoost,
        salePriceLabel: model.salePriceLabel,
        productSubscription: model.productSubscription != null
            ? ProductSubscriptionEntityMapper.toEntity(
                model.productSubscription)
            : null,
        replacementProductId: model.replacementProductId,
        warehouses: model.warehouses
            ?.map((e) => InventoryWarehouseEntityMapper().toEntity(e))
            .toList(),
        brand: model.brand != null
            ? BrandEntityMapper.toEntity(model.brand)
            : null,
        productNumber: model.productNumber,
        customerProductNumber: model.customerProductNumber,
        productTitle: model.productTitle,
        canonicalUrl: model.canonicalUrl,
        unitListPrice: model.unitListPrice,
        unitListPriceDisplay: model.unitListPriceDisplay,
        priceFacet: model.priceFacet,
        imageAltText: model.imageAltText,
        configurationType: model.configurationType,
        isVariantParent: model.isVariantParent,
        variantTypeId: model.variantTypeId,
        cantBuy: model.cantBuy,
        productLine: model.productLine != null
            ? ProductLineEntityMapper.toEntity(model.productLine)
            : null,
        unitOfMeasures: model.unitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toEntity(e))
            .toList(),
        scoreExplanation: model.scoreExplanation != null
            ? ScoreExplanationEntityMapper.toEntity(model.scoreExplanation)
            : null,
        detail: model.detail != null
            ? ProductDetailEntityMapper.toEntity(model.detail)
            : null,
        content: model.content != null
            ? ProductContentEntityMapper().toEntity(model.content)
            : null,
        images: model.images
            ?.map((e) => ProductImageEntityMapper.toEntity(e))
            .toList(),
        variantTraits: model.variantTraits
            ?.map((e) => StyleTraitEntityMapper.toEntity(e))
            .toList(),
        childTraitValues: model.childTraitValues
            ?.map((e) => ChildTraitValueEntityMapper.toEntity(e))
            .toList(),
        properties: model.properties,
        allowZeroPricing: model.allowZeroPricing,
      );

  static Product toModel(ProductEntity entity) => Product(
        id: entity.id,
        orderLineId: entity.orderLineId,
        name: entity.name,
        customerName: entity.customerName,
        shortDescription: entity.shortDescription,
        erpNumber: entity.erpNumber,
        erpDescription: entity.erpDescription,
        urlSegment: entity.urlSegment,
        basicListPrice: entity.basicListPrice,
        basicSalePrice: entity.basicSalePrice,
        basicSaleStartDate: entity.basicSaleStartDate,
        basicSaleEndDate: entity.basicSaleEndDate,
        smallImagePath: entity.smallImagePath,
        mediumImagePath: entity.mediumImagePath,
        largeImagePath: entity.largeImagePath,
        pricing: entity.pricing != null
            ? ProductPriceEntityMapper.toModel(
                entity.pricing ?? ProductPriceEntity())
            : null,
        currencySymbol: entity.currencySymbol,
        qtyOnHand: entity.qtyOnHand,
        isConfigured: entity.isConfigured,
        isFixedConfiguration: entity.isFixedConfiguration,
        isActive: entity.isActive,
        isHazardousGood: entity.isHazardousGood,
        isDiscontinued: entity.isDiscontinued,
        isSpecialOrder: entity.isSpecialOrder,
        isGiftCard: entity.isGiftCard,
        isBeingCompared: entity.isBeingCompared,
        isSponsored: entity.isSponsored,
        isSubscription: entity.isSubscription,
        quoteRequired: entity.quoteRequired,
        manufacturerItem: entity.manufacturerItem,
        packDescription: entity.packDescription,
        altText: entity.altText,
        customerUnitOfMeasure: entity.customerUnitOfMeasure,
        canBackOrder: entity.canBackOrder,
        trackInventory: entity.trackInventory,
        multipleSaleQty: entity.multipleSaleQty,
        minimumOrderQty: entity.minimumOrderQty,
        htmlContent: entity.htmlContent,
        productCode: entity.productCode,
        priceCode: entity.priceCode,
        sku: entity.sku,
        upcCode: entity.upcCode,
        modelNumber: entity.modelNumber,
        taxCode1: entity.taxCode1,
        taxCode2: entity.taxCode2,
        taxCategory: entity.taxCategory,
        shippingClassification: entity.shippingClassification,
        shippingLength: entity.shippingLength,
        shippingWidth: entity.shippingWidth,
        shippingHeight: entity.shippingHeight,
        shippingWeight: entity.shippingWeight,
        qtyPerShippingPackage: entity.qtyPerShippingPackage,
        shippingAmountOverride: entity.shippingAmountOverride,
        handlingAmountOverride: entity.handlingAmountOverride,
        metaDescription: entity.metaDescription,
        metaKeywords: entity.metaKeywords,
        pageTitle: entity.pageTitle,
        allowAnyGiftCardAmount: entity.allowAnyGiftCardAmount,
        sortOrder: entity.sortOrder,
        hasMsds: entity.hasMsds,
        unspsc: entity.unspsc,
        roundingRule: entity.roundingRule,
        vendorNumber: entity.vendorNumber,
        configurationDto: entity.configurationDto != null
            ? LegacyConfigurationEntityMapper().toModel(entity.configurationDto)
            : null,
        unitOfMeasure: entity.unitOfMeasure,
        unitOfMeasureDisplay: entity.unitOfMeasureDisplay,
        unitOfMeasureDescription: entity.unitOfMeasureDescription,
        selectedUnitOfMeasure: entity.selectedUnitOfMeasure,
        selectedUnitOfMeasureDisplay: entity.selectedUnitOfMeasureDisplay,
        productDetailUrl: entity.productDetailUrl,
        canAddToCart: entity.canAddToCart,
        allowedAddToCart: entity.allowedAddToCart,
        canAddToWishlist: entity.canAddToWishlist,
        canViewDetails: entity.canViewDetails,
        canShowPrice: entity.canShowPrice,
        canShowUnitOfMeasure: entity.canShowUnitOfMeasure,
        canEnterQuantity: entity.canEnterQuantity,
        canConfigure: entity.canConfigure,
        isStyleProductParent: entity.isStyleProductParent,
        styleParentId: entity.styleParentId,
        requiresRealTimeInventory: entity.requiresRealTimeInventory,
        numberInCart: entity.numberInCart,
        qtyOrdered: entity.qtyOrdered,
        availability: entity.availability != null
            ? AvailabilityEntityMapper.toModel(
                entity.availability ?? AvailabilityEntity())
            : null,
        styleTraits: entity.styleTraits
            ?.map((e) => StyleTraitEntityMapper.toModel(e))
            .toList(),
        styledProducts: entity.styledProducts
            ?.map((e) => StyledProductEntityMapper().toModel(e))
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
        crossSells: entity.crossSells
            ?.map((e) => ProductEntityMapper.toModel(e))
            .toList(),
        accessories: entity.accessories
            ?.map((e) => ProductEntityMapper.toModel(e))
            .toList(),
        productUnitOfMeasures: entity.productUnitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toModel(e))
            .toList(),
        productImages: entity.productImages
            ?.map((e) => ProductImageEntityMapper.toModel(e))
            .toList(),
        score: entity.score,
        searchBoost: entity.searchBoost,
        salePriceLabel: entity.salePriceLabel,
        productSubscription: entity.productSubscription != null
            ? ProductSubscriptionEntityMapper.toModel(
                entity.productSubscription ?? ProductSubscriptionEntity())
            : null,
        replacementProductId: entity.replacementProductId,
        warehouses: entity.warehouses
            ?.map((e) => InventoryWarehouseEntityMapper().toModel(e))
            .toList(),
        brand: entity.brand != null
            ? BrandEntityMapper.toModel(entity.brand ?? BrandEntity())
            : null,
        productNumber: entity.productNumber,
        customerProductNumber: entity.customerProductNumber,
        productTitle: entity.productTitle,
        canonicalUrl: entity.canonicalUrl,
        unitListPrice: entity.unitListPrice,
        unitListPriceDisplay: entity.unitListPriceDisplay,
        priceFacet: entity.priceFacet,
        imageAltText: entity.imageAltText,
        configurationType: entity.configurationType,
        isVariantParent: entity.isVariantParent,
        variantTypeId: entity.variantTypeId,
        cantBuy: entity.cantBuy,
        productLine: entity.productLine != null
            ? ProductLineEntityMapper.toModel(
                entity.productLine ?? ProductLineEntity())
            : null,
        unitOfMeasures: entity.unitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toModel(
                e ?? ProductUnitOfMeasureEntity()))
            .toList(),
        scoreExplanation: entity.scoreExplanation != null
            ? ScoreExplanationEntityMapper.toModel(
                entity.scoreExplanation ?? ScoreExplanationEntity())
            : null,
        detail: entity.detail != null
            ? ProductDetailEntityMapper.toModel(
                entity.detail ?? ProductDetailEntity())
            : null,
        content: entity.content != null
            ? ProductContentEntityMapper()
                .toModel(entity.content ?? ProductContentEntity())
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
        allowZeroPricing: entity.allowZeroPricing,
      )..properties = entity.properties;
}
