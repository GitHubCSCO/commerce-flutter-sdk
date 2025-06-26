import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_content_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_detail_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/score_explanation_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ProductEntityMapper', () {
    test('toEntity should convert model to entity with essential properties',
        () {
      // Arrange
      final model = Product(
        id: 'product123',
        name: 'Test Product',
        shortDescription: 'A test product description',
        erpNumber: 'ERP123',
        smallImagePath: '/images/small.jpg',
        mediumImagePath: '/images/medium.jpg',
        largeImagePath: '/images/large.jpg',
        pricing: ProductPrice(
          unitNetPrice: 19.99,
          unitListPrice: 24.99,
          unitNetPriceDisplay: '\$19.99',
          unitListPriceDisplay: '\$24.99',
        ),
        availability: Availability(
          message: 'In Stock',
          messageType: 1,
          requiresRealTimeInventory: false,
        ),
        qtyOnHand: 100,
        isActive: true,
        canAddToCart: true,
        canViewDetails: true,
        brand: Brand(
          id: 'brand1',
          name: 'Test Brand',
        ),
        scoreExplanation: ScoreExplanation(),
      )..properties = {'key1': 'value1'};

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.shortDescription, equals(model.shortDescription));
      expect(entity.erpNumber, equals(model.erpNumber));
      expect(entity.smallImagePath, equals(model.smallImagePath));
      expect(entity.mediumImagePath, equals(model.mediumImagePath));
      expect(entity.largeImagePath, equals(model.largeImagePath));

      // Check pricing
      expect(entity.pricing?.unitNetPrice, equals(model.pricing?.unitNetPrice));
      expect(
          entity.pricing?.unitListPrice, equals(model.pricing?.unitListPrice));
      expect(entity.pricing?.unitNetPriceDisplay,
          equals(model.pricing?.unitNetPriceDisplay));
      expect(entity.pricing?.unitListPriceDisplay,
          equals(model.pricing?.unitListPriceDisplay));

      // Check availability
      expect(entity.availability?.message, equals(model.availability?.message));
      expect(entity.availability?.messageType,
          equals(model.availability?.messageType));

      expect(entity.qtyOnHand, equals(model.qtyOnHand));
      expect(entity.isActive, equals(model.isActive));
      expect(entity.canAddToCart, equals(model.canAddToCart));
      expect(entity.canViewDetails, equals(model.canViewDetails));
      expect(entity.properties, equals(model.properties));

      // Check score explanation
      expect(entity.scoreExplanation?.totalBoost,
          equals(model.scoreExplanation?.totalBoost));
      expect(entity.scoreExplanation?.aggregateFieldScores?.length,
          equals(model.scoreExplanation?.aggregateFieldScores?.length));
      expect(entity.scoreExplanation?.detailedFieldScores?.length,
          equals(model.scoreExplanation?.detailedFieldScores?.length));

      // Check brand
      expect(entity.brand?.id, equals(model.brand?.id));
      expect(entity.brand?.name, equals(model.brand?.name));
    });

    test('toEntity should handle model with null nested objects', () {
      // Arrange
      final model = Product(
        id: 'product456',
        name: 'Basic Product',
        pricing: null,
        availability: null,
        brand: null,
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.pricing, isNull);
      expect(entity.availability, isNull);
      expect(entity.brand, isNull);
    });

    test('toEntity should handle model with empty collections', () {
      // Arrange
      final model = Product(
        id: 'product789',
        name: 'Collection Product',
        productUnitOfMeasures: [],
        productImages: [],
        specifications: [],
        styleTraits: [],
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.productUnitOfMeasures, isEmpty);
      expect(entity.productImages, isEmpty);
      expect(entity.specifications, isEmpty);
      expect(entity.styleTraits, isEmpty);
    });

    test('toEntity should convert collections properly', () {
      // Arrange
      final model = Product(
        id: 'product101',
        name: 'Product with Collections',
        productUnitOfMeasures: [
          ProductUnitOfMeasure(
            unitOfMeasure: 'EA',
            qtyPerBaseUnitOfMeasure: 1,
            roundingRule: 'round',
            isDefault: true,
            unitOfMeasureDisplay: 'Each',
          ),
          ProductUnitOfMeasure(
            unitOfMeasure: 'CS',
            qtyPerBaseUnitOfMeasure: 12,
            roundingRule: 'round',
            isDefault: false,
            unitOfMeasureDisplay: 'Case',
          ),
        ],
        accessories: [
          Product(
            id: 'acc1',
            name: 'Accessory 1',
          ),
        ],
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.productUnitOfMeasures?.length, equals(2));
      expect(entity.productUnitOfMeasures?[0].unitOfMeasure, equals('EA'));
      expect(entity.productUnitOfMeasures?[1].unitOfMeasure, equals('CS'));
      expect(entity.accessories?.length, equals(1));
      expect(entity.accessories?[0].id, equals('acc1'));
    });

    test('toEntity should map all string fields correctly', () {
      // Arrange
      final model = Product(
        id: 'product001',
        orderLineId: 'order123',
        name: 'Complete Product',
        customerName: 'John Doe',
        shortDescription: 'Short desc',
        erpNumber: 'ERP001',
        erpDescription: 'ERP Description',
        urlSegment: 'product-url',
        currencySymbol: '\$',
        manufacturerItem: 'MFG123',
        packDescription: 'Pack of 12',
        altText: 'Product image alt text',
        customerUnitOfMeasure: 'EA',
        htmlContent: '<p>HTML content</p>',
        productCode: 'PC001',
        priceCode: 'PRICE001',
        sku: 'SKU001',
        upcCode: '123456789012',
        modelNumber: 'MODEL001',
        taxCode1: 'TAX1',
        taxCode2: 'TAX2',
        taxCategory: 'TAXCAT',
        shippingClassification: 'SHIP001',
        shippingLength: '10',
        shippingWidth: '8',
        shippingHeight: '6',
        shippingWeight: '2.5',
        metaDescription: 'Meta description',
        metaKeywords: 'keyword1, keyword2',
        pageTitle: 'Product Page Title',
        unspsc: 'UNSPSC001',
        roundingRule: 'round',
        vendorNumber: 'VENDOR001',
        unitOfMeasure: 'EA',
        unitOfMeasureDisplay: 'Each',
        unitOfMeasureDescription: 'Each unit',
        selectedUnitOfMeasure: 'EA',
        selectedUnitOfMeasureDisplay: 'Each',
        productDetailUrl: '/product/detail',
        styleParentId: 'parent123',
        salePriceLabel: 'Sale Price',
        replacementProductId: 'replacement123',
        productNumber: 'PN001',
        customerProductNumber: 'CPN001',
        productTitle: 'Product Title',
        canonicalUrl: '/canonical-url',
        unitListPriceDisplay: '\$24.99',
        imageAltText: 'Image alt text',
        configurationType: 'CONFIG_TYPE',
        variantTypeId: 'variant123',
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals('product001'));
      expect(entity.orderLineId, equals('order123'));
      expect(entity.name, equals('Complete Product'));
      expect(entity.customerName, equals('John Doe'));
      expect(entity.shortDescription, equals('Short desc'));
      expect(entity.erpNumber, equals('ERP001'));
      expect(entity.erpDescription, equals('ERP Description'));
      expect(entity.urlSegment, equals('product-url'));
      expect(entity.currencySymbol, equals('\$'));
      expect(entity.manufacturerItem, equals('MFG123'));
      expect(entity.packDescription, equals('Pack of 12'));
      expect(entity.altText, equals('Product image alt text'));
      expect(entity.customerUnitOfMeasure, equals('EA'));
      expect(entity.htmlContent, equals('<p>HTML content</p>'));
      expect(entity.productCode, equals('PC001'));
      expect(entity.priceCode, equals('PRICE001'));
      expect(entity.sku, equals('SKU001'));
      expect(entity.upcCode, equals('123456789012'));
      expect(entity.modelNumber, equals('MODEL001'));
      expect(entity.taxCode1, equals('TAX1'));
      expect(entity.taxCode2, equals('TAX2'));
      expect(entity.taxCategory, equals('TAXCAT'));
      expect(entity.shippingClassification, equals('SHIP001'));
      expect(entity.shippingLength, equals('10'));
      expect(entity.shippingWidth, equals('8'));
      expect(entity.shippingHeight, equals('6'));
      expect(entity.shippingWeight, equals('2.5'));
      expect(entity.metaDescription, equals('Meta description'));
      expect(entity.metaKeywords, equals('keyword1, keyword2'));
      expect(entity.pageTitle, equals('Product Page Title'));
      expect(entity.unspsc, equals('UNSPSC001'));
      expect(entity.roundingRule, equals('round'));
      expect(entity.vendorNumber, equals('VENDOR001'));
      expect(entity.unitOfMeasure, equals('EA'));
      expect(entity.unitOfMeasureDisplay, equals('Each'));
      expect(entity.unitOfMeasureDescription, equals('Each unit'));
      expect(entity.selectedUnitOfMeasure, equals('EA'));
      expect(entity.selectedUnitOfMeasureDisplay, equals('Each'));
      expect(entity.productDetailUrl, equals('/product/detail'));
      expect(entity.styleParentId, equals('parent123'));
      expect(entity.salePriceLabel, equals('Sale Price'));
      expect(entity.replacementProductId, equals('replacement123'));
      expect(entity.productNumber, equals('PN001'));
      expect(entity.customerProductNumber, equals('CPN001'));
      expect(entity.productTitle, equals('Product Title'));
      expect(entity.canonicalUrl, equals('/canonical-url'));
      expect(entity.unitListPriceDisplay, equals('\$24.99'));
      expect(entity.imageAltText, equals('Image alt text'));
      expect(entity.configurationType, equals('CONFIG_TYPE'));
      expect(entity.variantTypeId, equals('variant123'));
    });

    test('toEntity should map all numeric fields correctly', () {
      // Arrange
      final model = Product(
        id: 'product002',
        basicListPrice: 29.99,
        basicSalePrice: 24.99,
        qtyOnHand: 150,
        multipleSaleQty: 5,
        minimumOrderQty: 2,
        qtyPerShippingPackage: 24,
        shippingAmountOverride: 15.50,
        handlingAmountOverride: 3.25,
        sortOrder: 10,
        numberInCart: 3,
        qtyOrdered: 12,
        score: 95.5,
        searchBoost: 2,
        unitListPrice: 34.99,
        priceFacet: 3,
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.basicListPrice, equals(29.99));
      expect(entity.basicSalePrice, equals(24.99));
      expect(entity.qtyOnHand, equals(150));
      expect(entity.multipleSaleQty, equals(5));
      expect(entity.minimumOrderQty, equals(2));
      expect(entity.qtyPerShippingPackage, equals(24));
      expect(entity.shippingAmountOverride, equals(15.50));
      expect(entity.handlingAmountOverride, equals(3.25));
      expect(entity.sortOrder, equals(10));
      expect(entity.numberInCart, equals(3));
      expect(entity.qtyOrdered, equals(12));
      expect(entity.score, equals(95.5));
      expect(entity.searchBoost, equals(2));
      expect(entity.unitListPrice, equals(34.99));
      expect(entity.priceFacet, equals(3));
    });

    test('toEntity should map all boolean fields correctly', () {
      // Arrange
      final model = Product(
        id: 'product003',
        isConfigured: true,
        isFixedConfiguration: false,
        isActive: true,
        isHazardousGood: false,
        isDiscontinued: true,
        isSpecialOrder: false,
        isGiftCard: true,
        isBeingCompared: false,
        isSponsored: true,
        isSubscription: false,
        quoteRequired: true,
        canBackOrder: false,
        trackInventory: true,
        allowAnyGiftCardAmount: false,
        hasMsds: true,
        canAddToCart: false,
        allowedAddToCart: true,
        canAddToWishlist: false,
        canViewDetails: true,
        canShowPrice: false,
        canShowUnitOfMeasure: true,
        canEnterQuantity: false,
        canConfigure: true,
        isStyleProductParent: false,
        requiresRealTimeInventory: true,
        isVariantParent: false,
        cantBuy: true,
        allowZeroPricing: false,
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.isConfigured, isTrue);
      expect(entity.isFixedConfiguration, isFalse);
      expect(entity.isActive, isTrue);
      expect(entity.isHazardousGood, isFalse);
      expect(entity.isDiscontinued, isTrue);
      expect(entity.isSpecialOrder, isFalse);
      expect(entity.isGiftCard, isTrue);
      expect(entity.isBeingCompared, isFalse);
      expect(entity.isSponsored, isTrue);
      expect(entity.isSubscription, isFalse);
      expect(entity.quoteRequired, isTrue);
      expect(entity.canBackOrder, isFalse);
      expect(entity.trackInventory, isTrue);
      expect(entity.allowAnyGiftCardAmount, isFalse);
      expect(entity.hasMsds, isTrue);
      expect(entity.canAddToCart, isFalse);
      expect(entity.allowedAddToCart, isTrue);
      expect(entity.canAddToWishlist, isFalse);
      expect(entity.canViewDetails, isTrue);
      expect(entity.canShowPrice, isFalse);
      expect(entity.canShowUnitOfMeasure, isTrue);
      expect(entity.canEnterQuantity, isFalse);
      expect(entity.canConfigure, isTrue);
      expect(entity.isStyleProductParent, isFalse);
      expect(entity.requiresRealTimeInventory, isTrue);
      expect(entity.isVariantParent, isFalse);
      expect(entity.cantBuy, isTrue);
      expect(entity.allowZeroPricing, isFalse);
    });

    test('toEntity should map date fields correctly', () {
      // Arrange
      final startDate = DateTime(2023, 12, 1);
      final endDate = DateTime(2023, 12, 31);
      final model = Product(
        id: 'product004',
        basicSaleStartDate: startDate,
        basicSaleEndDate: endDate,
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.basicSaleStartDate, equals(startDate));
      expect(entity.basicSaleEndDate, equals(endDate));
    });

    test('toEntity should handle complex nested objects', () {
      // Arrange
      final model = Product(
        id: 'product005',
        configurationDto: LegacyConfiguration(
          sections: [
            ConfigSection(
              id: 'section1',
              sectionName: 'Section 1',
              sortOrder: 1,
              options: [
                ConfigSectionOption(
                  id: 'option1',
                  name: 'Option 1',
                  sortOrder: 1,
                  price: 10.0,
                  description: 'Option description',
                  productId: 'prod001',
                ),
              ],
            ),
          ],
        ),
        productLine: ProductLine(
          id: 'line1',
          name: 'Product Line 1',
          count: 5,
          selected: true,
        ),
        detail: ProductDetail(
          name: 'Detailed Product',
          modelNumber: 'MODEL123',
          sku: 'DETAIL_SKU',
          sortOrder: 1,
        ),
        content: ProductContent(
          htmlContent: '<h1>Product Content</h1>',
          metaDescription: 'Content meta description',
          pageTitle: 'Content Page Title',
          metaKeywords: 'content, keywords',
          openGraphImage: '/og-image.jpg',
          openGraphTitle: 'OG Title',
          openGraphUrl: '/og-url',
        ),
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.configurationDto, isNotNull);
      expect(entity.configurationDto?.sections?.length, equals(1));
      expect(entity.configurationDto?.sections?[0].id, equals('section1'));

      expect(entity.productLine, isNotNull);
      expect(entity.productLine?.id, equals('line1'));
      expect(entity.productLine?.name, equals('Product Line 1'));

      expect(entity.detail, isNotNull);
      expect(entity.detail?.name, equals('Detailed Product'));

      expect(entity.content, isNotNull);
      expect(entity.content?.htmlContent, equals('<h1>Product Content</h1>'));
    });

    test('toEntity should handle all collection types with populated data', () {
      // Arrange
      final model = Product(
        id: 'collection_test',
        name: 'Collection Test Product',
        styleTraits: [
          StyleTrait(
            id: 'trait1',
            name: 'Color',
            nameDisplay: 'Color',
            unselectedValue: 'Select Color',
            styleValues: [
              StyleValue(
                id: 'value1',
                value: 'Red',
                valueDisplay: 'Red',
                sortOrder: 1,
              ),
            ],
          ),
        ],
        styledProducts: [
          StyledProduct(
            productId: 'styled1',
            name: 'Styled Product 1',
            styleValues: [
              StyleValue(
                id: 'sv1',
                value: 'Blue',
                valueDisplay: 'Blue',
              ),
            ],
          ),
        ],
        attributeTypes: [
          AttributeType(
            id: 'attr1',
            name: 'Material',
            label: 'Material Type',
            isActive: true,
          ),
        ],
        documents: [
          Document(
            id: 'doc1',
            name: 'Product Manual',
            documentType: 'PDF',
          ),
        ],
        specifications: [
          Specification(
            specificationId: 'spec1',
            name: 'Dimensions',
            value: '10x5x3 inches',
            htmlContent: '<p>Detailed dimensions</p>',
          ),
        ],
        crossSells: [
          Product(
            id: 'cross1',
            name: 'Cross Sell Product',
          ),
        ],
        warehouses: [
          InventoryWarehouse(
            name: 'Main Warehouse',
            description: 'Primary storage',
            qty: 100,
          ),
        ],
        unitOfMeasures: [
          ProductUnitOfMeasure(
            unitOfMeasure: 'KG',
            unitOfMeasureDisplay: 'Kilogram',
            qtyPerBaseUnitOfMeasure: 1.0,
            isDefault: false,
          ),
        ],
        images: [
          ProductImage(
            id: 'img1',
            name: 'Product Image 1',
            smallImagePath: '/small1.jpg',
            mediumImagePath: '/medium1.jpg',
            largeImagePath: '/large1.jpg',
            altText: 'Product image',
            sortOrder: 1,
          ),
        ],
        variantTraits: [
          StyleTrait(
            id: 'variant1',
            name: 'Size',
            nameDisplay: 'Size',
            unselectedValue: 'Select Size',
          ),
        ],
        childTraitValues: [
          ChildTraitValue(
            id: 'child1',
            value: 'Large',
            valueDisplay: 'Large',
          ),
        ],
        productSubscription: ProductSubscriptionDto(
          subscriptionAllMonths: true,
          subscriptionCyclePeriod: 'monthly',
          subscriptionTotalCycles: 12,
          subscriptionPeriodsPerCycle: 1,
          subscriptionFixedPrice: true,
        ),
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.styleTraits, isNotNull);
      expect(entity.styleTraits?.length, equals(1));
      expect(entity.styleTraits?[0].id, equals('trait1'));
      expect(entity.styleTraits?[0].name, equals('Color'));

      expect(entity.styledProducts, isNotNull);
      expect(entity.styledProducts?.length, equals(1));
      expect(entity.styledProducts?[0].productId, equals('styled1'));

      expect(entity.attributeTypes, isNotNull);
      expect(entity.attributeTypes?.length, equals(1));
      expect(entity.attributeTypes?[0].id, equals('attr1'));

      expect(entity.documents, isNotNull);
      expect(entity.documents?.length, equals(1));
      expect(entity.documents?[0].id, equals('doc1'));

      expect(entity.specifications, isNotNull);
      expect(entity.specifications?.length, equals(1));
      expect(entity.specifications?[0].specificationId, equals('spec1'));

      expect(entity.crossSells, isNotNull);
      expect(entity.crossSells?.length, equals(1));
      expect(entity.crossSells?[0].id, equals('cross1'));

      expect(entity.warehouses, isNotNull);
      expect(entity.warehouses?.length, equals(1));
      expect(entity.warehouses?[0].name, equals('Main Warehouse'));

      expect(entity.unitOfMeasures, isNotNull);
      expect(entity.unitOfMeasures?.length, equals(1));
      expect(entity.unitOfMeasures?[0].unitOfMeasure, equals('KG'));

      expect(entity.images, isNotNull);
      expect(entity.images?.length, equals(1));
      expect(entity.images?[0].id, equals('img1'));

      expect(entity.variantTraits, isNotNull);
      expect(entity.variantTraits?.length, equals(1));
      expect(entity.variantTraits?[0].id, equals('variant1'));

      expect(entity.childTraitValues, isNotNull);
      expect(entity.childTraitValues?.length, equals(1));
      expect(entity.childTraitValues?[0].id, equals('child1'));

      expect(entity.productSubscription, isNotNull);
      expect(entity.productSubscription?.subscriptionAllMonths, isTrue);
    });

    test('toEntity should handle mixed null and populated collections', () {
      // Arrange
      final model = Product(
        id: 'mixed_collections_test',
        name: 'Mixed Collections Test',
        styleTraits: [
          StyleTrait(id: 'trait1', name: 'Color'),
        ],
        styledProducts: null,
        attributeTypes: [],
        documents: [
          Document(id: 'doc1', name: 'Manual'),
          Document(id: 'doc2', name: 'Warranty'),
        ],
        specifications: null,
        crossSells: [],
        warehouses: [
          InventoryWarehouse(name: 'Warehouse1', qty: 10),
        ],
        unitOfMeasures: null,
        images: [],
        variantTraits: [
          StyleTrait(id: 'variant1', name: 'Size'),
          StyleTrait(id: 'variant2', name: 'Weight'),
        ],
        childTraitValues: null,
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.styleTraits?.length, equals(1));
      expect(entity.styledProducts, isNull);
      expect(entity.attributeTypes, isEmpty);
      expect(entity.documents?.length, equals(2));
      expect(entity.specifications, isNull);
      expect(entity.crossSells, isEmpty);
      expect(entity.warehouses?.length, equals(1));
      expect(entity.unitOfMeasures, isNull);
      expect(entity.images, isEmpty);
      expect(entity.variantTraits?.length, equals(2));
      expect(entity.childTraitValues, isNull);
    });

    test('toModel should convert entity to model with essential properties',
        () {
      // Arrange
      final entity = ProductEntity(
        id: 'product123',
        name: 'Test Product',
        shortDescription: 'A test product description',
        erpNumber: 'ERP123',
        smallImagePath: '/images/small.jpg',
        mediumImagePath: '/images/medium.jpg',
        largeImagePath: '/images/large.jpg',
        pricing: const ProductPriceEntity(
          unitNetPrice: 19.99,
          unitListPrice: 24.99,
          unitNetPriceDisplay: '\$19.99',
          unitListPriceDisplay: '\$24.99',
        ),
        availability: const AvailabilityEntity(
          message: 'In Stock',
          messageType: 1,
          requiresRealTimeInventory: false,
        ),
        qtyOnHand: 100,
        isActive: true,
        canAddToCart: true,
        canViewDetails: true,
        brand: const BrandEntity(
          id: 'brand1',
          name: 'Test Brand',
        ),
        configurationDto: const LegacyConfigurationEntity(
          sections: [
            ConfigSectionEntity(
              id: 'section1',
              sectionName: 'Section 1',
              sortOrder: 1,
            ),
          ],
          hasDefaults: true,
          isKit: false,
        ),
        unitOfMeasures: const [
          ProductUnitOfMeasureEntity(
            unitOfMeasure: 'EA',
            qtyPerBaseUnitOfMeasure: 1,
            roundingRule: 'round',
          ),
        ],
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.shortDescription, equals(entity.shortDescription));
      expect(model.erpNumber, equals(entity.erpNumber));
      expect(model.smallImagePath, equals(entity.smallImagePath));
      expect(model.mediumImagePath, equals(entity.mediumImagePath));
      expect(model.largeImagePath, equals(entity.largeImagePath));

      // Check pricing
      expect(model.pricing?.unitNetPrice, equals(entity.pricing?.unitNetPrice));
      expect(
          model.pricing?.unitListPrice, equals(entity.pricing?.unitListPrice));
      expect(model.pricing?.unitNetPriceDisplay,
          equals(entity.pricing?.unitNetPriceDisplay));
      expect(model.pricing?.unitListPriceDisplay,
          equals(entity.pricing?.unitListPriceDisplay));

      // Check availability
      expect(model.availability?.message, equals(entity.availability?.message));
      expect(model.availability?.messageType,
          equals(entity.availability?.messageType));

      expect(model.qtyOnHand, equals(entity.qtyOnHand));
      expect(model.isActive, equals(entity.isActive));
      expect(model.canAddToCart, equals(entity.canAddToCart));
      expect(model.canViewDetails, equals(entity.canViewDetails));
      expect(model.properties, equals(entity.properties));

      // Check configuration
      expect(model.configurationDto, isNotNull);
      expect(model.configurationDto?.hasDefaults,
          equals(entity.configurationDto?.hasDefaults));
      expect(model.configurationDto?.isKit,
          equals(entity.configurationDto?.isKit));
      expect(model.configurationDto?.sections?.length,
          equals(entity.configurationDto?.sections?.length));
      expect(model.configurationDto?.sections?[0].id,
          equals(entity.configurationDto?.sections?[0].id));
      expect(model.configurationDto?.sections?[0].sectionName,
          equals(entity.configurationDto?.sections?[0].sectionName));
      expect(model.configurationDto?.sections?[0].sortOrder,
          equals(entity.configurationDto?.sections?[0].sortOrder));

      // Check unit of measures
      expect(
          model.unitOfMeasures?.length, equals(entity.unitOfMeasures?.length));
      expect(model.unitOfMeasures?[0].unitOfMeasure,
          equals(entity.unitOfMeasures?[0].unitOfMeasure));
      expect(model.unitOfMeasures?[0].qtyPerBaseUnitOfMeasure,
          equals(entity.unitOfMeasures?[0].qtyPerBaseUnitOfMeasure));
      expect(model.unitOfMeasures?[0].roundingRule,
          equals(entity.unitOfMeasures?[0].roundingRule));

      // Check brand
      expect(model.brand?.id, equals(entity.brand?.id));
      expect(model.brand?.name, equals(entity.brand?.name));
    });

    test('toModel should handle entity with null nested objects', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product456',
        name: 'Basic Product',
        pricing: null,
        availability: null,
        brand: null,
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.pricing, isNull);
      expect(model.availability, isNull);
      expect(model.brand, isNull);
    });

    test('toModel should handle entity with empty collections', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product789',
        name: 'Collection Product',
        productUnitOfMeasures: const [],
        productImages: const [],
        specifications: const [],
        styleTraits: const [],
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.productUnitOfMeasures, isEmpty);
      expect(model.productImages, isEmpty);
      expect(model.specifications, isEmpty);
      expect(model.styleTraits, isEmpty);
    });

    test('toModel should convert collections properly', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product101',
        name: 'Product with Collections',
        productUnitOfMeasures: const [
          ProductUnitOfMeasureEntity(
            unitOfMeasure: 'EA',
            qtyPerBaseUnitOfMeasure: 1,
            roundingRule: 'round',
            isDefault: true,
            unitOfMeasureDisplay: 'Each',
          ),
          ProductUnitOfMeasureEntity(
            unitOfMeasure: 'CS',
            qtyPerBaseUnitOfMeasure: 12,
            roundingRule: 'round',
            isDefault: false,
            unitOfMeasureDisplay: 'Case',
          ),
        ],
        accessories: [
          ProductEntity(
            id: 'acc1',
            name: 'Accessory 1',
          ),
        ],
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.productUnitOfMeasures?.length, equals(2));
      expect(model.productUnitOfMeasures?[0].unitOfMeasure, equals('EA'));
      expect(model.productUnitOfMeasures?[1].unitOfMeasure, equals('CS'));
      expect(model.accessories?.length, equals(1));
      expect(model.accessories?[0].id, equals('acc1'));
    });

    test('toModel should handle null collections gracefully', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product006',
        name: 'Null Collections Product',
        productUnitOfMeasures: null,
        productImages: null,
        specifications: null,
        styleTraits: null,
        crossSells: null,
        accessories: null,
        styledProducts: null,
        attributeTypes: null,
        documents: null,
        warehouses: null,
        unitOfMeasures: null,
        images: null,
        variantTraits: null,
        childTraitValues: null,
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.productUnitOfMeasures, isNull);
      expect(model.productImages, isNull);
      expect(model.specifications, isNull);
      expect(model.styleTraits, isNull);
      expect(model.crossSells, isNull);
      expect(model.accessories, isNull);
      expect(model.styledProducts, isNull);
      expect(model.attributeTypes, isNull);
      expect(model.documents, isNull);
      expect(model.warehouses, isNull);
      expect(model.unitOfMeasures, isNull);
      expect(model.images, isNull);
      expect(model.variantTraits, isNull);
      expect(model.childTraitValues, isNull);
    });

    test('toModel should handle fallback values for null nested objects', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product007',
        name: 'Fallback Test Product',
        pricing: const ProductPriceEntity(),
        availability: const AvailabilityEntity(),
        brand: const BrandEntity(),
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert - These should not be null due to fallback values in mapper
      expect(model.pricing, isNotNull);
      expect(model.availability, isNotNull);
      expect(model.brand, isNotNull);
    });

    test('toModel should handle null entities in collections with fallback',
        () {
      // Arrange
      final entity = ProductEntity(
        id: 'product008',
        name: 'Fallback Collections Product',
        unitOfMeasures: const [
          ProductUnitOfMeasureEntity(unitOfMeasure: 'EA'),
          // This tests the fallback in the mapper: e ?? ProductUnitOfMeasureEntity()
        ],
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.unitOfMeasures, isNotNull);
      expect(model.unitOfMeasures?.length, equals(1));
      expect(model.unitOfMeasures?[0].unitOfMeasure, equals('EA'));
    });

    test('roundtrip conversion preserves all essential data', () {
      // Arrange
      final originalModel = Product(
        id: 'product123',
        name: 'Test Product',
        shortDescription: 'A test product description',
        erpNumber: 'ERP123',
        smallImagePath: '/images/small.jpg',
        pricing: ProductPrice(
          unitNetPrice: 19.99,
          unitListPrice: 24.99,
          unitNetPriceDisplay: '\$19.99',
        ),
        availability: Availability(
          message: 'In Stock',
          messageType: 1,
        ),
        isActive: true,
        canAddToCart: true,
        productUnitOfMeasures: [
          ProductUnitOfMeasure(
            unitOfMeasure: 'EA',
            unitOfMeasureDisplay: 'Each',
            isDefault: true,
          ),
        ],
        brand: Brand(
          id: 'brand1',
          name: 'Test Brand',
        ),
      );

      // Act
      final entity = ProductEntityMapper.toEntity(originalModel);
      final resultModel = ProductEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.name, equals(originalModel.name));
      expect(
          resultModel.shortDescription, equals(originalModel.shortDescription));
      expect(resultModel.erpNumber, equals(originalModel.erpNumber));
      expect(resultModel.smallImagePath, equals(originalModel.smallImagePath));

      // Check pricing
      expect(resultModel.pricing?.unitNetPrice,
          equals(originalModel.pricing?.unitNetPrice));
      expect(resultModel.pricing?.unitListPrice,
          equals(originalModel.pricing?.unitListPrice));
      expect(resultModel.pricing?.unitNetPriceDisplay,
          equals(originalModel.pricing?.unitNetPriceDisplay));

      // Check availability
      expect(resultModel.availability?.message,
          equals(originalModel.availability?.message));
      expect(resultModel.availability?.messageType,
          equals(originalModel.availability?.messageType));

      expect(resultModel.isActive, equals(originalModel.isActive));
      expect(resultModel.canAddToCart, equals(originalModel.canAddToCart));

      // Check product unit of measures
      expect(resultModel.productUnitOfMeasures?.length,
          equals(originalModel.productUnitOfMeasures?.length));
      expect(resultModel.productUnitOfMeasures?[0].unitOfMeasure,
          equals(originalModel.productUnitOfMeasures?[0].unitOfMeasure));

      // Check brand
      expect(resultModel.brand?.id, equals(originalModel.brand?.id));
      expect(resultModel.brand?.name, equals(originalModel.brand?.name));

      // Check properties
      expect(resultModel.properties, equals(originalModel.properties));
    });

    test('roundtrip conversion with all collections populated', () {
      // Arrange
      final originalModel = Product(
        id: 'roundtrip_collections',
        name: 'Roundtrip Collections Test',
        styleTraits: [
          StyleTrait(id: 'rt_trait1', name: 'Color', nameDisplay: 'Color'),
        ],
        styledProducts: [
          StyledProduct(productId: 'rt_styled1', name: 'Styled Product'),
        ],
        attributeTypes: [
          AttributeType(id: 'rt_attr1', name: 'Material', isActive: true),
        ],
        documents: [
          Document(id: 'rt_doc1', name: 'Manual', documentType: 'PDF'),
        ],
        specifications: [
          Specification(
              specificationId: 'rt_spec1', name: 'Weight', value: '1.5kg'),
        ],
        crossSells: [
          Product(id: 'rt_cross1', name: 'Cross Sell Product'),
        ],
        warehouses: [
          InventoryWarehouse(name: 'RT Warehouse', qty: 25),
        ],
        unitOfMeasures: [
          ProductUnitOfMeasure(unitOfMeasure: 'PCS', isDefault: true),
        ],
        images: [
          ProductImage(id: 'rt_img1', name: 'RT Image', sortOrder: 1),
        ],
        variantTraits: [
          StyleTrait(id: 'rt_variant1', name: 'Size'),
        ],
        childTraitValues: [
          ChildTraitValue(id: 'rt_child1', value: 'Large'),
        ],
        productSubscription: ProductSubscriptionDto(
          subscriptionCyclePeriod: 'monthly',
          subscriptionTotalCycles: 12,
        ),
      );

      // Act
      final entity = ProductEntityMapper.toEntity(originalModel);
      final resultModel = ProductEntityMapper.toModel(entity);

      // Assert - Test all collections are preserved
      expect(resultModel.styleTraits?.length,
          equals(originalModel.styleTraits?.length));
      expect(resultModel.styleTraits?[0].id,
          equals(originalModel.styleTraits?[0].id));

      expect(resultModel.styledProducts?.length,
          equals(originalModel.styledProducts?.length));
      expect(resultModel.styledProducts?[0].productId,
          equals(originalModel.styledProducts?[0].productId));

      expect(resultModel.attributeTypes?.length,
          equals(originalModel.attributeTypes?.length));
      expect(resultModel.attributeTypes?[0].id,
          equals(originalModel.attributeTypes?[0].id));

      expect(resultModel.documents?.length,
          equals(originalModel.documents?.length));
      expect(
          resultModel.documents?[0].id, equals(originalModel.documents?[0].id));

      expect(resultModel.specifications?.length,
          equals(originalModel.specifications?.length));
      expect(resultModel.specifications?[0].specificationId,
          equals(originalModel.specifications?[0].specificationId));

      expect(resultModel.crossSells?.length,
          equals(originalModel.crossSells?.length));
      expect(resultModel.crossSells?[0].id,
          equals(originalModel.crossSells?[0].id));

      expect(resultModel.warehouses?.length,
          equals(originalModel.warehouses?.length));
      expect(resultModel.warehouses?[0].name,
          equals(originalModel.warehouses?[0].name));

      expect(resultModel.unitOfMeasures?.length,
          equals(originalModel.unitOfMeasures?.length));
      expect(resultModel.unitOfMeasures?[0].unitOfMeasure,
          equals(originalModel.unitOfMeasures?[0].unitOfMeasure));

      expect(resultModel.images?.length, equals(originalModel.images?.length));
      expect(resultModel.images?[0].id, equals(originalModel.images?[0].id));

      expect(resultModel.variantTraits?.length,
          equals(originalModel.variantTraits?.length));
      expect(resultModel.variantTraits?[0].id,
          equals(originalModel.variantTraits?[0].id));

      expect(resultModel.childTraitValues?.length,
          equals(originalModel.childTraitValues?.length));
      expect(resultModel.childTraitValues?[0].id,
          equals(originalModel.childTraitValues?[0].id));

      expect(resultModel.productSubscription?.subscriptionCyclePeriod,
          equals(originalModel.productSubscription?.subscriptionCyclePeriod));
      expect(resultModel.productSubscription?.subscriptionTotalCycles,
          equals(originalModel.productSubscription?.subscriptionTotalCycles));
    });

    test('toModel should handle minimal non-null nested objects correctly', () {
      // Arrange - This test specifically targets the fallback scenarios in toModel
      final entity = ProductEntity(
        id: 'minimal_nested_test',
        name: 'Minimal Nested Test',
        pricing: const ProductPriceEntity(), // Non-null but minimal
        availability: const AvailabilityEntity(), // Non-null but minimal
        brand: const BrandEntity(), // Non-null but minimal
        productLine: const ProductLineEntity(), // Non-null but minimal
        scoreExplanation:
            const ScoreExplanationEntity(), // Non-null but minimal
        detail: const ProductDetailEntity(), // Non-null but minimal
        content: const ProductContentEntity(), // Non-null but minimal
        productSubscription:
            ProductSubscriptionEntity(), // Non-null but minimal
        unitOfMeasures: const [
          ProductUnitOfMeasureEntity(), // Non-null but minimal
        ],
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert - Verify all nested objects are properly converted
      expect(model.pricing, isNotNull);
      expect(model.availability, isNotNull);
      expect(model.brand, isNotNull);
      expect(model.productLine, isNotNull);
      expect(model.scoreExplanation, isNotNull);
      expect(model.detail, isNotNull);
      expect(model.content, isNotNull);
      expect(model.productSubscription, isNotNull);
      expect(model.unitOfMeasures, isNotNull);
      expect(model.unitOfMeasures?.length, equals(1));
    });
  });
}
