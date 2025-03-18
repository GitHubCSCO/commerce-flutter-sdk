import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('AddCartLineMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = AddCartLine(
        productId: 'product123',
        qtyOrdered: 5,
        unitOfMeasure: 'EA',
        notes: 'Test notes',
        vmiBinId: 'bin123',
        sectionOptions: [
          SectionOptionDto(
            sectionOptionId: '1',
            sectionName: 'Color',
            optionName: 'Red',
          ),
        ],
        allowZeroPricing: true,
      );

      // Act
      final entity = AddCartLineMapper.toEntity(model);

      // Assert
      expect(entity.productId, equals(model.productId));
      expect(entity.qtyOrdered, equals(model.qtyOrdered));
      expect(entity.unitOfMeasure, equals(model.unitOfMeasure));
      expect(entity.notes, equals(model.notes));
      expect(entity.vmiBinId, equals(model.vmiBinId));
      expect(entity.sectionOptions?.length, equals(1));
      expect(entity.sectionOptions?[0].sectionOptionId, equals('1'));
      expect(entity.allowZeroPricing, equals(true));
    });

    test('toEntity should handle null model', () {
      // Act
      final entity = AddCartLineMapper.toEntity(null);

      // Assert
      expect(entity.productId, isNull);
      expect(entity.qtyOrdered, isNull);
      expect(entity.unitOfMeasure, isNull);
      expect(entity.notes, isNull);
      expect(entity.vmiBinId, isNull);
      expect(entity.sectionOptions, isNull);
      expect(entity.allowZeroPricing, isNull);
    });
  });

  group('CartLineListMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = CartLineList(
        cartLines: [
          CartLine(
            id: 'line1',
            line: 1,
            productId: 'product123',
            productName: 'Test Product',
          ),
          CartLine(
            id: 'line2',
            line: 2,
            productId: 'product456',
            productName: 'Another Product',
          )
        ],
      );

      // Act
      final entity = CartLineListMapper.toEntity(model);

      // Assert
      expect(entity.cartLines?.length, equals(2));
      expect(entity.cartLines?[0].id, equals('line1'));
      expect(entity.cartLines?[1].id, equals('line2'));
    });

    test('toEntity should handle model with empty cartLines', () {
      // Arrange
      final model = CartLineList(
        cartLines: [],
      );

      // Act
      final entity = CartLineListMapper.toEntity(model);

      // Assert
      expect(entity.cartLines, isEmpty);
    });

    test('toEntity should handle model with null cartLines', () {
      // Arrange
      final model = CartLineList(
        cartLines: null,
      );

      // Act
      final entity = CartLineListMapper.toEntity(model);

      // Assert
      expect(entity.cartLines, isNull);
    });
  });

  group('CartLineEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = CartLine(
        productUri: 'uri://test',
        id: 'line123',
        line: 1,
        productId: 'product123',
        requisitionId: 'req123',
        smallImagePath: '/images/small.jpg',
        altText: 'Product Image',
        qtyOrdered: 3,
        productName: 'Test Product',
        manufacturerItem: 'MFR123',
        customerName: 'Custom Name',
        shortDescription: 'Short description',
        erpNumber: 'ERP123',
        unitOfMeasure: 'EA',
        unitOfMeasureDisplay: 'Each',
        unitOfMeasureDescription: 'Each item',
        baseUnitOfMeasure: 'EA',
        baseUnitOfMeasureDisplay: 'Each',
        qtyPerBaseUnitOfMeasure: 1,
        costCode: 'CC123',
        qtyLeft: 97,
        pricing: ProductPrice(),
        isPromotionItem: false,
        isDiscounted: true,
        isFixedConfiguration: false,
        quoteRequired: false,
        breakPrices: [BreakPriceDto(breakQty: 10, breakPrice: 9.99)],
        availability: Availability(message: 'In Stock'),
        qtyOnHand: 100,
        canAddToCart: true,
        isQtyAdjusted: false,
        hasInsufficientInventory: false,
        canBackOrder: true,
        salePriceLabel: 'Sale',
        isSubscription: false,
        productSubscription: ProductSubscriptionDto(),
        isRestricted: false,
        isActive: true,
        brand: Brand(id: 'brand1', name: 'Test Brand'),
        status: 'Active',
        notes: 'Test notes',
        vmiBinId: 'bin123',
        sectionOptions: [
          SectionOptionDto(
            sectionOptionId: '1',
            sectionName: 'Color',
            optionName: 'Blue',
          )
        ],
        allowZeroPricing: false,
      );

      // Act
      final entity = CartLineEntityMapper.toEntity(model);

      // Assert
      expect(entity.productUri, equals(model.productUri));
      expect(entity.id, equals(model.id));
      expect(entity.line, equals(model.line));
      expect(entity.productId, equals(model.productId));
      expect(entity.requisitionId, equals(model.requisitionId));
      expect(entity.smallImagePath, equals(model.smallImagePath));
      expect(entity.altText, equals(model.altText));
      expect(entity.qtyOrdered, equals(model.qtyOrdered));
      expect(entity.productName, equals(model.productName));
      expect(entity.manufacturerItem, equals(model.manufacturerItem));
      expect(entity.customerName, equals(model.customerName));
      expect(entity.shortDescription, equals(model.shortDescription));
      expect(entity.erpNumber, equals(model.erpNumber));
      expect(entity.unitOfMeasureDisplay, equals(model.unitOfMeasureDisplay));
      expect(entity.unitOfMeasureDescription,
          equals(model.unitOfMeasureDescription));
      expect(entity.baseUnitOfMeasure, equals(model.baseUnitOfMeasure));
      expect(entity.baseUnitOfMeasureDisplay,
          equals(model.baseUnitOfMeasureDisplay));
      expect(entity.qtyPerBaseUnitOfMeasure,
          equals(model.qtyPerBaseUnitOfMeasure));
      expect(entity.costCode, equals(model.costCode));
      expect(entity.qtyLeft, equals(model.qtyLeft));
      expect(entity.isPromotionItem, equals(model.isPromotionItem));
      expect(entity.isDiscounted, equals(model.isDiscounted));
      expect(entity.isFixedConfiguration, equals(model.isFixedConfiguration));
      expect(entity.quoteRequired, equals(model.quoteRequired));
      expect(entity.breakPrices?.length, equals(1));
      expect(entity.qtyOnHand, equals(model.qtyOnHand));
      expect(entity.canAddToCart, equals(model.canAddToCart));
      expect(entity.isQtyAdjusted, equals(model.isQtyAdjusted));
      expect(entity.hasInsufficientInventory,
          equals(model.hasInsufficientInventory));
      expect(entity.canBackOrder, equals(model.canBackOrder));
      expect(entity.salePriceLabel, equals(model.salePriceLabel));
      expect(entity.isSubscription, equals(model.isSubscription));
      expect(entity.isRestricted, equals(model.isRestricted));
      expect(entity.isActive, equals(model.isActive));
      expect(entity.status, equals(model.status));
      expect(entity.notes, equals(model.notes));
      expect(entity.vmiBinId, equals(model.vmiBinId));
      expect(entity.sectionOptions?.length, equals(1));
      expect(entity.allowZeroPricing, equals(model.allowZeroPricing));
      expect(entity.brand?.id, equals('brand1'));
      expect(entity.availability?.message, equals('In Stock'));
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      final entity = CartLineEntity(
        productUri: 'uri://test',
        id: 'line123',
        line: 1,
        productId: 'product123',
        requisitionId: 'req123',
        smallImagePath: '/images/small.jpg',
        altText: 'Product Image',
        qtyOrdered: 3,
        productName: 'Test Product',
        manufacturerItem: 'MFR123',
        customerName: 'Custom Name',
        shortDescription: 'Short description',
        erpNumber: 'ERP123',
        unitOfMeasure: 'EA',
        unitOfMeasureDisplay: 'Each',
        unitOfMeasureDescription: 'Each item',
        baseUnitOfMeasure: 'EA',
        baseUnitOfMeasureDisplay: 'Each',
        qtyPerBaseUnitOfMeasure: 1,
        costCode: 'CC123',
        qtyLeft: 97,
        pricing: const ProductPriceEntity(unitNetPrice: 19.99),
        isPromotionItem: false,
        isDiscounted: true,
        isFixedConfiguration: false,
        quoteRequired: false,
        breakPrices: [BreakPriceDTOEntity(breakQty: 10, breakPrice: 9.99)],
        availability: const AvailabilityEntity(message: 'In Stock'),
        qtyOnHand: 100,
        canAddToCart: true,
        isQtyAdjusted: false,
        hasInsufficientInventory: false,
        canBackOrder: true,
        salePriceLabel: 'Sale',
        isSubscription: false,
        productSubscription: ProductSubscriptionEntity(),
        isRestricted: false,
        isActive: true,
        brand: const BrandEntity(id: 'brand1', name: 'Test Brand'),
        status: 'Active',
        notes: 'Test notes',
        vmiBinId: 'bin123',
        sectionOptions: [
          SectionOptionEntity(
            sectionOptionId: '1',
            sectionName: 'Color',
            optionName: 'Blue',
          )
        ],
        allowZeroPricing: false,
      );

      // Act
      final model = CartLineEntityMapper.toModel(entity);

      // Assert
      expect(model.productUri, equals(entity.productUri));
      expect(model.id, equals(entity.id));
      expect(model.line, equals(entity.line));
      expect(model.productId, equals(entity.productId));
      expect(model.requisitionId, equals(entity.requisitionId));
      expect(model.smallImagePath, equals(entity.smallImagePath));
      expect(model.altText, equals(entity.altText));
      expect(model.qtyOrdered, equals(entity.qtyOrdered));
      expect(model.productName, equals(entity.productName));
      expect(model.manufacturerItem, equals(entity.manufacturerItem));
      expect(model.customerName, equals(entity.customerName));
      expect(model.shortDescription, equals(entity.shortDescription));
      expect(model.erpNumber, equals(entity.erpNumber));
      expect(model.unitOfMeasure, equals(entity.unitOfMeasure));
      expect(model.unitOfMeasureDisplay, equals(entity.unitOfMeasureDisplay));
      expect(model.unitOfMeasureDescription,
          equals(entity.unitOfMeasureDescription));
      expect(model.baseUnitOfMeasure, equals(entity.baseUnitOfMeasure));
      expect(model.baseUnitOfMeasureDisplay,
          equals(entity.baseUnitOfMeasureDisplay));
      expect(model.qtyPerBaseUnitOfMeasure,
          equals(entity.qtyPerBaseUnitOfMeasure));
      expect(model.costCode, equals(entity.costCode));
      expect(model.qtyLeft, equals(entity.qtyLeft));
      expect(model.pricing?.unitNetPrice, equals(19.99));
      expect(model.isPromotionItem, equals(entity.isPromotionItem));
      expect(model.isDiscounted, equals(entity.isDiscounted));
      expect(model.isFixedConfiguration, equals(entity.isFixedConfiguration));
      expect(model.quoteRequired, equals(entity.quoteRequired));
      expect(model.breakPrices?.length, equals(1));
      expect(model.breakPrices?[0].breakQty, equals(10));
      expect(model.availability?.message, equals('In Stock'));
      expect(model.qtyOnHand, equals(entity.qtyOnHand));
      expect(model.canAddToCart, equals(entity.canAddToCart));
      expect(model.isQtyAdjusted, equals(entity.isQtyAdjusted));
      expect(model.hasInsufficientInventory,
          equals(entity.hasInsufficientInventory));
      expect(model.canBackOrder, equals(entity.canBackOrder));
      expect(model.salePriceLabel, equals(entity.salePriceLabel));
      expect(model.isSubscription, equals(entity.isSubscription));
      expect(model.isRestricted, equals(entity.isRestricted));
      expect(model.isActive, equals(entity.isActive));
      expect(model.brand?.id, equals('brand1'));
      expect(model.status, equals(entity.status));
      expect(model.notes, equals(entity.notes));
      expect(model.vmiBinId, equals(entity.vmiBinId));
      expect(model.sectionOptions?.length, equals(1));
      expect(model.allowZeroPricing, equals(entity.allowZeroPricing));
    });

    test(
        'toModel should handle entity with null properties and provide defaults',
        () {
      // Arrange
      const entity = CartLineEntity();

      // Act
      final model = CartLineEntityMapper.toModel(entity);

      // Assert
      expect(model.id, isNull);
      expect(model.productName, isNull);
      expect(model.pricing, isNotNull); // Default ProductPrice is provided
      expect(model.availability, isNotNull); // Default Availability is provided
      expect(model.productSubscription,
          isNotNull); // Default ProductSubscriptionDto is provided
      expect(model.brand, isNotNull); // Default Brand is provided
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = CartLine(
        id: 'cart123',
        line: 1,
        productId: 'product123',
        productName: 'Test Product',
        qtyOrdered: 5,
        pricing: ProductPrice(unitNetPrice: 29.99),
      );

      // Act
      final entity = CartLineEntityMapper.toEntity(originalModel);
      final resultModel = CartLineEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.line, equals(originalModel.line));
      expect(resultModel.productId, equals(originalModel.productId));
      expect(resultModel.productName, equals(originalModel.productName));
      expect(resultModel.qtyOrdered, equals(originalModel.qtyOrdered));
      expect(resultModel.pricing?.unitNetPrice,
          equals(originalModel.pricing?.unitNetPrice));
    });
  });

  group('SectionOptionEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = SectionOptionDto(
        sectionOptionId: 'option123',
        sectionName: 'Size',
        optionName: 'Large',
      );

      // Act
      final entity = SectionOptionEntityMapper.toEntity(model);

      // Assert
      expect(entity.sectionOptionId, equals(model.sectionOptionId));
      expect(entity.sectionName, equals(model.sectionName));
      expect(entity.optionName, equals(model.optionName));
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      final entity = SectionOptionEntity(
        sectionOptionId: 'option123',
        sectionName: 'Color',
        optionName: 'Green',
      );

      // Act
      final model = SectionOptionEntityMapper.toModel(entity);

      // Assert
      expect(model.sectionOptionId, equals(entity.sectionOptionId));
      expect(model.sectionName, equals(entity.sectionName));
      expect(model.optionName, equals(entity.optionName));
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = SectionOptionDto(
        sectionOptionId: 'option456',
        sectionName: 'Material',
        optionName: 'Cotton',
      );

      // Act
      final entity = SectionOptionEntityMapper.toEntity(originalModel);
      final resultModel = SectionOptionEntityMapper.toModel(entity);

      // Assert
      expect(
          resultModel.sectionOptionId, equals(originalModel.sectionOptionId));
      expect(resultModel.sectionName, equals(originalModel.sectionName));
      expect(resultModel.optionName, equals(originalModel.optionName));
    });
  });

  group('ProductSubscriptionEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = ProductSubscriptionDto(
        subscriptionAddToInitialOrder: true,
        subscriptionAllMonths: true,
        subscriptionJanuary: true,
        subscriptionFebruary: false,
        subscriptionMarch: true,
        subscriptionApril: false,
        subscriptionMay: true,
        subscriptionJune: false,
        subscriptionJuly: true,
        subscriptionAugust: false,
        subscriptionSeptember: true,
        subscriptionOctober: false,
        subscriptionNovember: true,
        subscriptionDecember: false,
        subscriptionCyclePeriod: 'Monthly',
        subscriptionFixedPrice: true,
        subscriptionPeriodsPerCycle: 12,
        subscriptionShipViaId: 'shipvia123',
        subscriptionTotalCycles: 4,
      );

      // Act
      final entity = ProductSubscriptionEntityMapper.toEntity(model);

      // Assert
      expect(entity.subscriptionAddToInitialOrder,
          equals(model.subscriptionAddToInitialOrder));
      expect(entity.subscriptionAllMonths, equals(model.subscriptionAllMonths));
      expect(entity.subscriptionJanuary, equals(model.subscriptionJanuary));
      expect(entity.subscriptionFebruary, equals(model.subscriptionFebruary));
      expect(entity.subscriptionMarch, equals(model.subscriptionMarch));
      expect(entity.subscriptionApril, equals(model.subscriptionApril));
      expect(entity.subscriptionMay, equals(model.subscriptionMay));
      expect(entity.subscriptionJune, equals(model.subscriptionJune));
      expect(entity.subscriptionJuly, equals(model.subscriptionJuly));
      expect(entity.subscriptionAugust, equals(model.subscriptionAugust));
      expect(entity.subscriptionSeptember, equals(model.subscriptionSeptember));
      expect(entity.subscriptionOctober, equals(model.subscriptionOctober));
      expect(entity.subscriptionNovember, equals(model.subscriptionNovember));
      expect(entity.subscriptionDecember, equals(model.subscriptionDecember));
      expect(entity.subscriptionCyclePeriod,
          equals(model.subscriptionCyclePeriod));
      expect(
          entity.subscriptionFixedPrice, equals(model.subscriptionFixedPrice));
      expect(entity.subscriptionPeriodsPerCycle,
          equals(model.subscriptionPeriodsPerCycle));
      expect(entity.subscriptionShipViaId, equals(model.subscriptionShipViaId));
      expect(entity.subscriptionTotalCycles,
          equals(model.subscriptionTotalCycles));
    });

    test('toEntity should handle null model', () {
      // Act
      final entity = ProductSubscriptionEntityMapper.toEntity(null);

      // Assert
      expect(entity.subscriptionAddToInitialOrder, isNull);
      expect(entity.subscriptionAllMonths, isNull);
      expect(entity.subscriptionCyclePeriod, isNull);
      expect(entity.subscriptionFixedPrice, isNull);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      final entity = ProductSubscriptionEntity(
        subscriptionAddToInitialOrder: false,
        subscriptionAllMonths: false,
        subscriptionJanuary: false,
        subscriptionFebruary: true,
        subscriptionMarch: false,
        subscriptionApril: true,
        subscriptionMay: false,
        subscriptionJune: true,
        subscriptionJuly: false,
        subscriptionAugust: true,
        subscriptionSeptember: false,
        subscriptionOctober: true,
        subscriptionNovember: false,
        subscriptionDecember: true,
        subscriptionCyclePeriod: 'Quarterly',
        subscriptionFixedPrice: true,
        subscriptionPeriodsPerCycle: 4,
        subscriptionShipViaId: 'shipvia456',
        subscriptionTotalCycles: 8,
      );

      // Act
      final model = ProductSubscriptionEntityMapper.toModel(entity);

      // Assert
      expect(model.subscriptionAddToInitialOrder,
          equals(entity.subscriptionAddToInitialOrder));
      expect(model.subscriptionAllMonths, equals(entity.subscriptionAllMonths));
      expect(model.subscriptionJanuary, equals(entity.subscriptionJanuary));
      expect(model.subscriptionFebruary, equals(entity.subscriptionFebruary));
      expect(model.subscriptionMarch, equals(entity.subscriptionMarch));
      expect(model.subscriptionApril, equals(entity.subscriptionApril));
      expect(model.subscriptionMay, equals(entity.subscriptionMay));
      expect(model.subscriptionJune, equals(entity.subscriptionJune));
      expect(model.subscriptionJuly, equals(entity.subscriptionJuly));
      expect(model.subscriptionAugust, equals(entity.subscriptionAugust));
      expect(model.subscriptionSeptember, equals(entity.subscriptionSeptember));
      expect(model.subscriptionOctober, equals(entity.subscriptionOctober));
      expect(model.subscriptionNovember, equals(entity.subscriptionNovember));
      expect(model.subscriptionDecember, equals(entity.subscriptionDecember));
      expect(model.subscriptionCyclePeriod,
          equals(entity.subscriptionCyclePeriod));
      expect(
          model.subscriptionFixedPrice, equals(entity.subscriptionFixedPrice));
      expect(model.subscriptionPeriodsPerCycle,
          equals(entity.subscriptionPeriodsPerCycle));
      expect(model.subscriptionShipViaId, equals(entity.subscriptionShipViaId));
      expect(model.subscriptionTotalCycles,
          equals(entity.subscriptionTotalCycles));
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = ProductSubscriptionDto(
        subscriptionAddToInitialOrder: true,
        subscriptionAllMonths: false,
        subscriptionJanuary: true,
        subscriptionCyclePeriod: 'Yearly',
        subscriptionFixedPrice: true,
        subscriptionTotalCycles: 3,
      );

      // Act
      final entity = ProductSubscriptionEntityMapper.toEntity(originalModel);
      final resultModel = ProductSubscriptionEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.subscriptionAddToInitialOrder,
          equals(originalModel.subscriptionAddToInitialOrder));
      expect(resultModel.subscriptionAllMonths,
          equals(originalModel.subscriptionAllMonths));
      expect(resultModel.subscriptionJanuary,
          equals(originalModel.subscriptionJanuary));
      expect(resultModel.subscriptionCyclePeriod,
          equals(originalModel.subscriptionCyclePeriod));
      expect(resultModel.subscriptionFixedPrice,
          equals(originalModel.subscriptionFixedPrice));
      expect(resultModel.subscriptionTotalCycles,
          equals(originalModel.subscriptionTotalCycles));
    });
  });
}
