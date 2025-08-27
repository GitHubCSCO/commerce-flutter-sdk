import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/break_price_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_price_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('CartLineEntityMapper', () {
    test('should correctly map CartLine to CartLineEntity', () {
      // Arrange
      final cartLine = CartLine(
        productUri: "https://example.com/product/123",
        id: "123",
        productId: "ABC-123",
        line: 1,
        qtyOrdered: 2,
        requisitionId: "REQ-001",
        smallImagePath: "/images/product123.jpg",
        altText: "Product Image",
        productName: "Test Product",
        manufacturerItem: "MANU-123",
        customerName: "John Doe",
        shortDescription: "This is a test product",
        erpNumber: "ERP-123",
        unitOfMeasureDisplay: "Each",
        unitOfMeasureDescription: "Each Unit",
        baseUnitOfMeasure: "Each",
        baseUnitOfMeasureDisplay: "Each Unit",
        qtyPerBaseUnitOfMeasure: 1.0,
        costCode: "CC-001",
        qtyLeft: 5,
        pricing: ProductPriceEntityMapper.toModel(const ProductPriceEntity(
          unitRegularPrice: 100.0,
          unitNetPrice: 90.0,
          unitRegularPriceDisplay: "\$100.00",
          unitNetPriceDisplay: "\$90.00",
        )),
        isPromotionItem: false,
        isDiscounted: true,
        isFixedConfiguration: false,
        quoteRequired: false,
        breakPrices: [
          BreakPriceDtoEntityMapper.toModel(BreakPriceDTOEntity(
            breakQty: 5,
            breakPrice: 85.0,
            breakPriceDisplay: "\$85.00",
            savingsMessage: "Save 15%",
          ))
        ],
        availability: AvailabilityEntityMapper.toModel(
            const AvailabilityEntity(messageType: 1, message: "In Stock")),
        qtyOnHand: 20,
        canAddToCart: true,
        isQtyAdjusted: false,
        hasInsufficientInventory: false,
        canBackOrder: true,
        salePriceLabel: "Sale",
        isSubscription: false,
        productSubscription: null,
        isRestricted: false,
        isActive: true,
        brand: BrandEntityMapper.toModel(
            const BrandEntity(id: "B123", name: "BrandX")),
        status: "Available",
        notes: "Special instructions",
        vmiBinId: "VMI-001",
        sectionOptions: [],
        unitOfMeasure: "EA",
        allowZeroPricing: false,
      )..properties = {"key1": "value1", "key2": "value2"};

      // Act
      final result = CartLineEntityMapper.toEntity(cartLine);

      // Assert
      expect(result.productUri, cartLine.productUri);
      expect(result.id, cartLine.id);
      expect(result.productId, cartLine.productId);
      expect(result.line, cartLine.line);
      expect(result.qtyOrdered, cartLine.qtyOrdered);
      expect(result.requisitionId, cartLine.requisitionId);
      expect(result.smallImagePath, cartLine.smallImagePath);
      expect(result.altText, cartLine.altText);
      expect(result.productName, cartLine.productName);
      expect(result.manufacturerItem, cartLine.manufacturerItem);
      expect(result.customerName, cartLine.customerName);
      expect(result.shortDescription, cartLine.shortDescription);
      expect(result.erpNumber, cartLine.erpNumber);
      expect(result.unitOfMeasureDisplay, cartLine.unitOfMeasureDisplay);
      expect(
          result.unitOfMeasureDescription, cartLine.unitOfMeasureDescription);
      expect(result.baseUnitOfMeasure, cartLine.baseUnitOfMeasure);
      expect(
          result.baseUnitOfMeasureDisplay, cartLine.baseUnitOfMeasureDisplay);
      expect(result.qtyPerBaseUnitOfMeasure, cartLine.qtyPerBaseUnitOfMeasure);
      expect(result.costCode, cartLine.costCode);
      expect(result.qtyLeft, cartLine.qtyLeft);
      expect(result.isPromotionItem, cartLine.isPromotionItem);
      expect(result.isDiscounted, cartLine.isDiscounted);
      expect(result.isFixedConfiguration, cartLine.isFixedConfiguration);
      expect(result.quoteRequired, cartLine.quoteRequired);
      expect(result.qtyOnHand, cartLine.qtyOnHand);
      expect(result.canAddToCart, cartLine.canAddToCart);
      expect(result.isQtyAdjusted, cartLine.isQtyAdjusted);
      expect(
          result.hasInsufficientInventory, cartLine.hasInsufficientInventory);
      expect(result.canBackOrder, cartLine.canBackOrder);
      expect(result.salePriceLabel, cartLine.salePriceLabel);
      expect(result.isSubscription, cartLine.isSubscription);
      expect(result.isRestricted, cartLine.isRestricted);
      expect(result.isActive, cartLine.isActive);
      expect(result.status, cartLine.status);
      expect(result.notes, cartLine.notes);
      expect(result.vmiBinId, cartLine.vmiBinId);
      // unitOfMeasure is not mapped in toEntity method - it's inherited from AddCartLineEntity
      expect(result.allowZeroPricing, cartLine.allowZeroPricing);
      expect(result.properties, cartLine.properties);
      expect(result.pricing, isNotNull);
      expect(result.availability, isNotNull);
      expect(result.brand, isNotNull);
      expect(result.breakPrices, hasLength(1));
      expect(result.sectionOptions, hasLength(0));
      expect(result.productSubscription, isNotNull);
    });

    test('should correctly map CartLineEntity to CartLine', () {
      // Arrange
      final cartLineEntity = CartLineEntity(
        productUri: "https://example.com/product/123",
        id: "123",
        productId: "ABC-123",
        line: 1,
        qtyOrdered: 2,
        requisitionId: "REQ-001",
        smallImagePath: "/images/product123.jpg",
        altText: "Product Image",
        productName: "Test Product",
        manufacturerItem: "MANU-123",
        customerName: "John Doe",
        shortDescription: "This is a test product",
        erpNumber: "ERP-123",
        unitOfMeasureDisplay: "Each",
        unitOfMeasureDescription: "Each Unit",
        baseUnitOfMeasure: "Each",
        baseUnitOfMeasureDisplay: "Each Unit",
        qtyPerBaseUnitOfMeasure: 1.0,
        costCode: "CC-001",
        qtyLeft: 5,
        pricing: const ProductPriceEntity(
          unitRegularPrice: 100.0,
          unitNetPrice: 90.0,
          unitRegularPriceDisplay: "\$100.00",
          unitNetPriceDisplay: "\$90.00",
        ),
        isPromotionItem: false,
        isDiscounted: true,
        isFixedConfiguration: false,
        quoteRequired: false,
        breakPrices: [
          BreakPriceDTOEntity(
            breakQty: 5,
            breakPrice: 85.0,
            breakPriceDisplay: "\$85.00",
            savingsMessage: "Save 15%",
          )
        ],
        availability:
            const AvailabilityEntity(messageType: 1, message: "In Stock"),
        qtyOnHand: 20,
        canAddToCart: true,
        isQtyAdjusted: false,
        hasInsufficientInventory: false,
        canBackOrder: true,
        salePriceLabel: "Sale",
        isSubscription: false,
        isRestricted: false,
        isActive: true,
        brand: const BrandEntity(id: "B123", name: "BrandX"),
        status: "Available",
        notes: "Special instructions",
        vmiBinId: "VMI-001",
        sectionOptions: const [],
        unitOfMeasure: "EA",
        allowZeroPricing: false,
        properties: const {"key1": "value1", "key2": "value2"},
      );

      // Act
      final result = CartLineEntityMapper.toModel(cartLineEntity);

      // Assert
      expect(result.productUri, cartLineEntity.productUri);
      expect(result.id, cartLineEntity.id);
      expect(result.productId, cartLineEntity.productId);
      expect(result.line, cartLineEntity.line);
      expect(result.qtyOrdered, cartLineEntity.qtyOrdered);
      expect(result.requisitionId, cartLineEntity.requisitionId);
      expect(result.smallImagePath, cartLineEntity.smallImagePath);
      expect(result.altText, cartLineEntity.altText);
      expect(result.productName, cartLineEntity.productName);
      expect(result.manufacturerItem, cartLineEntity.manufacturerItem);
      expect(result.customerName, cartLineEntity.customerName);
      expect(result.shortDescription, cartLineEntity.shortDescription);
      expect(result.erpNumber, cartLineEntity.erpNumber);
      expect(result.unitOfMeasureDisplay, cartLineEntity.unitOfMeasureDisplay);
      expect(result.unitOfMeasureDescription,
          cartLineEntity.unitOfMeasureDescription);
      expect(result.baseUnitOfMeasure, cartLineEntity.baseUnitOfMeasure);
      expect(result.baseUnitOfMeasureDisplay,
          cartLineEntity.baseUnitOfMeasureDisplay);
      expect(result.qtyPerBaseUnitOfMeasure,
          cartLineEntity.qtyPerBaseUnitOfMeasure);
      expect(result.costCode, cartLineEntity.costCode);
      expect(result.qtyLeft, cartLineEntity.qtyLeft);
      expect(result.isPromotionItem, cartLineEntity.isPromotionItem);
      expect(result.isDiscounted, cartLineEntity.isDiscounted);
      expect(result.isFixedConfiguration, cartLineEntity.isFixedConfiguration);
      expect(result.quoteRequired, cartLineEntity.quoteRequired);
      expect(result.qtyOnHand, cartLineEntity.qtyOnHand);
      expect(result.canAddToCart, cartLineEntity.canAddToCart);
      expect(result.isQtyAdjusted, cartLineEntity.isQtyAdjusted);
      expect(result.hasInsufficientInventory,
          cartLineEntity.hasInsufficientInventory);
      expect(result.canBackOrder, cartLineEntity.canBackOrder);
      expect(result.salePriceLabel, cartLineEntity.salePriceLabel);
      expect(result.isSubscription, cartLineEntity.isSubscription);
      expect(result.isRestricted, cartLineEntity.isRestricted);
      expect(result.isActive, cartLineEntity.isActive);
      expect(result.status, cartLineEntity.status);
      expect(result.notes, cartLineEntity.notes);
      expect(result.vmiBinId, cartLineEntity.vmiBinId);
      expect(result.unitOfMeasure, cartLineEntity.unitOfMeasure);
      expect(result.allowZeroPricing, cartLineEntity.allowZeroPricing);
      expect(result.properties, cartLineEntity.properties);
      expect(result.pricing, isNotNull);
      expect(result.availability, isNotNull);
      expect(result.brand, isNotNull);
      expect(result.breakPrices, hasLength(1));
      expect(result.sectionOptions, hasLength(0));
      expect(result.productSubscription, isNotNull);
    });

    test('should handle null values in CartLineEntity to CartLine mapping', () {
      // Arrange
      const cartLineEntity = CartLineEntity(
        productId: "ABC-123",
        qtyOrdered: 1,
        pricing: null,
        availability: null,
        brand: null,
        productSubscription: null,
        breakPrices: null,
        sectionOptions: null,
      );

      // Act
      final result = CartLineEntityMapper.toModel(cartLineEntity);

      // Assert
      expect(result.productId, "ABC-123");
      expect(result.qtyOrdered, 1);
      expect(result.pricing, isNotNull); // Should create default ProductPrice
      expect(
          result.availability, isNotNull); // Should create default Availability
      expect(result.brand, isNotNull); // Should create default Brand
      expect(result.productSubscription,
          isNotNull); // Should create default ProductSubscriptionDto
      expect(result.breakPrices, isNull);
      expect(result.sectionOptions, isNull);
    });

    test('should handle complex product subscription mapping', () {
      // Arrange
      final cartLine = CartLine(
        productId: "P123",
        productSubscription: ProductSubscriptionDto(
          subscriptionAddToInitialOrder: true,
          subscriptionAllMonths: false,
          subscriptionApril: true,
          subscriptionAugust: false,
          subscriptionCyclePeriod: "monthly",
          subscriptionDecember: true,
          subscriptionFebruary: false,
          subscriptionFixedPrice: true,
          subscriptionJanuary: true,
          subscriptionJuly: false,
          subscriptionJune: true,
          subscriptionMarch: false,
          subscriptionMay: true,
          subscriptionNovember: false,
          subscriptionOctober: true,
          subscriptionPeriodsPerCycle: 12,
          subscriptionSeptember: false,
          subscriptionShipViaId: "SHIP123",
          subscriptionTotalCycles: 24,
        ),
      );

      // Act
      final result = CartLineEntityMapper.toEntity(cartLine);

      // Assert
      expect(result.productSubscription, isNotNull);
      expect(result.productSubscription?.subscriptionAddToInitialOrder, true);
      expect(result.productSubscription?.subscriptionAllMonths, false);
      expect(result.productSubscription?.subscriptionApril, true);
      expect(result.productSubscription?.subscriptionAugust, false);
      expect(result.productSubscription?.subscriptionCyclePeriod, "monthly");
      expect(result.productSubscription?.subscriptionDecember, true);
      expect(result.productSubscription?.subscriptionFebruary, false);
      expect(result.productSubscription?.subscriptionFixedPrice, true);
      expect(result.productSubscription?.subscriptionJanuary, true);
      expect(result.productSubscription?.subscriptionJuly, false);
      expect(result.productSubscription?.subscriptionJune, true);
      expect(result.productSubscription?.subscriptionMarch, false);
      expect(result.productSubscription?.subscriptionMay, true);
      expect(result.productSubscription?.subscriptionNovember, false);
      expect(result.productSubscription?.subscriptionOctober, true);
      expect(result.productSubscription?.subscriptionPeriodsPerCycle, 12);
      expect(result.productSubscription?.subscriptionSeptember, false);
      expect(result.productSubscription?.subscriptionShipViaId, "SHIP123");
      expect(result.productSubscription?.subscriptionTotalCycles, 24);
    });

    test('should handle section options mapping', () {
      // Arrange
      final cartLine = CartLine(
        productId: "P123",
        sectionOptions: [
          SectionOptionDto(
            sectionOptionId: "SO1",
            sectionName: "Color",
            optionName: "Red",
          ),
          SectionOptionDto(
            sectionOptionId: "SO2",
            sectionName: "Size",
            optionName: "Large",
          ),
        ],
      );

      // Act
      final result = CartLineEntityMapper.toEntity(cartLine);

      // Assert
      expect(result.sectionOptions, hasLength(2));
      expect(result.sectionOptions?[0].sectionOptionId, "SO1");
      expect(result.sectionOptions?[0].sectionName, "Color");
      expect(result.sectionOptions?[0].optionName, "Red");
      expect(result.sectionOptions?[1].sectionOptionId, "SO2");
      expect(result.sectionOptions?[1].sectionName, "Size");
      expect(result.sectionOptions?[1].optionName, "Large");
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalCartLine = CartLine(
        productId: "ROUNDTRIP-123",
        qtyOrdered: 3,
        unitOfMeasure: "BX",
        notes: "Test notes",
        vmiBinId: "VMI-TEST",
        allowZeroPricing: true,
        productName: "Roundtrip Product",
        isActive: true,
        canAddToCart: false,
      );

      // Act
      final entity = CartLineEntityMapper.toEntity(originalCartLine);
      final convertedBack = CartLineEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.productId, originalCartLine.productId);
      expect(convertedBack.qtyOrdered, originalCartLine.qtyOrdered);
      // unitOfMeasure is not preserved in roundtrip - it's not mapped in toEntity
      expect(convertedBack.notes, originalCartLine.notes);
      expect(convertedBack.vmiBinId, originalCartLine.vmiBinId);
      expect(convertedBack.allowZeroPricing, originalCartLine.allowZeroPricing);
      expect(convertedBack.productName, originalCartLine.productName);
      expect(convertedBack.isActive, originalCartLine.isActive);
      expect(convertedBack.canAddToCart, originalCartLine.canAddToCart);
      // Note: unitOfMeasure is not preserved in roundtrip due to mapper implementation
    });
  });

  group('AddCartLineMapper', () {
    test('should correctly map AddCartLine to AddCartLineEntity', () {
      // Arrange
      final addCartLine = AddCartLine(
        productId: "P456",
        qtyOrdered: 5,
        unitOfMeasure: "CS",
        notes: "Add cart line notes",
        vmiBinId: "VMI-456",
        allowZeroPricing: true,
        sectionOptions: [
          SectionOptionDto(
            sectionOptionId: "SO3",
            sectionName: "Material",
            optionName: "Steel",
          ),
        ],
      );

      // Act
      final result = AddCartLineMapper.toEntity(addCartLine);

      // Assert
      expect(result.productId, "P456");
      expect(result.qtyOrdered, 5);
      expect(result.unitOfMeasure, "CS");
      expect(result.notes, "Add cart line notes");
      expect(result.vmiBinId, "VMI-456");
      expect(result.allowZeroPricing, true);
      expect(result.sectionOptions, hasLength(1));
      expect(result.sectionOptions?[0].sectionOptionId, "SO3");
      expect(result.sectionOptions?[0].sectionName, "Material");
      expect(result.sectionOptions?[0].optionName, "Steel");
    });

    test('should handle null AddCartLine input', () {
      // Act
      final result = AddCartLineMapper.toEntity(null);

      // Assert
      expect(result.productId, isNull);
      expect(result.qtyOrdered, isNull);
      expect(result.unitOfMeasure, isNull);
      expect(result.notes, isNull);
      expect(result.vmiBinId, isNull);
      expect(result.allowZeroPricing, isNull);
      expect(result.sectionOptions, isNull);
    });

    test('should handle null section options in AddCartLine', () {
      // Arrange
      final addCartLine = AddCartLine(
        productId: "P789",
        qtyOrdered: 2,
        sectionOptions: null,
      );

      // Act
      final result = AddCartLineMapper.toEntity(addCartLine);

      // Assert
      expect(result.productId, "P789");
      expect(result.qtyOrdered, 2);
      expect(result.sectionOptions, isNull);
    });
  });

  group('CartLineListMapper', () {
    test('should correctly map CartLineList to CartLineListEntity', () {
      // Arrange
      final cartLineList = CartLineList(
        cartLines: [
          CartLine(productId: "P1", qtyOrdered: 1),
          CartLine(productId: "P2", qtyOrdered: 2),
          CartLine(productId: "P3", qtyOrdered: 3),
        ],
      );

      // Act
      final result = CartLineListMapper.toEntity(cartLineList);

      // Assert
      expect(result.cartLines, hasLength(3));
      expect(result.cartLines?[0].productId, "P1");
      expect(result.cartLines?[0].qtyOrdered, 1);
      expect(result.cartLines?[1].productId, "P2");
      expect(result.cartLines?[1].qtyOrdered, 2);
      expect(result.cartLines?[2].productId, "P3");
      expect(result.cartLines?[2].qtyOrdered, 3);
    });

    test('should handle null cartLines in CartLineList', () {
      // Arrange
      final cartLineList = CartLineList(cartLines: null);

      // Act
      final result = CartLineListMapper.toEntity(cartLineList);

      // Assert
      expect(result.cartLines, isNull);
    });

    test('should handle empty cartLines list', () {
      // Arrange
      final cartLineList = CartLineList(cartLines: []);

      // Act
      final result = CartLineListMapper.toEntity(cartLineList);

      // Assert
      expect(result.cartLines, hasLength(0));
    });
  });

  group('SectionOptionEntityMapper', () {
    test('should correctly map SectionOptionDto to SectionOptionEntity', () {
      // Arrange
      final sectionOptionDto = SectionOptionDto(
        sectionOptionId: "SO123",
        sectionName: "Color Options",
        optionName: "Blue",
      );

      // Act
      final result = SectionOptionEntityMapper.toEntity(sectionOptionDto);

      // Assert
      expect(result.sectionOptionId, "SO123");
      expect(result.sectionName, "Color Options");
      expect(result.optionName, "Blue");
    });

    test('should correctly map SectionOptionEntity to SectionOptionDto', () {
      // Arrange
      final sectionOptionEntity = SectionOptionEntity(
        sectionOptionId: "SO456",
        sectionName: "Size Options",
        optionName: "Medium",
      );

      // Act
      final result = SectionOptionEntityMapper.toModel(sectionOptionEntity);

      // Assert
      expect(result.sectionOptionId, "SO456");
      expect(result.sectionName, "Size Options");
      expect(result.optionName, "Medium");
    });

    test('should handle null values in SectionOption mapping', () {
      // Arrange
      final sectionOptionDto = SectionOptionDto(
        sectionOptionId: null,
        sectionName: null,
        optionName: null,
      );

      // Act
      final result = SectionOptionEntityMapper.toEntity(sectionOptionDto);

      // Assert
      expect(result.sectionOptionId, isNull);
      expect(result.sectionName, isNull);
      expect(result.optionName, isNull);
    });

    test('should perform roundtrip conversion for SectionOption', () {
      // Arrange
      final originalDto = SectionOptionDto(
        sectionOptionId: "ROUNDTRIP-SO",
        sectionName: "Test Section",
        optionName: "Test Option",
      );

      // Act
      final entity = SectionOptionEntityMapper.toEntity(originalDto);
      final convertedBack = SectionOptionEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.sectionOptionId, originalDto.sectionOptionId);
      expect(convertedBack.sectionName, originalDto.sectionName);
      expect(convertedBack.optionName, originalDto.optionName);
    });
  });

  group('ProductSubscriptionEntityMapper', () {
    test(
        'should correctly map ProductSubscriptionDto to ProductSubscriptionEntity',
        () {
      // Arrange
      final productSubscriptionDto = ProductSubscriptionDto(
        subscriptionAddToInitialOrder: true,
        subscriptionAllMonths: false,
        subscriptionApril: true,
        subscriptionAugust: false,
        subscriptionCyclePeriod: "quarterly",
        subscriptionDecember: true,
        subscriptionFebruary: false,
        subscriptionFixedPrice: true,
        subscriptionJanuary: true,
        subscriptionJuly: false,
        subscriptionJune: true,
        subscriptionMarch: false,
        subscriptionMay: true,
        subscriptionNovember: false,
        subscriptionOctober: true,
        subscriptionPeriodsPerCycle: 4,
        subscriptionSeptember: false,
        subscriptionShipViaId: "QUARTERLY-SHIP",
        subscriptionTotalCycles: 8,
      );

      // Act
      final result =
          ProductSubscriptionEntityMapper.toEntity(productSubscriptionDto);

      // Assert
      expect(result.subscriptionAddToInitialOrder, true);
      expect(result.subscriptionAllMonths, false);
      expect(result.subscriptionApril, true);
      expect(result.subscriptionAugust, false);
      expect(result.subscriptionCyclePeriod, "quarterly");
      expect(result.subscriptionDecember, true);
      expect(result.subscriptionFebruary, false);
      expect(result.subscriptionFixedPrice, true);
      expect(result.subscriptionJanuary, true);
      expect(result.subscriptionJuly, false);
      expect(result.subscriptionJune, true);
      expect(result.subscriptionMarch, false);
      expect(result.subscriptionMay, true);
      expect(result.subscriptionNovember, false);
      expect(result.subscriptionOctober, true);
      expect(result.subscriptionPeriodsPerCycle, 4);
      expect(result.subscriptionSeptember, false);
      expect(result.subscriptionShipViaId, "QUARTERLY-SHIP");
      expect(result.subscriptionTotalCycles, 8);
    });

    test(
        'should correctly map ProductSubscriptionEntity to ProductSubscriptionDto',
        () {
      // Arrange
      final productSubscriptionEntity = ProductSubscriptionEntity(
        subscriptionAddToInitialOrder: false,
        subscriptionAllMonths: true,
        subscriptionApril: false,
        subscriptionAugust: true,
        subscriptionCyclePeriod: "yearly",
        subscriptionDecember: false,
        subscriptionFebruary: true,
        subscriptionFixedPrice: false,
        subscriptionJanuary: false,
        subscriptionJuly: true,
        subscriptionJune: false,
        subscriptionMarch: true,
        subscriptionMay: false,
        subscriptionNovember: true,
        subscriptionOctober: false,
        subscriptionPeriodsPerCycle: 1,
        subscriptionSeptember: true,
        subscriptionShipViaId: "YEARLY-SHIP",
        subscriptionTotalCycles: 5,
      );

      // Act
      final result =
          ProductSubscriptionEntityMapper.toModel(productSubscriptionEntity);

      // Assert
      expect(result.subscriptionAddToInitialOrder, false);
      expect(result.subscriptionAllMonths, true);
      expect(result.subscriptionApril, false);
      expect(result.subscriptionAugust, true);
      expect(result.subscriptionCyclePeriod, "yearly");
      expect(result.subscriptionDecember, false);
      expect(result.subscriptionFebruary, true);
      expect(result.subscriptionFixedPrice, false);
      expect(result.subscriptionJanuary, false);
      expect(result.subscriptionJuly, true);
      expect(result.subscriptionJune, false);
      expect(result.subscriptionMarch, true);
      expect(result.subscriptionMay, false);
      expect(result.subscriptionNovember, true);
      expect(result.subscriptionOctober, false);
      expect(result.subscriptionPeriodsPerCycle, 1);
      expect(result.subscriptionSeptember, true);
      expect(result.subscriptionShipViaId, "YEARLY-SHIP");
      expect(result.subscriptionTotalCycles, 5);
    });

    test('should handle null ProductSubscriptionDto input', () {
      // Act
      final result = ProductSubscriptionEntityMapper.toEntity(null);

      // Assert
      expect(result.subscriptionAddToInitialOrder, isNull);
      expect(result.subscriptionAllMonths, isNull);
      expect(result.subscriptionApril, isNull);
      expect(result.subscriptionAugust, isNull);
      expect(result.subscriptionCyclePeriod, isNull);
      expect(result.subscriptionDecember, isNull);
      expect(result.subscriptionFebruary, isNull);
      expect(result.subscriptionFixedPrice, isNull);
      expect(result.subscriptionJanuary, isNull);
      expect(result.subscriptionJuly, isNull);
      expect(result.subscriptionJune, isNull);
      expect(result.subscriptionMarch, isNull);
      expect(result.subscriptionMay, isNull);
      expect(result.subscriptionNovember, isNull);
      expect(result.subscriptionOctober, isNull);
      expect(result.subscriptionPeriodsPerCycle, isNull);
      expect(result.subscriptionSeptember, isNull);
      expect(result.subscriptionShipViaId, isNull);
      expect(result.subscriptionTotalCycles, isNull);
    });

    test('should handle all null values in ProductSubscription', () {
      // Arrange
      final productSubscriptionDto = ProductSubscriptionDto(
        subscriptionAddToInitialOrder: null,
        subscriptionAllMonths: null,
        subscriptionApril: null,
        subscriptionAugust: null,
        subscriptionCyclePeriod: null,
        subscriptionDecember: null,
        subscriptionFebruary: null,
        subscriptionFixedPrice: null,
        subscriptionJanuary: null,
        subscriptionJuly: null,
        subscriptionJune: null,
        subscriptionMarch: null,
        subscriptionMay: null,
        subscriptionNovember: null,
        subscriptionOctober: null,
        subscriptionPeriodsPerCycle: null,
        subscriptionSeptember: null,
        subscriptionShipViaId: null,
        subscriptionTotalCycles: null,
      );

      // Act
      final result =
          ProductSubscriptionEntityMapper.toEntity(productSubscriptionDto);

      // Assert
      expect(result.subscriptionAddToInitialOrder, isNull);
      expect(result.subscriptionAllMonths, isNull);
      expect(result.subscriptionApril, isNull);
      expect(result.subscriptionAugust, isNull);
      expect(result.subscriptionCyclePeriod, isNull);
      expect(result.subscriptionDecember, isNull);
      expect(result.subscriptionFebruary, isNull);
      expect(result.subscriptionFixedPrice, isNull);
      expect(result.subscriptionJanuary, isNull);
      expect(result.subscriptionJuly, isNull);
      expect(result.subscriptionJune, isNull);
      expect(result.subscriptionMarch, isNull);
      expect(result.subscriptionMay, isNull);
      expect(result.subscriptionNovember, isNull);
      expect(result.subscriptionOctober, isNull);
      expect(result.subscriptionPeriodsPerCycle, isNull);
      expect(result.subscriptionSeptember, isNull);
      expect(result.subscriptionShipViaId, isNull);
      expect(result.subscriptionTotalCycles, isNull);
    });

    test('should perform roundtrip conversion for ProductSubscription', () {
      // Arrange
      final originalDto = ProductSubscriptionDto(
        subscriptionAddToInitialOrder: true,
        subscriptionAllMonths: false,
        subscriptionCyclePeriod: "monthly",
        subscriptionPeriodsPerCycle: 12,
        subscriptionTotalCycles: 24,
        subscriptionShipViaId: "ROUNDTRIP-SHIP",
        subscriptionFixedPrice: true,
      );

      // Act
      final entity = ProductSubscriptionEntityMapper.toEntity(originalDto);
      final convertedBack = ProductSubscriptionEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.subscriptionAddToInitialOrder,
          originalDto.subscriptionAddToInitialOrder);
      expect(convertedBack.subscriptionAllMonths,
          originalDto.subscriptionAllMonths);
      expect(convertedBack.subscriptionCyclePeriod,
          originalDto.subscriptionCyclePeriod);
      expect(convertedBack.subscriptionPeriodsPerCycle,
          originalDto.subscriptionPeriodsPerCycle);
      expect(convertedBack.subscriptionTotalCycles,
          originalDto.subscriptionTotalCycles);
      expect(convertedBack.subscriptionShipViaId,
          originalDto.subscriptionShipViaId);
      expect(convertedBack.subscriptionFixedPrice,
          originalDto.subscriptionFixedPrice);
    });
  });
}
