import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_content_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_detail_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_line_entity.dart';
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
        productTitle: 'Test Product',
        productNumber: 'ERP123',
        smallImagePath: '/images/small.jpg',
        mediumImagePath: '/images/medium.jpg',
        largeImagePath: '/images/large.jpg',
        canAddToCart: true,
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
      expect(entity.productTitle, equals(model.productTitle));
      expect(entity.productNumber, equals(model.productNumber));
      expect(entity.smallImagePath, equals(model.smallImagePath));
      expect(entity.mediumImagePath, equals(model.mediumImagePath));
      expect(entity.largeImagePath, equals(model.largeImagePath));
      expect(entity.canAddToCart, equals(model.canAddToCart));
      expect(entity.properties, equals(model.properties));

      // Check score explanation
      expect(entity.scoreExplanation?.totalBoost,
          equals(model.scoreExplanation?.totalBoost));

      // Check brand
      expect(entity.brand?.id, equals(model.brand?.id));
      expect(entity.brand?.name, equals(model.brand?.name));
    });

    test('toEntity should handle model with null nested objects', () {
      // Arrange
      final model = Product(
        id: 'product456',
        productTitle: 'Basic Product',
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.productTitle, equals(model.productTitle));
      expect(entity.pricing, isNull);
      expect(entity.availability, isNull);
      expect(entity.brand, isNull);
    });

    test('toEntity should handle model with empty collections', () {
      // Arrange
      final model = Product(
        id: 'product789',
        productTitle: 'Collection Product',
        unitOfMeasures: [],
        images: [],
        specifications: [],
        variantTraits: [],
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.productUnitOfMeasures, isEmpty);
      expect(entity.productImages, isEmpty);
      expect(entity.specifications, isEmpty);
      expect(entity.variantTraits, isEmpty);
    });

    test('toEntity should convert collections properly', () {
      // Arrange
      final model = Product(
        id: 'product101',
        productTitle: 'Product with Collections',
        unitOfMeasures: [
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
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.productUnitOfMeasures?.length, equals(2));
      expect(entity.productUnitOfMeasures?[0].unitOfMeasure, equals('EA'));
      expect(entity.productUnitOfMeasures?[1].unitOfMeasure, equals('CS'));
    });

    test('toEntity should map all string fields correctly', () {
      // Arrange
      final model = Product(
        id: 'product001',
        urlSegment: 'product-url',
        manufacturerItem: 'MFG123',
        packDescription: 'Pack of 12',
        customerUnitOfMeasure: 'EA',
        salePriceLabel: 'Sale Price',
        productNumber: 'PN001',
        customerProductNumber: 'CPN001',
        productTitle: 'Product Title',
        canonicalUrl: '/canonical-url',
        unitListPriceDisplay: '\$24.99',
        imageAltText: 'Image alt text',
        configurationType: 'CONFIG_TYPE',
        variantTypeId: 'variant123',
        detail: ProductDetail(
          name: 'Complete Product',
          productCode: 'PC001',
          priceCode: 'PRICE001',
          sku: 'SKU001',
          upcCode: '123456789012',
          modelNumber: 'MODEL001',
          taxCode1: 'TAX1',
          taxCode2: 'TAX2',
          taxCategory: 'TAXCAT',
          shippingClassification: 'SHIP001',
          shippingLength: 10,
          shippingWidth: 8,
          shippingHeight: 6,
          shippingWeight: 2.5,
          unspsc: 'UNSPSC001',
          roundingRule: 'round',
          replacementProductId: 'replacement123',
        ),
        content: ProductContent(
          htmlContent: '<p>HTML content</p>',
          metaDescription: 'Meta description',
          metaKeywords: 'keyword1, keyword2',
          pageTitle: 'Product Page Title',
        ),
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert - Root level fields
      expect(entity.id, equals('product001'));
      expect(entity.name, equals('Complete Product'));
      expect(entity.urlSegment, equals('product-url'));
      expect(entity.manufacturerItem, equals('MFG123'));
      expect(entity.packDescription, equals('Pack of 12'));
      expect(entity.customerUnitOfMeasure, equals('EA'));
      expect(entity.imageAltText, equals('Image alt text'));

      // Assert - Fields from detail
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
      expect(entity.unspsc, equals('UNSPSC001'));
      expect(entity.roundingRule, equals('round'));
      expect(entity.replacementProductId, equals('replacement123'));

      // Assert - Fields from content
      expect(entity.htmlContent, equals('<p>HTML content</p>'));
      expect(entity.metaDescription, equals('Meta description'));
      expect(entity.metaKeywords, equals('keyword1, keyword2'));
      expect(entity.pageTitle, equals('Product Page Title'));

      // Assert - V1 fields set to null by mapper
      expect(entity.styleParentId, isNull);
      expect(entity.vendorNumber, isNull);
      expect(entity.currencySymbol, isNull);
      expect(entity.selectedUnitOfMeasure, isNull);

      // Assert - Other root fields
      expect(entity.salePriceLabel, equals('Sale Price'));
      expect(entity.productNumber, equals('PN001'));
      expect(entity.customerProductNumber, equals('CPN001'));
      expect(entity.productTitle, equals('Product Title'));
      expect(entity.canonicalUrl, equals('/canonical-url'));
      expect(entity.unitListPriceDisplay, equals('\$24.99'));
      expect(entity.configurationType, equals('CONFIG_TYPE'));
      expect(entity.variantTypeId, equals('variant123'));
    });

    test('toEntity should map numeric fields from root and detail', () {
      // Arrange
      final model = Product(
        id: 'product002',
        minimumOrderQty: 2,
        score: 95.5,
        unitListPrice: 34.99,
        priceFacet: 3,
        detail: ProductDetail(
          multipleSaleQty: 5,
          sortOrder: 10,
        ),
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.multipleSaleQty, equals(5));
      expect(entity.minimumOrderQty, equals(2));
      expect(entity.sortOrder, equals(10));
      expect(entity.score, equals(95.5));
      expect(entity.unitListPrice, equals(34.99));
      expect(entity.priceFacet, equals(3));
    });

    test('toEntity should map boolean fields from root and detail', () {
      // Arrange
      final model = Product(
        id: 'product003',
        isDiscontinued: true,
        isSponsored: true,
        quoteRequired: true,
        trackInventory: true,
        canAddToCart: false,
        canAddToWishlist: false,
        canShowPrice: false,
        canShowUnitOfMeasure: true,
        canConfigure: true,
        isVariantParent: false,
        cantBuy: true,
        allowZeroPricing: false,
        detail: ProductDetail(
          isHazardousGood: false,
          isSpecialOrder: false,
          isGiftCard: true,
          isSubscription: false,
          canBackOrder: false,
          allowAnyGiftCardAmount: false,
          hasMsds: true,
        ),
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.isDiscontinued, isTrue);
      expect(entity.isHazardousGood, isFalse);
      expect(entity.isSpecialOrder, isFalse);
      expect(entity.isGiftCard, isTrue);
      expect(entity.isSponsored, isTrue);
      expect(entity.isSubscription, isFalse);
      expect(entity.quoteRequired, isTrue);
      expect(entity.canBackOrder, isFalse);
      expect(entity.trackInventory, isTrue);
      expect(entity.allowAnyGiftCardAmount, isFalse);
      expect(entity.hasMsds, isTrue);
      expect(entity.canAddToCart, isFalse);
      expect(entity.canAddToWishlist, isFalse);
      expect(entity.canShowPrice, isFalse);
      expect(entity.canShowUnitOfMeasure, isTrue);
      expect(entity.canConfigure, isTrue);
      expect(entity.isVariantParent, isFalse);
      expect(entity.cantBuy, isTrue);
      expect(entity.allowZeroPricing, isFalse);
    });

    test('toEntity should handle complex nested objects', () {
      // Arrange
      final model = Product(
        id: 'product005',
        productLine: ProductLine(
          id: 'line1',
          name: 'Product Line 1',
        ),
        detail: ProductDetail(
          name: 'Detailed Product',
          modelNumber: 'MODEL123',
          sku: 'DETAIL_SKU',
          sortOrder: 1,
          configuration: LegacyConfiguration(
            configSections: [
              ConfigSection(
                id: 'section1',
                sectionName: 'Section 1',
                sortOrder: 1,
                sectionOptions: [
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
        productTitle: 'Collection Test Product',
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
            id: 'spec1',
            name: 'Dimensions',
            value: '10x5x3 inches',
            htmlContent: '<p>Detailed dimensions</p>',
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
      );

      // Act
      final entity = ProductEntityMapper.toEntity(model);

      // Assert
      expect(entity.attributeTypes, isNotNull);
      expect(entity.attributeTypes?.length, equals(1));
      expect(entity.attributeTypes?[0].id, equals('attr1'));

      expect(entity.documents, isNotNull);
      expect(entity.documents?.length, equals(1));
      expect(entity.documents?[0].id, equals('doc1'));

      expect(entity.specifications, isNotNull);
      expect(entity.specifications?.length, equals(1));
      expect(entity.specifications?[0].specificationId, equals('spec1'));

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
    });

    test('toEntity should handle mixed null and populated collections', () {
      // Arrange
      final model = Product(
        id: 'mixed_collections_test',
        productTitle: 'Mixed Collections Test',
        attributeTypes: [],
        documents: [
          Document(id: 'doc1', name: 'Manual'),
          Document(id: 'doc2', name: 'Warranty'),
        ],
        specifications: null,
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
      expect(entity.attributeTypes, isEmpty);
      expect(entity.documents?.length, equals(2));
      expect(entity.specifications, isNull);
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
        productNumber: 'ERP123',
        smallImagePath: '/images/small.jpg',
        mediumImagePath: '/images/medium.jpg',
        largeImagePath: '/images/large.jpg',
        canAddToCart: true,
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
      expect(model.productTitle, equals(entity.name));
      expect(model.productNumber, equals(entity.productNumber));
      expect(model.smallImagePath, equals(entity.smallImagePath));
      expect(model.mediumImagePath, equals(entity.mediumImagePath));
      expect(model.largeImagePath, equals(entity.largeImagePath));
      expect(model.canAddToCart, equals(entity.canAddToCart));

      // Check unit of measures
      expect(
          model.unitOfMeasures?.length, equals(entity.unitOfMeasures?.length));
      expect(model.unitOfMeasures?[0].unitOfMeasure,
          equals(entity.unitOfMeasures?[0].unitOfMeasure));

      // Check brand
      expect(model.brand?.id, equals(entity.brand?.id));
      expect(model.brand?.name, equals(entity.brand?.name));
    });

    test('toModel should handle entity with null nested objects', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product456',
        name: 'Basic Product',
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.productTitle, equals(entity.name));
      expect(model.brand, isNull);
    });

    test('toModel should handle entity with empty collections', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product789',
        name: 'Collection Product',
        unitOfMeasures: const [],
        images: const [],
        specifications: const [],
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.unitOfMeasures, isEmpty);
      expect(model.images, isEmpty);
      expect(model.specifications, isEmpty);
    });

    test('toModel should convert collections properly', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product101',
        name: 'Product with Collections',
        unitOfMeasures: const [
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
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.unitOfMeasures?.length, equals(2));
      expect(model.unitOfMeasures?[0].unitOfMeasure, equals('EA'));
      expect(model.unitOfMeasures?[1].unitOfMeasure, equals('CS'));
    });

    test('toModel should handle null collections gracefully', () {
      // Arrange
      final entity = ProductEntity(
        id: 'product006',
        name: 'Null Collections Product',
        crossSells: null,
        accessories: null,
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
        brand: const BrandEntity(),
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert
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
        productTitle: 'Test Product',
        productNumber: 'ERP123',
        smallImagePath: '/images/small.jpg',
        canAddToCart: true,
        unitOfMeasures: [
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
      expect(resultModel.productTitle, equals(originalModel.productTitle));
      expect(resultModel.productNumber, equals(originalModel.productNumber));
      expect(resultModel.smallImagePath, equals(originalModel.smallImagePath));
      expect(resultModel.canAddToCart, equals(originalModel.canAddToCart));

      // Check unit of measures
      expect(resultModel.unitOfMeasures?.length,
          equals(originalModel.unitOfMeasures?.length));
      expect(resultModel.unitOfMeasures?[0].unitOfMeasure,
          equals(originalModel.unitOfMeasures?[0].unitOfMeasure));

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
        productTitle: 'Roundtrip Collections Test',
        attributeTypes: [
          AttributeType(id: 'rt_attr1', name: 'Material', isActive: true),
        ],
        documents: [
          Document(id: 'rt_doc1', name: 'Manual', documentType: 'PDF'),
        ],
        specifications: [
          Specification(
              id: 'rt_spec1', name: 'Weight', value: '1.5kg'),
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
      );

      // Act
      final entity = ProductEntityMapper.toEntity(originalModel);
      final resultModel = ProductEntityMapper.toModel(entity);

      // Assert - Test all collections are preserved
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
      expect(resultModel.specifications?[0].id,
          equals(originalModel.specifications?[0].id));

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
    });

    test('toModel should handle minimal non-null nested objects correctly', () {
      // Arrange
      final entity = ProductEntity(
        id: 'minimal_nested_test',
        name: 'Minimal Nested Test',
        brand: const BrandEntity(),
        productLine: const ProductLineEntity(),
        scoreExplanation: const ScoreExplanationEntity(),
        detail: const ProductDetailEntity(),
        content: const ProductContentEntity(),
        unitOfMeasures: const [
          ProductUnitOfMeasureEntity(),
        ],
      );

      // Act
      final model = ProductEntityMapper.toModel(entity);

      // Assert - Verify all nested objects are properly converted
      expect(model.brand, isNotNull);
      expect(model.productLine, isNotNull);
      expect(model.scoreExplanation, isNotNull);
      expect(model.detail, isNotNull);
      expect(model.content, isNotNull);
      expect(model.unitOfMeasures, isNotNull);
      expect(model.unitOfMeasures?.length, equals(1));
    });
  });
}
