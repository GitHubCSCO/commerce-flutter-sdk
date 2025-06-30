import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/pricing_rfq_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/break_price_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/quote_line_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('QuoteLineEntityMapper', () {
    test('should correctly map QuoteLine to QuoteLineEntity', () {
      // Arrange
      final quoteLine = QuoteLine(
        pricingRfq: PricingRfq(
          unitCost: 50.0,
          unitCostDisplay: '\$50.00',
          listPrice: 100.0,
          listPriceDisplay: '\$100.00',
          customerPrice: 90.0,
          customerPriceDisplay: '\$90.00',
          minimumPriceAllowed: 80.0,
          minimumPriceAllowedDisplay: '\$80.00',
          maxDiscountPct: 20.0,
          minMarginAllowed: 10.0,
          showListPrice: true,
          showCustomerPrice: true,
          showUnitCost: false,
          priceBreaks: [
            BreakPrice(
              startQty: 1,
              startQtyDisplay: '1',
              endQty: 10,
              endQtyDisplay: '10',
              price: 90.0,
              priceDispaly: '\$90.00',
              percent: 10,
              calculationMethod: 'percentage',
            ),
          ],
          calculationMethods: [
            CalculationMethod(
              value: 'percentage',
              name: 'Percentage',
              displayName: 'Percentage Discount',
              maximumDiscount: '20',
              minimumMargin: '10',
            ),
          ],
          validationMessages: [
            ValidationMessage(key: 'error', value: 'Invalid price'),
          ],
        ),
        maxQty: 100,
      )
        ..productId = 'P123'
        ..altText = 'Product alt text'
        ..availability = AvailabilityEntityMapper.toModel(
            const AvailabilityEntity(messageType: 1, message: 'In Stock'))
        ..baseUnitOfMeasure = 'Each'
        ..baseUnitOfMeasureDisplay = 'Each Unit'
        ..brand = BrandEntityMapper.toModel(
            const BrandEntity(id: 'B123', name: 'Test Brand'))
        ..breakPrices = [
          BreakPriceDtoEntityMapper.toModel(BreakPriceDTOEntity(
            breakQty: 5,
            breakPrice: 85.0,
            breakPriceDisplay: '\$85.00',
            savingsMessage: 'Save 15%',
          ))
        ]
        ..canAddToCart = true
        ..canBackOrder = false
        ..costCode = 'CC001'
        ..customerName = 'John Doe'
        ..erpNumber = 'ERP123'
        ..hasInsufficientInventory = false
        ..id = 'QL123'
        ..isActive = true
        ..isDiscounted = false
        ..isFixedConfiguration = true
        ..isPromotionItem = false
        ..isQtyAdjusted = false
        ..isRestricted = false
        ..isSubscription = false
        ..line = 1
        ..manufacturerItem = 'MANU123'
        ..notes = 'Special notes'
        ..pricing = ProductPriceEntityMapper.toModel(const ProductPriceEntity(
          unitRegularPrice: 100.0,
          unitNetPrice: 90.0,
          unitRegularPriceDisplay: '\$100.00',
          unitNetPriceDisplay: '\$90.00',
        ))
        ..productName = 'Test Product'
        ..productUri = 'https://example.com/product/123'
        ..qtyLeft = 15
        ..qtyOnHand = 20
        ..qtyOrdered = 5
        ..qtyPerBaseUnitOfMeasure = 1.0
        ..quoteRequired = true
        ..requisitionId = 'REQ123'
        ..salePriceLabel = 'Sale Price'
        ..shortDescription = 'Short product description'
        ..smallImagePath = '/images/product.jpg'
        ..status = 'Available'
        ..unitOfMeasure = 'Each'
        ..unitOfMeasureDescription = 'Each unit'
        ..unitOfMeasureDisplay = 'Each'
        ..vmiBinId = 'VMI123'
        ..allowZeroPricing = false;

      // Act
      final result = QuoteLineEntityMapper.toEntity(quoteLine);

      // Assert
      expect(result.pricingRfq, isNotNull);
      expect(result.pricingRfq?.unitCost, 50.0);
      expect(result.pricingRfq?.unitCostDisplay, '\$50.00');
      expect(result.pricingRfq?.listPrice, 100.0);
      expect(result.pricingRfq?.listPriceDisplay, '\$100.00');
      expect(result.pricingRfq?.customerPrice, 90.0);
      expect(result.pricingRfq?.customerPriceDisplay, '\$90.00');
      expect(result.pricingRfq?.minimumPriceAllowed, 80.0);
      expect(result.pricingRfq?.minimumPriceAllowedDisplay, '\$80.00');
      expect(result.pricingRfq?.maxDiscountPct, 20.0);
      expect(result.pricingRfq?.minMarginAllowed, 10.0);
      expect(result.pricingRfq?.showListPrice, true);
      expect(result.pricingRfq?.showCustomerPrice, true);
      expect(result.pricingRfq?.showUnitCost, false);
      expect(result.pricingRfq?.priceBreaks, hasLength(1));
      expect(result.pricingRfq?.calculationMethods, hasLength(1));
      expect(result.pricingRfq?.validationMessages, hasLength(1));
      expect(result.maxQty, 100);
      expect(result.altText, 'Product alt text');
      expect(result.availability, isNotNull);
      expect(result.baseUnitOfMeasure, 'Each');
      expect(result.baseUnitOfMeasureDisplay, 'Each Unit');
      expect(result.brand, isNotNull);
      expect(result.breakPrices, hasLength(1));
      expect(result.canAddToCart, true);
      expect(result.canBackOrder, false);
      expect(result.costCode, 'CC001');
      expect(result.customerName, 'John Doe');
      expect(result.erpNumber, 'ERP123');
      expect(result.hasInsufficientInventory, false);
      expect(result.id, 'QL123');
      expect(result.isActive, true);
      expect(result.isDiscounted, false);
      expect(result.isFixedConfiguration, true);
      expect(result.isPromotionItem, false);
      expect(result.isQtyAdjusted, false);
      expect(result.isRestricted, false);
      expect(result.isSubscription, false);
      expect(result.line, 1);
      expect(result.manufacturerItem, 'MANU123');
      expect(result.notes, 'Special notes');
      expect(result.pricing, isNotNull);
      expect(result.productId, 'P123');
      expect(result.productName, 'Test Product');
      expect(result.productUri, 'https://example.com/product/123');
      expect(result.qtyLeft, 15);
      expect(result.qtyOnHand, 20);
      expect(result.qtyOrdered, 5);
      expect(result.qtyPerBaseUnitOfMeasure, 1.0);
      expect(result.quoteRequired, true);
      expect(result.requisitionId, 'REQ123');
      expect(result.salePriceLabel, 'Sale Price');
      expect(result.shortDescription, 'Short product description');
      expect(result.smallImagePath, '/images/product.jpg');
      expect(result.status, 'Available');
      expect(result.unitOfMeasure, 'Each');
      expect(result.unitOfMeasureDescription, 'Each unit');
      expect(result.unitOfMeasureDisplay, 'Each');
      expect(result.vmiBinId, 'VMI123');
      expect(result.allowZeroPricing, false);
    });

    test('should correctly map QuoteLineEntity to QuoteLine', () {
      // Arrange
      final quoteLineEntity = QuoteLineEntity(
        pricingRfq: const PricingRfqEntity(
          unitCost: 60.0,
          unitCostDisplay: '\$60.00',
          listPrice: 120.0,
          listPriceDisplay: '\$120.00',
          customerPrice: 110.0,
          customerPriceDisplay: '\$110.00',
          minimumPriceAllowed: 90.0,
          minimumPriceAllowedDisplay: '\$90.00',
          maxDiscountPct: 25.0,
          minMarginAllowed: 15.0,
          showListPrice: false,
          showCustomerPrice: false,
          showUnitCost: true,
          priceBreaks: [
            BreakPriceEntity(
              startQty: 1,
              startQtyDisplay: '1',
              endQty: 5,
              endQtyDisplay: '5',
              price: 110.0,
              priceDisplay: '\$110.00',
              percent: 5,
              calculationMethod: 'fixed',
            ),
          ],
          calculationMethods: [
            CalculationMethodEntity(
              value: 'fixed',
              name: 'Fixed',
              displayName: 'Fixed Discount',
              maximumDiscount: '25',
              minimumMargin: '15',
            ),
          ],
          validationMessages: [
            ValidationMessageEntity(key: 'warning', value: 'Check price'),
          ],
        ),
        maxQty: 50,
        altText: 'Entity alt text',
        availability:
            const AvailabilityEntity(messageType: 2, message: 'Out of Stock'),
        baseUnitOfMeasure: 'Box',
        baseUnitOfMeasureDisplay: 'Box Unit',
        brand: const BrandEntity(id: 'B456', name: 'Entity Brand'),
        breakPrices: [
          BreakPriceDTOEntity(
            breakQty: 10,
            breakPrice: 95.0,
            breakPriceDisplay: '\$95.00',
            savingsMessage: 'Save 20%',
          )
        ],
        canAddToCart: false,
        canBackOrder: true,
        costCode: 'CC002',
        customerName: 'Jane Smith',
        erpNumber: 'ERP456',
        hasInsufficientInventory: true,
        id: 'QL456',
        isActive: false,
        isDiscounted: true,
        isFixedConfiguration: false,
        isPromotionItem: true,
        isQtyAdjusted: true,
        isRestricted: true,
        isSubscription: true,
        line: 2,
        manufacturerItem: 'MANU456',
        notes: 'Entity notes',
        pricing: const ProductPriceEntity(
          unitRegularPrice: 120.0,
          unitNetPrice: 110.0,
          unitRegularPriceDisplay: '\$120.00',
          unitNetPriceDisplay: '\$110.00',
        ),
        productId: 'P456',
        productName: 'Entity Product',
        productUri: 'https://example.com/product/456',
        qtyLeft: 25,
        qtyOnHand: 30,
        qtyOrdered: 10,
        qtyPerBaseUnitOfMeasure: 2.0,
        quoteRequired: false,
        requisitionId: 'REQ456',
        salePriceLabel: 'Discounted Price',
        shortDescription: 'Entity product description',
        smallImagePath: '/images/entity-product.jpg',
        status: 'Backordered',
        unitOfMeasure: 'Box',
        unitOfMeasureDescription: 'Box unit',
        unitOfMeasureDisplay: 'Box',
        vmiBinId: 'VMI456',
        allowZeroPricing: true,
      );

      // Act
      final result = QuoteLineEntityMapper.toModel(quoteLineEntity);

      // Assert
      expect(result, isNotNull);
      expect(result!.pricingRfq, isNotNull);
      expect(result.pricingRfq?.unitCost, 60.0);
      expect(result.pricingRfq?.unitCostDisplay, '\$60.00');
      expect(result.pricingRfq?.listPrice, 120.0);
      expect(result.pricingRfq?.listPriceDisplay, '\$120.00');
      expect(result.pricingRfq?.customerPrice, 110.0);
      expect(result.pricingRfq?.customerPriceDisplay, '\$110.00');
      expect(result.pricingRfq?.minimumPriceAllowed, 90.0);
      expect(result.pricingRfq?.minimumPriceAllowedDisplay, '\$90.00');
      expect(result.pricingRfq?.maxDiscountPct, 25.0);
      expect(result.pricingRfq?.minMarginAllowed, 15.0);
      expect(result.pricingRfq?.showListPrice, false);
      expect(result.pricingRfq?.showCustomerPrice, false);
      expect(result.pricingRfq?.showUnitCost, true);
      expect(result.pricingRfq?.priceBreaks, hasLength(1));
      expect(result.pricingRfq?.calculationMethods, hasLength(1));
      expect(result.pricingRfq?.validationMessages, hasLength(1));
      expect(result.maxQty, 50);
      expect(result.altText, 'Entity alt text');
      expect(result.availability, isNotNull);
      expect(result.baseUnitOfMeasure, 'Box');
      expect(result.baseUnitOfMeasureDisplay, 'Box Unit');
      expect(result.brand, isNotNull);
      expect(result.breakPrices, hasLength(1));
      expect(result.canAddToCart, false);
      expect(result.canBackOrder, true);
      expect(result.costCode, 'CC002');
      expect(result.customerName, 'Jane Smith');
      expect(result.erpNumber, 'ERP456');
      expect(result.hasInsufficientInventory, true);
      expect(result.id, 'QL456');
      expect(result.isActive, false);
      expect(result.isDiscounted, true);
      expect(result.isFixedConfiguration, false);
      expect(result.isPromotionItem, true);
      expect(result.isQtyAdjusted, true);
      expect(result.isRestricted, true);
      expect(result.isSubscription, true);
      expect(result.line, 2);
      expect(result.manufacturerItem, 'MANU456');
      expect(result.notes, 'Entity notes');
      expect(result.pricing, isNotNull);
      expect(result.productId, 'P456');
      expect(result.productName, 'Entity Product');
      expect(result.productUri, 'https://example.com/product/456');
      expect(result.qtyLeft, 25);
      expect(result.qtyOnHand, 30);
      expect(result.qtyOrdered, 10);
      expect(result.qtyPerBaseUnitOfMeasure, 2.0);
      expect(result.quoteRequired, false);
      expect(result.requisitionId, 'REQ456');
      expect(result.salePriceLabel, 'Discounted Price');
      expect(result.shortDescription, 'Entity product description');
      expect(result.smallImagePath, '/images/entity-product.jpg');
      expect(result.status, 'Backordered');
      expect(result.unitOfMeasure, 'Box');
      expect(result.unitOfMeasureDescription, 'Box unit');
      expect(result.unitOfMeasureDisplay, 'Box');
      expect(result.vmiBinId, 'VMI456');
      expect(result.allowZeroPricing, true);
    });

    test('should handle null QuoteLine input', () {
      // Act
      final result = QuoteLineEntityMapper.toEntity(null);

      // Assert
      expect(result.pricingRfq, isNull);
      expect(result.maxQty, isNull);
      expect(result.altText, isNull);
      expect(result.availability, isNull);
      expect(result.productId, isNull);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalQuoteLine = QuoteLine(
        pricingRfq: PricingRfq(
          unitCost: 45.0,
          unitCostDisplay: '\$45.00',
          listPrice: 95.0,
          listPriceDisplay: '\$95.00',
        ),
        maxQty: 75,
      )
        ..productId = 'P789'
        ..productName = 'Roundtrip Product'
        ..qtyOrdered = 3
        ..canAddToCart = true;

      // Act
      final entity = QuoteLineEntityMapper.toEntity(originalQuoteLine);
      final convertedBack = QuoteLineEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack, isNotNull);
      expect(convertedBack!.pricingRfq?.unitCost,
          originalQuoteLine.pricingRfq?.unitCost);
      expect(convertedBack.pricingRfq?.unitCostDisplay,
          originalQuoteLine.pricingRfq?.unitCostDisplay);
      expect(convertedBack.pricingRfq?.listPrice,
          originalQuoteLine.pricingRfq?.listPrice);
      expect(convertedBack.pricingRfq?.listPriceDisplay,
          originalQuoteLine.pricingRfq?.listPriceDisplay);
      expect(convertedBack.maxQty, originalQuoteLine.maxQty);
      expect(convertedBack.productId, originalQuoteLine.productId);
      expect(convertedBack.productName, originalQuoteLine.productName);
      expect(convertedBack.qtyOrdered, originalQuoteLine.qtyOrdered);
      expect(convertedBack.canAddToCart, originalQuoteLine.canAddToCart);
    });
  });

  group('PricingRfqEntityMapper', () {
    test('should correctly map PricingRfq to PricingRfqEntity', () {
      // Arrange
      final pricingRfq = PricingRfq(
        unitCost: 40.0,
        unitCostDisplay: '\$40.00',
        listPrice: 85.0,
        listPriceDisplay: '\$85.00',
        customerPrice: 75.0,
        customerPriceDisplay: '\$75.00',
        minimumPriceAllowed: 65.0,
        minimumPriceAllowedDisplay: '\$65.00',
        maxDiscountPct: 15.0,
        minMarginAllowed: 8.0,
        showListPrice: true,
        showCustomerPrice: false,
        showUnitCost: true,
        priceBreaks: [
          BreakPrice(
            startQty: 1,
            startQtyDisplay: '1',
            endQty: 15,
            endQtyDisplay: '15',
            price: 75.0,
            priceDispaly: '\$75.00',
            percent: 12,
            calculationMethod: 'percentage',
          ),
        ],
        calculationMethods: [
          CalculationMethod(
            value: 'percentage',
            name: 'Percentage',
            displayName: 'Percentage Discount',
            maximumDiscount: '15',
            minimumMargin: '8',
          ),
        ],
        validationMessages: [
          ValidationMessage(key: 'info', value: 'Price is valid'),
        ],
      );

      // Act
      final result = PricingRfqEntityMapper.toEntity(pricingRfq);

      // Assert
      expect(result.unitCost, 40.0);
      expect(result.unitCostDisplay, '\$40.00');
      expect(result.listPrice, 85.0);
      expect(result.listPriceDisplay, '\$85.00');
      expect(result.customerPrice, 75.0);
      expect(result.customerPriceDisplay, '\$75.00');
      expect(result.minimumPriceAllowed, 65.0);
      expect(result.minimumPriceAllowedDisplay, '\$65.00');
      expect(result.maxDiscountPct, 15.0);
      expect(result.minMarginAllowed, 8.0);
      expect(result.showListPrice, true);
      expect(result.showCustomerPrice, false);
      expect(result.showUnitCost, true);
      expect(result.priceBreaks, hasLength(1));
      expect(result.calculationMethods, hasLength(1));
      expect(result.validationMessages, hasLength(1));
    });

    test('should correctly map PricingRfqEntity to PricingRfq', () {
      // Arrange
      const pricingRfqEntity = PricingRfqEntity(
        unitCost: 35.0,
        unitCostDisplay: '\$35.00',
        listPrice: 80.0,
        listPriceDisplay: '\$80.00',
        customerPrice: 70.0,
        customerPriceDisplay: '\$70.00',
        minimumPriceAllowed: 60.0,
        minimumPriceAllowedDisplay: '\$60.00',
        maxDiscountPct: 12.0,
        minMarginAllowed: 6.0,
        showListPrice: false,
        showCustomerPrice: true,
        showUnitCost: false,
        priceBreaks: [
          BreakPriceEntity(
            startQty: 1,
            startQtyDisplay: '1',
            endQty: 20,
            endQtyDisplay: '20',
            price: 70.0,
            priceDisplay: '\$70.00',
            percent: 8,
            calculationMethod: 'fixed',
          ),
        ],
        calculationMethods: [
          CalculationMethodEntity(
            value: 'fixed',
            name: 'Fixed',
            displayName: 'Fixed Discount',
            maximumDiscount: '12',
            minimumMargin: '6',
          ),
        ],
        validationMessages: [
          ValidationMessageEntity(key: 'success', value: 'Price approved'),
        ],
      );

      // Act
      final result = PricingRfqEntityMapper.toModel(pricingRfqEntity);

      // Assert
      expect(result.unitCost, 35.0);
      expect(result.unitCostDisplay, '\$35.00');
      expect(result.listPrice, 80.0);
      expect(result.listPriceDisplay, '\$80.00');
      expect(result.customerPrice, 70.0);
      expect(result.customerPriceDisplay, '\$70.00');
      expect(result.minimumPriceAllowed, 60.0);
      expect(result.minimumPriceAllowedDisplay, '\$60.00');
      expect(result.maxDiscountPct, 12.0);
      expect(result.minMarginAllowed, 6.0);
      expect(result.showListPrice, false);
      expect(result.showCustomerPrice, true);
      expect(result.showUnitCost, false);
      expect(result.priceBreaks, hasLength(1));
      expect(result.calculationMethods, hasLength(1));
      expect(result.validationMessages, hasLength(1));
    });

    test('should handle null lists correctly', () {
      // Arrange
      final pricingRfq = PricingRfq(
        unitCost: 30.0,
        unitCostDisplay: '\$30.00',
        priceBreaks: null,
        calculationMethods: null,
        validationMessages: null,
      );

      // Act
      final result = PricingRfqEntityMapper.toEntity(pricingRfq);

      // Assert
      expect(result.unitCost, 30.0);
      expect(result.unitCostDisplay, '\$30.00');
      expect(result.priceBreaks, isNull);
      expect(result.calculationMethods, isNull);
      expect(result.validationMessages, isNull);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalPricingRfq = PricingRfq(
        unitCost: 25.0,
        unitCostDisplay: '\$25.00',
        listPrice: 55.0,
        listPriceDisplay: '\$55.00',
        showListPrice: true,
        showCustomerPrice: false,
        showUnitCost: true,
      );

      // Act
      final entity = PricingRfqEntityMapper.toEntity(originalPricingRfq);
      final convertedBack = PricingRfqEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.unitCost, originalPricingRfq.unitCost);
      expect(convertedBack.unitCostDisplay, originalPricingRfq.unitCostDisplay);
      expect(convertedBack.listPrice, originalPricingRfq.listPrice);
      expect(
          convertedBack.listPriceDisplay, originalPricingRfq.listPriceDisplay);
      expect(convertedBack.showListPrice, originalPricingRfq.showListPrice);
      expect(convertedBack.showCustomerPrice,
          originalPricingRfq.showCustomerPrice);
      expect(convertedBack.showUnitCost, originalPricingRfq.showUnitCost);
    });
  });

  group('CalculationMethodEntityMapper', () {
    test('should correctly map CalculationMethod to CalculationMethodEntity',
        () {
      // Arrange
      final calculationMethod = CalculationMethod(
        value: 'percentage',
        name: 'Percentage',
        displayName: 'Percentage Discount',
        maximumDiscount: '25',
        minimumMargin: '10',
      );

      // Act
      final result = CalculationMethodEntityMapper.toEntity(calculationMethod);

      // Assert
      expect(result.value, 'percentage');
      expect(result.name, 'Percentage');
      expect(result.displayName, 'Percentage Discount');
      expect(result.maximumDiscount, '25');
      expect(result.minimumMargin, '10');
    });

    test('should correctly map CalculationMethodEntity to CalculationMethod',
        () {
      // Arrange
      const calculationMethodEntity = CalculationMethodEntity(
        value: 'fixed',
        name: 'Fixed',
        displayName: 'Fixed Amount Discount',
        maximumDiscount: '50',
        minimumMargin: '15',
      );

      // Act
      final result =
          CalculationMethodEntityMapper.toModel(calculationMethodEntity);

      // Assert
      expect(result.value, 'fixed');
      expect(result.name, 'Fixed');
      expect(result.displayName, 'Fixed Amount Discount');
      expect(result.maximumDiscount, '50');
      expect(result.minimumMargin, '15');
    });

    test('should handle null values correctly', () {
      // Arrange
      final calculationMethod = CalculationMethod(
        value: null,
        name: null,
        displayName: null,
        maximumDiscount: null,
        minimumMargin: null,
      );

      // Act
      final result = CalculationMethodEntityMapper.toEntity(calculationMethod);

      // Assert
      expect(result.value, isNull);
      expect(result.name, isNull);
      expect(result.displayName, isNull);
      expect(result.maximumDiscount, isNull);
      expect(result.minimumMargin, isNull);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalCalculationMethod = CalculationMethod(
        value: 'tiered',
        name: 'Tiered',
        displayName: 'Tiered Pricing',
        maximumDiscount: '30',
        minimumMargin: '12',
      );

      // Act
      final entity =
          CalculationMethodEntityMapper.toEntity(originalCalculationMethod);
      final convertedBack = CalculationMethodEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.value, originalCalculationMethod.value);
      expect(convertedBack.name, originalCalculationMethod.name);
      expect(convertedBack.displayName, originalCalculationMethod.displayName);
      expect(convertedBack.maximumDiscount,
          originalCalculationMethod.maximumDiscount);
      expect(
          convertedBack.minimumMargin, originalCalculationMethod.minimumMargin);
    });
  });

  group('ValidationMessageEntityMapper', () {
    test('should correctly map ValidationMessage to ValidationMessageEntity',
        () {
      // Arrange
      final validationMessage = ValidationMessage(
        key: 'price_error',
        value: 'Price must be greater than minimum allowed',
      );

      // Act
      final result = ValidationMessageEntityMapper.toEntity(validationMessage);

      // Assert
      expect(result.key, 'price_error');
      expect(result.value, 'Price must be greater than minimum allowed');
    });

    test('should correctly map ValidationMessageEntity to ValidationMessage',
        () {
      // Arrange
      const validationMessageEntity = ValidationMessageEntity(
        key: 'quantity_warning',
        value: 'Quantity exceeds available stock',
      );

      // Act
      final result =
          ValidationMessageEntityMapper.toModel(validationMessageEntity);

      // Assert
      expect(result.key, 'quantity_warning');
      expect(result.value, 'Quantity exceeds available stock');
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final validationMessage = ValidationMessage(
        key: '',
        value: '',
      );

      // Act
      final result = ValidationMessageEntityMapper.toEntity(validationMessage);

      // Assert
      expect(result.key, '');
      expect(result.value, '');
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalValidationMessage = ValidationMessage(
        key: 'discount_info',
        value: 'Maximum discount applied',
      );

      // Act
      final entity =
          ValidationMessageEntityMapper.toEntity(originalValidationMessage);
      final convertedBack = ValidationMessageEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.key, originalValidationMessage.key);
      expect(convertedBack.value, originalValidationMessage.value);
    });
  });

  group('BreakPriceEntityMapper', () {
    test('should correctly map BreakPrice to BreakPriceEntity', () {
      // Arrange
      final breakPrice = BreakPrice(
        startQty: 1,
        startQtyDisplay: '1',
        endQty: 25,
        endQtyDisplay: '25',
        price: 45.99,
        priceDispaly: '\$45.99',
        percent: 15,
        calculationMethod: 'percentage',
      );

      // Act
      final result = BreakPriceEntityMapper.toEntity(breakPrice);

      // Assert
      expect(result.startQty, 1);
      expect(result.startQtyDisplay, '1');
      expect(result.endQty, 25);
      expect(result.endQtyDisplay, '25');
      expect(result.price, 45.99);
      expect(result.priceDisplay,
          '\$45.99'); // Note: entity uses priceDisplay, model uses priceDispaly (typo)
      expect(result.percent, 15);
      expect(result.calculationMethod, 'percentage');
    });

    test('should correctly map BreakPriceEntity to BreakPrice', () {
      // Arrange
      const breakPriceEntity = BreakPriceEntity(
        startQty: 5,
        startQtyDisplay: '5',
        endQty: 50,
        endQtyDisplay: '50',
        price: 38.75,
        priceDisplay: '\$38.75',
        percent: 20,
        calculationMethod: 'fixed',
      );

      // Act
      final result = BreakPriceEntityMapper.toModel(breakPriceEntity);

      // Assert
      expect(result.startQty, 5);
      expect(result.startQtyDisplay, '5');
      expect(result.endQty, 50);
      expect(result.endQtyDisplay, '50');
      expect(result.price, 38.75);
      expect(result.priceDispaly,
          '\$38.75'); // Note: model uses priceDispaly (typo)
      expect(result.percent, 20);
      expect(result.calculationMethod, 'fixed');
    });

    test('should handle null values correctly', () {
      // Arrange
      final breakPrice = BreakPrice(
        startQty: null,
        startQtyDisplay: null,
        endQty: null,
        endQtyDisplay: null,
        price: null,
        priceDispaly: null,
        percent: null,
        calculationMethod: null,
      );

      // Act
      final result = BreakPriceEntityMapper.toEntity(breakPrice);

      // Assert
      expect(result.startQty, isNull);
      expect(result.startQtyDisplay, isNull);
      expect(result.endQty, isNull);
      expect(result.endQtyDisplay, isNull);
      expect(result.price, isNull);
      expect(result.priceDisplay, isNull);
      expect(result.percent, isNull);
      expect(result.calculationMethod, isNull);
    });

    test('should handle zero quantities and prices', () {
      // Arrange
      final breakPrice = BreakPrice(
        startQty: 0,
        startQtyDisplay: '0',
        endQty: 0,
        endQtyDisplay: '0',
        price: 0.0,
        priceDispaly: '\$0.00',
        percent: 0,
        calculationMethod: 'none',
      );

      // Act
      final result = BreakPriceEntityMapper.toEntity(breakPrice);

      // Assert
      expect(result.startQty, 0);
      expect(result.startQtyDisplay, '0');
      expect(result.endQty, 0);
      expect(result.endQtyDisplay, '0');
      expect(result.price, 0.0);
      expect(result.priceDisplay, '\$0.00');
      expect(result.percent, 0);
      expect(result.calculationMethod, 'none');
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalBreakPrice = BreakPrice(
        startQty: 10,
        startQtyDisplay: '10',
        endQty: 100,
        endQtyDisplay: '100',
        price: 29.99,
        priceDispaly: '\$29.99',
        percent: 25,
        calculationMethod: 'volume',
      );

      // Act
      final entity = BreakPriceEntityMapper.toEntity(originalBreakPrice);
      final convertedBack = BreakPriceEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.startQty, originalBreakPrice.startQty);
      expect(convertedBack.startQtyDisplay, originalBreakPrice.startQtyDisplay);
      expect(convertedBack.endQty, originalBreakPrice.endQty);
      expect(convertedBack.endQtyDisplay, originalBreakPrice.endQtyDisplay);
      expect(convertedBack.price, originalBreakPrice.price);
      expect(convertedBack.priceDispaly, originalBreakPrice.priceDispaly);
      expect(convertedBack.percent, originalBreakPrice.percent);
      expect(convertedBack.calculationMethod,
          originalBreakPrice.calculationMethod);
    });
  });
}
