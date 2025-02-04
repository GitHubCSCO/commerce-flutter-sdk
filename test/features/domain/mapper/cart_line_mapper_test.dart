import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/break_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
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
        pricing: ProductPriceEntityMapper.toModel(ProductPriceEntity(
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
            AvailabilityEntity(messageType: 1, message: "In Stock")),
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
        brand: BrandEntityMapper.toModel(BrandEntity(id: "B123", name: "BrandX")),
        status: "Available",
        notes: "Special instructions",
        vmiBinId: "VMI-001",
        sectionOptions: [],
      );

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
      expect(result.unitOfMeasureDescription, cartLine.unitOfMeasureDescription);
      expect(result.baseUnitOfMeasure, cartLine.baseUnitOfMeasure);
      expect(result.baseUnitOfMeasureDisplay, cartLine.baseUnitOfMeasureDisplay);
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
      expect(result.hasInsufficientInventory, cartLine.hasInsufficientInventory);
      expect(result.canBackOrder, cartLine.canBackOrder);
      expect(result.salePriceLabel, cartLine.salePriceLabel);
      expect(result.isSubscription, cartLine.isSubscription);
      expect(result.isRestricted, cartLine.isRestricted);
      expect(result.isActive, cartLine.isActive);
      expect(result.status, cartLine.status);
      expect(result.notes, cartLine.notes);
      expect(result.vmiBinId, cartLine.vmiBinId);
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
        pricing: ProductPriceEntity(
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
        availability: AvailabilityEntity(messageType: 1, message: "In Stock"),
        qtyOnHand: 20,
        canAddToCart: true,
        isQtyAdjusted: false,
        hasInsufficientInventory: false,
        canBackOrder: true,
        salePriceLabel: "Sale",
        isSubscription: false,
        isRestricted: false,
        isActive: true,
        brand: BrandEntity(id: "B123", name: "BrandX"),
        status: "Available",
        notes: "Special instructions",
        vmiBinId: "VMI-001",
        sectionOptions: [],
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
    });
  });
}
