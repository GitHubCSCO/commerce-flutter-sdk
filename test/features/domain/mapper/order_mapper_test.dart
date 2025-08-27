import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_history_tax_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_promotion_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/shipment_package_dto_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/pagination_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/order_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('OrderEntityMapper', () {
    test('should correctly map Order to OrderEntity with all fields', () {
      // Arrange
      final orderDate = DateTime(2024, 1, 15, 10, 30);
      final modifyDate = DateTime(2024, 1, 16, 14, 45);
      final requestedDeliveryDate = DateTime(2024, 1, 20, 9, 0);

      final order = Order(
        id: "ORD-12345",
        erpOrderNumber: "ERP-67890",
        webOrderNumber: "WEB-11111",
        orderDate: orderDate,
        status: "Shipped",
        statusDisplay: "Order Shipped",
        customerNumber: "CUST-001",
        customerSequence: "SEQ-001",
        customerPO: "PO-2024-001",
        currencyCode: "USD",
        currencySymbol: "\$",
        terms: "Net 30",
        shipCode: "SHIP-001",
        salesperson: "John Sales",
        btCompanyName: "ACME Corp",
        btAddress1: "123 Main St",
        btAddress2: "Suite 100",
        billToCity: "New York",
        billToState: "NY",
        billToPostalCode: "10001",
        btCountry: "USA",
        stCompanyName: "ACME Warehouse",
        stAddress1: "456 Oak Ave",
        stAddress2: "Building B",
        stAddress3: "Floor 2",
        stAddress4: "Room 201",
        shipToCity: "Boston",
        shipToState: "MA",
        shipToPostalCode: "02101",
        stCountry: "USA",
        notes: "Special delivery instructions",
        productTotal: 1000.00,
        orderSubTotal: 1000.00,
        orderDiscountAmount: 50.00,
        productDiscountAmount: 25.00,
        shippingAndHandling: 75.00,
        shippingCharges: 50.00,
        handlingCharges: 25.00,
        otherCharges: 10.00,
        taxAmount: 85.00,
        orderTotal: 1120.00,
        modifyDate: modifyDate,
        requestedDeliveryDateDisplay: requestedDeliveryDate,
        orderLines: [
          OrderLine(
            id: "LINE-001",
            productId: "PROD-001",
            productName: "Test Product",
            qtyOrdered: 2,
            unitPrice: 500.00,
          ),
        ],
        orderPromotions: [
          OrderPromotion(
            id: "PROMO-001",
            name: "Holiday Discount",
            amount: 50.00,
            amountDisplay: "\$50.00",
          ),
        ],
        shipmentPackages: [
          ShipmentPackageDto(
            id: "PKG-001",
            carrier: "UPS",
            trackingNumber: "1Z999AA1234567890",
            shipmentDate: DateTime(2024, 1, 16),
          ),
        ],
        returnReasons: ["Defective", "Wrong Size"],
        orderHistoryTaxes: [
          OrderHistoryTaxDto(
            taxCode: "STATE",
            taxDescription: "State Tax",
            taxRate: 8.5,
            taxAmount: 85.00,
            taxAmountDisplay: "\$85.00",
            sortOrder: 1,
          ),
        ],
        productTotalDisplay: "\$1,000.00",
        orderSubTotalDisplay: "\$1,000.00",
        orderGrandTotalDisplay: "\$1,120.00",
        orderDiscountAmountDisplay: "\$50.00",
        productDiscountAmountDisplay: "\$25.00",
        taxAmountDisplay: "\$85.00",
        totalTaxDisplay: "\$85.00",
        shippingAndHandlingDisplay: "\$75.00",
        shippingChargesDisplay: "\$50.00",
        handlingChargesDisplay: "\$25.00",
        otherChargesDisplay: "\$10.00",
        canAddToCart: true,
        canAddAllToCart: true,
        showTaxAndShipping: true,
        shipViaDescription: "UPS Ground",
        fulfillmentMethod: "Ship",
        vmiLocationId: "VMI-001",
        vmiLocationName: "Main VMI Location",
        showWebOrderNumber: true,
        showPoNumber: true,
        showTermsCode: true,
        orderNumberLabel: "Order #",
        webOrderNumberLabel: "Web Order #",
        poNumberLabel: "PO #",
      );

      // Act
      final result = OrderEntityMapper.toEntity(order);

      // Assert
      expect(result.id, "ORD-12345");
      expect(result.erpOrderNumber, "ERP-67890");
      expect(result.webOrderNumber, "WEB-11111");
      expect(result.orderDate, orderDate);
      expect(result.status, "Shipped");
      expect(result.statusDisplay, "Order Shipped");
      expect(result.customerNumber, "CUST-001");
      expect(result.customerSequence, "SEQ-001");
      expect(result.customerPO, "PO-2024-001");
      expect(result.currencyCode, "USD");
      expect(result.currencySymbol, "\$");
      expect(result.terms, "Net 30");
      expect(result.shipCode, "SHIP-001");
      expect(result.salesperson, "John Sales");
      expect(result.btCompanyName, "ACME Corp");
      expect(result.btAddress1, "123 Main St");
      expect(result.btAddress2, "Suite 100");
      expect(result.billToCity, "New York");
      expect(result.billToState, "NY");
      expect(result.billToPostalCode, "10001");
      expect(result.btCountry, "USA");
      expect(result.stCompanyName, "ACME Warehouse");
      expect(result.stAddress1, "456 Oak Ave");
      expect(result.stAddress2, "Building B");
      expect(result.stAddress3, "Floor 2");
      expect(result.stAddress4, "Room 201");
      expect(result.shipToCity, "Boston");
      expect(result.shipToState, "MA");
      expect(result.shipToPostalCode, "02101");
      expect(result.stCountry, "USA");
      expect(result.notes, "Special delivery instructions");
      expect(result.productTotal, 1000.00);
      expect(result.orderSubTotal, 1000.00);
      expect(result.orderDiscountAmount, 50.00);
      expect(result.productDiscountAmount, 25.00);
      expect(result.shippingAndHandling, 75.00);
      expect(result.shippingCharges, 50.00);
      expect(result.handlingCharges, 25.00);
      expect(result.otherCharges, 10.00);
      expect(result.taxAmount, 85.00);
      expect(result.orderTotal, 1120.00);
      expect(result.modifyDate, modifyDate);
      expect(result.requestedDeliveryDateDisplay, requestedDeliveryDate);
      expect(result.productTotalDisplay, "\$1,000.00");
      expect(result.orderSubTotalDisplay, "\$1,000.00");
      expect(result.orderGrandTotalDisplay, "\$1,120.00");
      expect(result.orderDiscountAmountDisplay, "\$50.00");
      expect(result.productDiscountAmountDisplay, "\$25.00");
      expect(result.taxAmountDisplay, "\$85.00");
      expect(result.totalTaxDisplay, "\$85.00");
      expect(result.shippingAndHandlingDisplay, "\$75.00");
      expect(result.shippingChargesDisplay, "\$50.00");
      expect(result.handlingChargesDisplay, "\$25.00");
      expect(result.otherChargesDisplay, "\$10.00");
      expect(result.canAddToCart, true);
      expect(result.canAddAllToCart, true);
      expect(result.showTaxAndShipping, true);
      expect(result.shipViaDescription, "UPS Ground");
      expect(result.fulfillmentMethod, "Ship");
      expect(result.vmiLocationId, "VMI-001");
      expect(result.vmiLocationName, "Main VMI Location");
      expect(result.showWebOrderNumber, true);
      expect(result.showPoNumber, true);
      expect(result.showTermsCode, true);
      expect(result.orderNumberLabel, "Order #");
      expect(result.webOrderNumberLabel, "Web Order #");
      expect(result.poNumberLabel, "PO #");

      // Verify nested collections
      expect(result.orderLines, hasLength(1));
      expect(result.orderPromotions, hasLength(1));
      expect(result.shipmentPackages, hasLength(1));
      expect(result.returnReasons, hasLength(2));
      expect(result.orderHistoryTaxes, hasLength(1));
      expect(result.returnReasons?[0], "Defective");
      expect(result.returnReasons?[1], "Wrong Size");
    });

    test('should correctly map OrderEntity to Order with all fields', () {
      // Arrange
      const orderEntity = OrderEntity(
        id: "ORD-54321",
        erpOrderNumber: "ERP-09876",
        webOrderNumber: "WEB-22222",
        status: "Processing",
        statusDisplay: "Order Processing",
        customerNumber: "CUST-002",
        customerPO: "PO-2024-002",
        currencyCode: "EUR",
        currencySymbol: "€",
        productTotal: 2000.00,
        orderTotal: 2200.00,
        canAddToCart: false,
        canAddAllToCart: false,
        showTaxAndShipping: false,
        orderLines: [],
        orderPromotions: [],
        shipmentPackages: [],
        returnReasons: [],
        orderHistoryTaxes: [],
      );

      // Act
      final result = OrderEntityMapper.toModel(orderEntity);

      // Assert
      expect(result.id, "ORD-54321");
      expect(result.erpOrderNumber, "ERP-09876");
      expect(result.webOrderNumber, "WEB-22222");
      expect(result.status, "Processing");
      expect(result.statusDisplay, "Order Processing");
      expect(result.customerNumber, "CUST-002");
      expect(result.customerPO, "PO-2024-002");
      expect(result.currencyCode, "EUR");
      expect(result.currencySymbol, "€");
      expect(result.productTotal, 2000.00);
      expect(result.orderTotal, 2200.00);
      expect(result.canAddToCart, false);
      expect(result.canAddAllToCart, false);
      expect(result.showTaxAndShipping, false);
      expect(result.orderLines, hasLength(0));
      expect(result.orderPromotions, hasLength(0));
      expect(result.shipmentPackages, hasLength(0));
      expect(result.returnReasons, hasLength(0));
      expect(result.orderHistoryTaxes, hasLength(0));
    });

    test('should handle null values correctly', () {
      // Arrange
      final order = Order(
        id: "ORD-NULL",
        erpOrderNumber: null,
        webOrderNumber: null,
        orderDate: null,
        status: null,
        orderLines: null,
        orderPromotions: null,
        shipmentPackages: null,
        returnReasons: null,
        orderHistoryTaxes: null,
      );

      // Act
      final result = OrderEntityMapper.toEntity(order);

      // Assert
      expect(result.id, "ORD-NULL");
      expect(result.erpOrderNumber, isNull);
      expect(result.webOrderNumber, isNull);
      expect(result.orderDate, isNull);
      expect(result.status, isNull);
      expect(result.orderLines, isNull);
      expect(result.orderPromotions, isNull);
      expect(result.shipmentPackages, isNull);
      expect(result.returnReasons, isNull);
      expect(result.orderHistoryTaxes, isNull);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalOrder = Order(
        id: "ROUNDTRIP-001",
        erpOrderNumber: "ERP-ROUND",
        webOrderNumber: "WEB-ROUND",
        status: "Delivered",
        productTotal: 500.00,
        orderTotal: 550.00,
        orderLines: [],
        orderPromotions: [],
        shipmentPackages: [],
        returnReasons: ["Test Reason"],
        orderHistoryTaxes: [],
      );

      // Act
      final entity = OrderEntityMapper.toEntity(originalOrder);
      final convertedBack = OrderEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.id, originalOrder.id);
      expect(convertedBack.erpOrderNumber, originalOrder.erpOrderNumber);
      expect(convertedBack.webOrderNumber, originalOrder.webOrderNumber);
      expect(convertedBack.status, originalOrder.status);
      expect(convertedBack.productTotal, originalOrder.productTotal);
      expect(convertedBack.orderTotal, originalOrder.orderTotal);
      expect(convertedBack.returnReasons, originalOrder.returnReasons);
    });
  });

  group('OrderLineEntityMapper', () {
    test('should correctly map OrderLine to OrderLineEntity with all fields',
        () {
      // Arrange
      final requiredDate = DateTime(2024, 1, 25);
      final lastShipDate = DateTime(2024, 1, 20);

      final orderLine = OrderLine(
        id: "LINE-123",
        productId: "PROD-456",
        productUri: "https://example.com/product/456",
        mediumImagePath: "/images/product456_medium.jpg",
        altText: "Product 456 Image",
        productName: "Advanced Widget",
        manufacturerItem: "MFG-456",
        customerName: "Jane Customer",
        shortDescription: "High-quality advanced widget",
        productErpNumber: "ERP-PROD-456",
        customerProductNumber: "CUST-PROD-456",
        requiredDate: requiredDate,
        lastShipDate: lastShipDate,
        customerNumber: "CUST-002",
        customerSequence: "SEQ-002",
        lineType: "Product",
        status: "Shipped",
        lineNumber: 1,
        releaseNumber: 1,
        linePOReference: "PO-LINE-001",
        description: "Detailed product description",
        warehouse: "WH-001",
        notes: "Handle with care",
        qtyOrdered: 5,
        qtyShipped: 5,
        unitOfMeasure: "EA",
        unitOfMeasureDisplay: "Each",
        unitOfMeasureDescription: "Individual units",
        availability: Availability(messageType: 1, message: "In Stock"),
        inventoryQtyOrdered: 5,
        inventoryQtyShipped: 5,
        unitPrice: 200.00,
        unitNetPrice: 180.00,
        extendedUnitNetPrice: 900.00,
        discountPercent: 10.0,
        discountAmount: 100.00,
        unitDiscountAmount: 20.00,
        promotionAmountApplied: 50.00,
        totalDiscountAmount: 100.00,
        lineTotal: 900.00,
        totalRegularPrice: 1000.00,
        unitListPrice: 220.00,
        unitRegularPrice: 200.00,
        unitCost: 150.00,
        orderLineOtherCharges: 15.00,
        taxRate: 8.5,
        taxAmount: 76.50,
        returnReason: null,
        rmaQtyRequested: null,
        rmaQtyReceived: null,
        unitPriceDisplay: "\$200.00",
        unitNetPriceDisplay: "\$180.00",
        extendedUnitNetPriceDisplay: "\$900.00",
        discountAmountDisplay: "\$100.00",
        unitDiscountAmountDisplay: "\$20.00",
        totalDiscountAmountDisplay: "\$100.00",
        lineTotalDisplay: "\$900.00",
        totalRegularPriceDisplay: "\$1,000.00",
        unitListPriceDisplay: "\$220.00",
        unitRegularPriceDisplay: "\$200.00",
        unitCostDisplay: "\$150.00",
        orderLineOtherChargesDisplay: "\$15.00",
        costCode: "CC-001",
        canAddToCart: true,
        isActiveProduct: true,
        sectionOptions: [
          SectionOptionDto(
            sectionOptionId: "SO-001",
            sectionName: "Color",
            optionName: "Blue",
          ),
        ],
        salePriceLabel: "Sale Price",
        canAddToWishlist: true,
        brand: Brand(id: "BRAND-001", name: "Premium Brand"),
        netPriceWithVat: 195.30,
        netPriceWithVatDisplay: "\$195.30",
        unitPriceWithVat: 217.00,
        unitPriceWithVatDisplay: "\$217.00",
        vmiBinNumber: "VMI-BIN-001",
      )..properties = {"custom": "value"};

      // Act
      final result = OrderLineEntityMapper.toEntity(orderLine);

      // Assert
      expect(result.id, "LINE-123");
      expect(result.productId, "PROD-456");
      expect(result.productUri, "https://example.com/product/456");
      expect(result.mediumImagePath, "/images/product456_medium.jpg");
      expect(result.altText, "Product 456 Image");
      expect(result.productName, "Advanced Widget");
      expect(result.manufacturerItem, "MFG-456");
      expect(result.customerName, "Jane Customer");
      expect(result.shortDescription, "High-quality advanced widget");
      expect(result.productErpNumber, "ERP-PROD-456");
      expect(result.customerProductNumber, "CUST-PROD-456");
      expect(result.requiredDate, requiredDate);
      expect(result.lastShipDate, lastShipDate);
      expect(result.customerNumber, "CUST-002");
      expect(result.customerSequence, "SEQ-002");
      expect(result.lineType, "Product");
      expect(result.status, "Shipped");
      expect(result.lineNumber, 1);
      expect(result.releaseNumber, 1);
      expect(result.linePOReference, "PO-LINE-001");
      expect(result.description, "Detailed product description");
      expect(result.warehouse, "WH-001");
      expect(result.notes, "Handle with care");
      expect(result.qtyOrdered, 5);
      expect(result.qtyShipped, 5);
      expect(result.unitOfMeasure, "EA");
      expect(result.unitOfMeasureDisplay, "Each");
      expect(result.unitOfMeasureDescription, "Individual units");
      expect(result.inventoryQtyOrdered, 5);
      expect(result.inventoryQtyShipped, 5);
      expect(result.unitPrice, 200.00);
      expect(result.unitNetPrice, 180.00);
      expect(result.extendedUnitNetPrice, 900.00);
      expect(result.discountPercent, 10.0);
      expect(result.discountAmount, 100.00);
      expect(result.unitDiscountAmount, 20.00);
      expect(result.promotionAmountApplied, 50.00);
      expect(result.totalDiscountAmount, 100.00);
      expect(result.lineTotal, 900.00);
      expect(result.totalRegularPrice, 1000.00);
      expect(result.unitListPrice, 220.00);
      expect(result.unitRegularPrice, 200.00);
      expect(result.unitCost, 150.00);
      expect(result.orderLineOtherCharges, 15.00);
      expect(result.taxRate, 8.5);
      expect(result.taxAmount, 76.50);
      expect(result.unitPriceDisplay, "\$200.00");
      expect(result.unitNetPriceDisplay, "\$180.00");
      expect(result.extendedUnitNetPriceDisplay, "\$900.00");
      expect(result.discountAmountDisplay, "\$100.00");
      expect(result.unitDiscountAmountDisplay, "\$20.00");
      expect(result.totalDiscountAmountDisplay, "\$100.00");
      expect(result.lineTotalDisplay, "\$900.00");
      expect(result.totalRegularPriceDisplay, "\$1,000.00");
      expect(result.unitListPriceDisplay, "\$220.00");
      expect(result.unitRegularPriceDisplay, "\$200.00");
      expect(result.unitCostDisplay, "\$150.00");
      expect(result.orderLineOtherChargesDisplay, "\$15.00");
      expect(result.costCode, "CC-001");
      expect(result.canAddToCart, true);
      expect(result.isActiveProduct, true);
      expect(result.salePriceLabel, "Sale Price");
      expect(result.canAddToWishlist, true);
      expect(result.netPriceWithVat, 195.30);
      expect(result.netPriceWithVatDisplay, "\$195.30");
      expect(result.unitPriceWithVat, 217.00);
      expect(result.unitPriceWithVatDisplay, "\$217.00");
      expect(result.vmiBinNumber, "VMI-BIN-001");
      expect(result.properties, {"custom": "value"});

      // Verify nested objects
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 1);
      expect(result.availability?.message, "In Stock");
      expect(result.brand, isNotNull);
      expect(result.brand?.id, "BRAND-001");
      expect(result.brand?.name, "Premium Brand");
      expect(result.sectionOptions, hasLength(1));
      expect(result.sectionOptions?[0].sectionOptionId, "SO-001");
    });

    test('should correctly map OrderLineEntity to OrderLine', () {
      // Arrange
      final orderLineEntity = OrderLineEntity(
        id: "LINE-456",
        productId: "PROD-789",
        productName: "Simple Product",
        qtyOrdered: 3,
        unitPrice: 100.00,
        availability:
            const AvailabilityEntity(messageType: 2, message: "Low Stock"),
        brand: const BrandEntity(id: "BRAND-002", name: "Basic Brand"),
        sectionOptions: [
          SectionOptionEntity(
            sectionOptionId: "SO-002",
            sectionName: "Size",
            optionName: "Large",
          ),
        ],
        properties: const {"test": "data"},
      );

      // Act
      final result = OrderLineEntityMapper.toModel(orderLineEntity);

      // Assert
      expect(result.id, "LINE-456");
      expect(result.productId, "PROD-789");
      expect(result.productName, "Simple Product");
      expect(result.qtyOrdered, 3);
      expect(result.unitPrice, 100.00);
      expect(result.properties, {"test": "data"});

      // Verify nested objects
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 2);
      expect(result.availability?.message, "Low Stock");
      expect(result.brand, isNotNull);
      expect(result.brand?.id, "BRAND-002");
      expect(result.brand?.name, "Basic Brand");
      expect(result.sectionOptions, hasLength(1));
      expect(result.sectionOptions?[0].sectionOptionId, "SO-002");
    });

    test('should handle null nested objects correctly', () {
      // Arrange
      final orderLine = OrderLine(
        id: "LINE-NULL",
        productId: "PROD-NULL",
        availability: null,
        brand: null,
        sectionOptions: null,
      );

      // Act
      final result = OrderLineEntityMapper.toEntity(orderLine);

      // Assert
      expect(result.id, "LINE-NULL");
      expect(result.productId, "PROD-NULL");
      expect(result.availability, isNull);
      expect(result.brand, isNull);
      expect(result.sectionOptions, isNull);
    });

    test('should handle null entities in toModel correctly', () {
      // Arrange
      const orderLineEntity = OrderLineEntity(
        id: "LINE-ENTITY-NULL",
        productId: "PROD-ENTITY-NULL",
        availability: null,
        brand: null,
        sectionOptions: null,
      );

      // Act
      final result = OrderLineEntityMapper.toModel(orderLineEntity);

      // Assert
      expect(result.id, "LINE-ENTITY-NULL");
      expect(result.productId, "PROD-ENTITY-NULL");
      expect(result.availability, isNull);
      expect(result.brand, isNull);
      expect(result.sectionOptions, isNull);
    });
  });

  group('OrderPromotionEntityMapper', () {
    test('should correctly map OrderPromotion to OrderPromotionEntity', () {
      // Arrange
      final orderPromotion = OrderPromotion(
        id: "PROMO-123",
        amount: 75.50,
        amountDisplay: "\$75.50",
        name: "Summer Sale",
        orderHistoryLineId: "LINE-789",
        promotionResultType: "Discount",
      );

      // Act
      final result = OrderPromotionEntityMapper.toEntity(orderPromotion);

      // Assert
      expect(result.id, "PROMO-123");
      expect(result.amount, 75.50);
      expect(result.amountDisplay, "\$75.50");
      expect(result.name, "Summer Sale");
      expect(result.orderHistoryLineId, "LINE-789");
      expect(result.promotionResultType, "Discount");
    });

    test('should correctly map OrderPromotionEntity to OrderPromotion', () {
      // Arrange
      const orderPromotionEntity = OrderPromotionEntity(
        id: "PROMO-456",
        amount: 25.00,
        amountDisplay: "\$25.00",
        name: "First Time Buyer",
        orderHistoryLineId: "LINE-101",
        promotionResultType: "Percentage",
      );

      // Act
      final result = OrderPromotionEntityMapper.toModel(orderPromotionEntity);

      // Assert
      expect(result.id, "PROMO-456");
      expect(result.amount, 25.00);
      expect(result.amountDisplay, "\$25.00");
      expect(result.name, "First Time Buyer");
      expect(result.orderHistoryLineId, "LINE-101");
      expect(result.promotionResultType, "Percentage");
    });

    test('should handle null values correctly', () {
      // Arrange
      final orderPromotion = OrderPromotion(
        id: null,
        amount: null,
        amountDisplay: null,
        name: null,
        orderHistoryLineId: null,
        promotionResultType: null,
      );

      // Act
      final result = OrderPromotionEntityMapper.toEntity(orderPromotion);

      // Assert
      expect(result.id, isNull);
      expect(result.amount, isNull);
      expect(result.amountDisplay, isNull);
      expect(result.name, isNull);
      expect(result.orderHistoryLineId, isNull);
      expect(result.promotionResultType, isNull);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalPromotion = OrderPromotion(
        id: "ROUNDTRIP-PROMO",
        amount: 100.00,
        name: "Roundtrip Test",
      );

      // Act
      final entity = OrderPromotionEntityMapper.toEntity(originalPromotion);
      final convertedBack = OrderPromotionEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.id, originalPromotion.id);
      expect(convertedBack.amount, originalPromotion.amount);
      expect(convertedBack.name, originalPromotion.name);
    });
  });

  group('ShipmentPackageDtoEntityMapper', () {
    test('should correctly map ShipmentPackageDto to ShipmentPackageDtoEntity',
        () {
      // Arrange
      final shipmentDate = DateTime(2024, 1, 18, 14, 30);
      final shipmentPackage = ShipmentPackageDto(
        id: "PKG-789",
        shipmentDate: shipmentDate,
        carrier: "FedEx",
        shipVia: "FedEx Ground",
        trackingUrl: "https://fedex.com/track/123456",
        trackingNumber: "123456789012",
        packSlip: "PS-001",
        trackButtonTitle: "Track Package",
        shipDateTitle: "Ship Date",
      );

      // Act
      final result = ShipmentPackageDtoEntityMapper.toEntity(shipmentPackage);

      // Assert
      expect(result.id, "PKG-789");
      expect(result.shipmentDate, shipmentDate);
      expect(result.carrier, "FedEx");
      expect(result.shipVia, "FedEx Ground");
      expect(result.trackingUrl, "https://fedex.com/track/123456");
      expect(result.trackingNumber, "123456789012");
      expect(result.packSlip, "PS-001");
      expect(result.trackButtonTitle, "Track Package");
      expect(result.shipDateTitle, "Ship Date");
    });

    test('should correctly map ShipmentPackageDtoEntity to ShipmentPackageDto',
        () {
      // Arrange
      const shipmentPackageEntity = ShipmentPackageDtoEntity(
        id: "PKG-101",
        carrier: "DHL",
        shipVia: "DHL Express",
        trackingNumber: "DHL987654321",
        trackingUrl: "https://dhl.com/track/987654",
        packSlip: "PS-002",
        trackButtonTitle: "Track DHL",
        shipDateTitle: "Shipped On",
      );

      // Act
      final result =
          ShipmentPackageDtoEntityMapper.toModel(shipmentPackageEntity);

      // Assert
      expect(result.id, "PKG-101");
      expect(result.carrier, "DHL");
      expect(result.shipVia, "DHL Express");
      expect(result.trackingNumber, "DHL987654321");
      expect(result.trackingUrl, "https://dhl.com/track/987654");
      expect(result.packSlip, "PS-002");
      expect(result.trackButtonTitle, "Track DHL");
      expect(result.shipDateTitle, "Shipped On");
    });

    test('should handle null values correctly', () {
      // Arrange
      final shipmentPackage = ShipmentPackageDto(
        id: null,
        shipmentDate: null,
        carrier: null,
        shipVia: null,
        trackingUrl: null,
        trackingNumber: null,
        packSlip: null,
        trackButtonTitle: null,
        shipDateTitle: null,
      );

      // Act
      final result = ShipmentPackageDtoEntityMapper.toEntity(shipmentPackage);

      // Assert
      expect(result.id, isNull);
      expect(result.shipmentDate, isNull);
      expect(result.carrier, isNull);
      expect(result.shipVia, isNull);
      expect(result.trackingUrl, isNull);
      expect(result.trackingNumber, isNull);
      expect(result.packSlip, isNull);
      expect(result.trackButtonTitle, isNull);
      expect(result.shipDateTitle, isNull);
    });
  });

  group('OrderHistoryTaxDtoEntityMapper', () {
    test('should correctly map OrderHistoryTaxDto to OrderHistoryTaxDtoEntity',
        () {
      // Arrange
      final orderHistoryTax = OrderHistoryTaxDto(
        taxCode: "FEDERAL",
        taxDescription: "Federal Sales Tax",
        taxRate: 5.5,
        taxAmount: 55.00,
        taxAmountDisplay: "\$55.00",
        sortOrder: 2,
      );

      // Act
      final result = OrderHistoryTaxDtoEntityMapper.toEntity(orderHistoryTax);

      // Assert
      expect(result.taxCode, "FEDERAL");
      expect(result.taxDescription, "Federal Sales Tax");
      expect(result.taxRate, 5.5);
      expect(result.taxAmount, 55.00);
      expect(result.taxAmountDisplay, "\$55.00");
      expect(result.sortOrder, 2);
    });

    test('should correctly map OrderHistoryTaxDtoEntity to OrderHistoryTaxDto',
        () {
      // Arrange
      const orderHistoryTaxEntity = OrderHistoryTaxDtoEntity(
        taxCode: "LOCAL",
        taxDescription: "Local Tax",
        taxRate: 2.0,
        taxAmount: 20.00,
        taxAmountDisplay: "\$20.00",
        sortOrder: 3,
      );

      // Act
      final result =
          OrderHistoryTaxDtoEntityMapper.toModel(orderHistoryTaxEntity);

      // Assert
      expect(result.taxCode, "LOCAL");
      expect(result.taxDescription, "Local Tax");
      expect(result.taxRate, 2.0);
      expect(result.taxAmount, 20.00);
      expect(result.taxAmountDisplay, "\$20.00");
      expect(result.sortOrder, 3);
    });

    test('should handle null values correctly', () {
      // Arrange
      final orderHistoryTax = OrderHistoryTaxDto(
        taxCode: null,
        taxDescription: null,
        taxRate: null,
        taxAmount: null,
        taxAmountDisplay: null,
        sortOrder: null,
      );

      // Act
      final result = OrderHistoryTaxDtoEntityMapper.toEntity(orderHistoryTax);

      // Assert
      expect(result.taxCode, isNull);
      expect(result.taxDescription, isNull);
      expect(result.taxRate, isNull);
      expect(result.taxAmount, isNull);
      expect(result.taxAmountDisplay, isNull);
      expect(result.sortOrder, isNull);
    });
  });

  group('GetOrderCollectionResultEntityMapper', () {
    test(
        'should correctly map GetOrderCollectionResult to GetOrderCollectionResultEntity',
        () {
      // Arrange
      final getOrderCollectionResult = GetOrderCollectionResult(
        orders: [
          Order(
            id: "ORD-001",
            erpOrderNumber: "ERP-001",
            status: "Shipped",
            orderTotal: 1000.00,
          ),
          Order(
            id: "ORD-002",
            erpOrderNumber: "ERP-002",
            status: "Processing",
            orderTotal: 500.00,
          ),
        ],
        pagination: Pagination(
          page: 1,
          pageSize: 10,
          totalItemCount: 2,
          numberOfPages: 1,
        ),
        showErpOrderNumber: true,
      );

      // Act
      final result = GetOrderCollectionResultEntityMapper.toEntity(
          getOrderCollectionResult);

      // Assert
      expect(result.orders, hasLength(2));
      expect(result.orders?[0].id, "ORD-001");
      expect(result.orders?[0].erpOrderNumber, "ERP-001");
      expect(result.orders?[1].id, "ORD-002");
      expect(result.orders?[1].erpOrderNumber, "ERP-002");
      expect(result.pagination, isNotNull);
      expect(result.pagination?.page, 1);
      expect(result.pagination?.totalItemCount, 2);
      expect(result.showErpOrderNumber, true);
    });

    test(
        'should correctly map GetOrderCollectionResultEntity to GetOrderCollectionResult',
        () {
      // Arrange
      const getOrderCollectionResultEntity = GetOrderCollectionResultEntity(
        orders: [
          OrderEntity(
            id: "ORD-003",
            erpOrderNumber: "ERP-003",
            status: "Delivered",
            orderTotal: 750.00,
          ),
        ],
        pagination: PaginationEntity(
          currentPage: 2,
          page: 2,
          pageSize: 5,
          defaultPageSize: 5,
          totalItemCount: 1,
          numberOfPages: 1,
          pageSizeOptions: [5, 10, 20],
          sortOptions: [],
          sortType: "orderDate",
          nextPageUri: null,
          prevPageUri: "https://api.example.com/orders?page=1",
        ),
        showErpOrderNumber: false,
      );

      // Act
      final result = GetOrderCollectionResultEntityMapper.toModel(
          getOrderCollectionResultEntity);

      // Assert
      expect(result.orders, hasLength(1));
      expect(result.orders?[0].id, "ORD-003");
      expect(result.orders?[0].erpOrderNumber, "ERP-003");
      expect(result.pagination, isNotNull);
      expect(result.pagination?.page, 2);
      expect(result.pagination?.totalItemCount, 1);
      expect(result.showErpOrderNumber, false);
    });

    test('should handle null collections correctly', () {
      // Arrange
      final getOrderCollectionResult = GetOrderCollectionResult(
        orders: null,
        pagination: null,
        showErpOrderNumber: null,
      );

      // Act
      final result = GetOrderCollectionResultEntityMapper.toEntity(
          getOrderCollectionResult);

      // Assert
      expect(result.orders, isNull);
      expect(result.pagination, isNull);
      expect(result.showErpOrderNumber, isNull);
    });

    test('should handle empty collections correctly', () {
      // Arrange
      final getOrderCollectionResult = GetOrderCollectionResult(
        orders: [],
        pagination: Pagination(
          page: 1,
          pageSize: 10,
          totalItemCount: 0,
          numberOfPages: 0,
        ),
        showErpOrderNumber: true,
      );

      // Act
      final result = GetOrderCollectionResultEntityMapper.toEntity(
          getOrderCollectionResult);

      // Assert
      expect(result.orders, hasLength(0));
      expect(result.pagination, isNotNull);
      expect(result.pagination?.totalItemCount, 0);
      expect(result.showErpOrderNumber, true);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalResult = GetOrderCollectionResult(
        orders: [
          Order(
            id: "ROUNDTRIP-ORDER",
            status: "Test",
            orderTotal: 100.00,
          ),
        ],
        pagination: Pagination(
          page: 1,
          totalItemCount: 1,
        ),
        showErpOrderNumber: true,
      );

      // Act
      final entity =
          GetOrderCollectionResultEntityMapper.toEntity(originalResult);
      final convertedBack =
          GetOrderCollectionResultEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.orders, hasLength(1));
      expect(convertedBack.orders?[0].id, originalResult.orders?[0].id);
      expect(convertedBack.orders?[0].status, originalResult.orders?[0].status);
      expect(convertedBack.orders?[0].orderTotal,
          originalResult.orders?[0].orderTotal);
      expect(convertedBack.pagination?.page, originalResult.pagination?.page);
      expect(convertedBack.pagination?.totalItemCount,
          originalResult.pagination?.totalItemCount);
      expect(
          convertedBack.showErpOrderNumber, originalResult.showErpOrderNumber);
    });
  });
}
