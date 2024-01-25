import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/attribute_type_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/child_trait_value_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/document_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/inventory_warehouse_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/legacy_configuration_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_content_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_detail_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_image_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_unit_of_measure_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/score_explanation_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/specification_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/style_trait_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/styled_prodct_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductEntityMapper {
  ProductEntity toEntity(Product model) => ProductEntity(
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
            ? ProductPriceEntityMapper().toEntity(model.pricing!)
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
            ? LegacyConfigurationEntityMapper()
                .toEntity(model.configurationDto!)
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
            ? AvailabilityEntityMapper().toEntity(model.availability!)
            : null,
        styleTraits: model.styleTraits
            ?.map((e) => StyleTraitEntityMapper().toEntity(e))
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
            ?.map((e) => ProductEntityMapper().toEntity(e))
            .toList(),
        accessories: model.accessories
            ?.map((e) => ProductEntityMapper().toEntity(e))
            .toList(),
        productUnitOfMeasures: model.productUnitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper().toEntity(e))
            .toList(),
        productImages: model.productImages
            ?.map((e) => ProductImageEntityMapper().toEntity(e))
            .toList(),
        score: model.score,
        searchBoost: model.searchBoost,
        salePriceLabel: model.salePriceLabel,
        productSubscription: model.productSubscription != null
            ? ProductSubscriptionEntityMapper()
                .toEntity(model.productSubscription!)
            : null,
        replacementProductId: model.replacementProductId,
        warehouses: model.warehouses
            ?.map((e) => InventoryWarehouseEntityMapper().toEntity(e))
            .toList(),
        brand: model.brand != null
            ? BrandEntityMapper().toEntity(model.brand!)
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
            ? ProductLineEntityMapper().toEntity(model.productLine!)
            : null,
        unitOfMeasures: model.unitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper().toEntity(e))
            .toList(),
        scoreExplanation: model.scoreExplanation != null
            ? ScoreExplanationEntityMapper().toEntity(model.scoreExplanation!)
            : null,
        detail: model.detail != null
            ? ProductDetailEntityMapper().toEntity(model.detail!)
            : null,
        content: model.content != null
            ? ProductContentEntityMapper().toEntity(model.content!)
            : null,
        images: model.images
            ?.map((e) => ProductImageEntityMapper().toEntity(e))
            .toList(),
        variantTraits: model.variantTraits
            ?.map((e) => StyleTraitEntityMapper().toEntity(e))
            .toList(),
        childTraitValues: model.childTraitValues
            ?.map((e) => ChildTraitValueEntityMapper().toEntity(e))
            .toList(),
      );
}
