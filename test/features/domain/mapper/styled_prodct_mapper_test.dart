import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/styled_prodct_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  late StyledProductEntityMapper mapper;

  setUp(() {
    mapper = StyledProductEntityMapper();
  });

  group('StyledProductEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = StyledProduct(
        productId: 'product123',
        name: 'Red T-Shirt',
        shortDescription: 'A comfortable red t-shirt',
        erpNumber: 'ERP123',
        mediumImagePath: '/images/medium.jpg',
        smallImagePath: '/images/small.jpg',
        largeImagePath: '/images/large.jpg',
        qtyOnHand: 50,
        numberInCart: 2,
        pricing: ProductPrice(
          unitNetPrice: 19.99,
          unitNetPriceDisplay: '\$19.99',
        ),
        quoteRequired: false,
        styleValues: [
          StyleValue(styleTraitId: 'color', value: 'red', valueDisplay: 'Red'),
          StyleValue(styleTraitId: 'size', value: 'l', valueDisplay: 'Large'),
        ],
        availability: Availability(
          message: 'In Stock',
          messageType: 1,
          requiresRealTimeInventory: true,
        ),
        productUnitOfMeasures: [
          ProductUnitOfMeasure(
            unitOfMeasure: 'EA',
            unitOfMeasureDisplay: 'Each',
            isDefault: true,
          ),
        ],
        trackInventory: true,
        allowZeroPricing: false,
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.productId, equals(model.productId));
      expect(entity.name, equals(model.name));
      expect(entity.shortDescription, equals(model.shortDescription));
      expect(entity.erpNumber, equals(model.erpNumber));
      expect(entity.mediumImagePath, equals(model.mediumImagePath));
      expect(entity.smallImagePath, equals(model.smallImagePath));
      expect(entity.largeImagePath, equals(model.largeImagePath));
      expect(entity.qtyOnHand, equals(model.qtyOnHand));
      expect(entity.numberInCart, equals(model.numberInCart));
      expect(entity.pricing?.unitNetPrice, equals(model.pricing?.unitNetPrice));
      expect(entity.quoteRequired, equals(model.quoteRequired));
      expect(entity.styleValues?.length, equals(2));
      expect(entity.styleValues?[0].styleTraitId, equals('color'));
      expect(entity.styleValues?[0].value, equals('red'));
      expect(entity.styleValues?[1].styleTraitId, equals('size'));
      expect(entity.availability?.message, equals(model.availability?.message));
      expect(entity.availability?.messageType, equals(model.availability?.messageType));
      expect(entity.productUnitOfMeasures?.length, equals(1));
      expect(entity.productUnitOfMeasures?[0].unitOfMeasure, equals('EA'));
      expect(entity.trackInventory, equals(model.trackInventory));
      expect(entity.allowZeroPricing, equals(model.allowZeroPricing));
    });

    test('toEntity should handle model with null properties', () {
      // Arrange
      final model = StyledProduct(
        productId: 'product123',
        name: 'Red T-Shirt',
        styleValues: null,
        productUnitOfMeasures: null,
        productImages: null,
        warehouses: null,
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.productId, equals(model.productId));
      expect(entity.name, equals(model.name));
      expect(entity.styleValues, isNull);
      expect(entity.productUnitOfMeasures, isNull);
      expect(entity.productImages, isNull);
      expect(entity.warehouses, isNull);
      expect(entity.availability, isNotNull); // Default availability should be created
      expect(entity.pricing, isNotNull); // Default pricing should be created
    });

    test('toEntity should handle model with empty collections', () {
      // Arrange
      final model = StyledProduct(
        productId: 'product123',
        name: 'Red T-Shirt',
        styleValues: [],
        productUnitOfMeasures: [],
        productImages: [],
        warehouses: [],
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.productId, equals(model.productId));
      expect(entity.name, equals(model.name));
      expect(entity.styleValues, isEmpty);
      expect(entity.productUnitOfMeasures, isEmpty);
      expect(entity.productImages, isEmpty);
      expect(entity.warehouses, isEmpty);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      const entity = StyledProductEntity(
        productId: 'product123',
        name: 'Red T-Shirt',
        shortDescription: 'A comfortable red t-shirt',
        erpNumber: 'ERP123',
        mediumImagePath: '/images/medium.jpg',
        smallImagePath: '/images/small.jpg',
        largeImagePath: '/images/large.jpg',
        qtyOnHand: 50,
        numberInCart: 2,
        pricing: ProductPriceEntity(
          unitNetPrice: 19.99,
          unitNetPriceDisplay: '\$19.99',
        ),
        quoteRequired: false,
        styleValues: [
          StyleValueEntity(styleTraitId: 'color', value: 'red', valueDisplay: 'Red'),
          StyleValueEntity(styleTraitId: 'size', value: 'l', valueDisplay: 'Large'),
        ],
        availability: AvailabilityEntity(
          message: 'In Stock',
          messageType: 1,
          requiresRealTimeInventory: true,
        ),
        productUnitOfMeasures: [
          ProductUnitOfMeasureEntity(
            unitOfMeasure: 'EA',
            unitOfMeasureDisplay: 'Each',
            isDefault: true,
          ),
        ],
        trackInventory: true,
        allowZeroPricing: false,
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.productId, equals(entity.productId));
      expect(model.name, equals(entity.name));
      expect(model.shortDescription, equals(entity.shortDescription));
      expect(model.erpNumber, equals(entity.erpNumber));
      expect(model.mediumImagePath, equals(entity.mediumImagePath));
      expect(model.smallImagePath, equals(entity.smallImagePath));
      expect(model.largeImagePath, equals(entity.largeImagePath));
      expect(model.qtyOnHand, equals(entity.qtyOnHand));
      expect(model.numberInCart, equals(entity.numberInCart));
      expect(model.pricing?.unitNetPrice, equals(entity.pricing?.unitNetPrice));
      expect(model.quoteRequired, equals(entity.quoteRequired));
      expect(model.styleValues?.length, equals(2));
      expect(model.styleValues?[0].styleTraitId, equals('color'));
      expect(model.styleValues?[0].value, equals('red'));
      expect(model.styleValues?[1].styleTraitId, equals('size'));
      expect(model.availability?.message, equals(entity.availability?.message));
      expect(model.availability?.messageType, equals(entity.availability?.messageType));
      expect(model.productUnitOfMeasures?.length, equals(1));
      expect(model.productUnitOfMeasures?[0].unitOfMeasure, equals('EA'));
      expect(model.trackInventory, equals(entity.trackInventory));
      expect(model.allowZeroPricing, equals(entity.allowZeroPricing));
    });

    test('toModel should handle entity with null properties', () {
      // Arrange
      const entity = StyledProductEntity(
        productId: 'product123',
        name: 'Red T-Shirt',
        styleValues: null,
        productUnitOfMeasures: null,
        productImages: null,
        warehouses: null,
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.productId, equals(entity.productId));
      expect(model.name, equals(entity.name));
      expect(model.styleValues, isNull);
      expect(model.productUnitOfMeasures, isNull);
      expect(model.productImages, isNull);
      expect(model.warehouses, isNull);
      expect(model.availability, isNotNull); // Default availability should be created
      expect(model.pricing, isNotNull); // Default pricing should be created
    });

    test('toModel should handle entity with empty collections', () {
      // Arrange
      const entity = StyledProductEntity(
        productId: 'product123',
        name: 'Red T-Shirt',
        styleValues: [],
        productUnitOfMeasures: [],
        productImages: [],
        warehouses: [],
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.productId, equals(entity.productId));
      expect(model.name, equals(entity.name));
      expect(model.styleValues, isEmpty);
      expect(model.productUnitOfMeasures, isEmpty);
      expect(model.productImages, isEmpty);
      expect(model.warehouses, isEmpty);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = StyledProduct(
        productId: 'product123',
        name: 'Red T-Shirt',
        shortDescription: 'A comfortable red t-shirt',
        erpNumber: 'ERP123',
        mediumImagePath: '/images/medium.jpg',
        smallImagePath: '/images/small.jpg',
        largeImagePath: '/images/large.jpg',
        qtyOnHand: 50,
        numberInCart: 2,
        pricing: ProductPrice(
          unitNetPrice: 19.99,
          unitNetPriceDisplay: '\$19.99',
        ),
        quoteRequired: false,
        styleValues: [
          StyleValue(styleTraitId: 'color', value: 'red', valueDisplay: 'Red'),
          StyleValue(styleTraitId: 'size', value: 'l', valueDisplay: 'Large'),
        ],
        availability: Availability(
          message: 'In Stock',
          messageType: 1,
          requiresRealTimeInventory: true,
        ),
        productUnitOfMeasures: [
          ProductUnitOfMeasure(
            unitOfMeasure: 'EA',
            unitOfMeasureDisplay: 'Each',
            isDefault: true,
          ),
        ],
        trackInventory: true,
        allowZeroPricing: false,
      );

      // Act
      final entity = mapper.toEntity(originalModel);
      final resultModel = mapper.toModel(entity);

      // Assert
      expect(resultModel.productId, equals(originalModel.productId));
      expect(resultModel.name, equals(originalModel.name));
      expect(resultModel.shortDescription, equals(originalModel.shortDescription));
      expect(resultModel.erpNumber, equals(originalModel.erpNumber));
      expect(resultModel.mediumImagePath, equals(originalModel.mediumImagePath));
      expect(resultModel.smallImagePath, equals(originalModel.smallImagePath));
      expect(resultModel.largeImagePath, equals(originalModel.largeImagePath));
      expect(resultModel.qtyOnHand, equals(originalModel.qtyOnHand));
      expect(resultModel.numberInCart, equals(originalModel.numberInCart));
      expect(resultModel.pricing?.unitNetPrice, equals(originalModel.pricing?.unitNetPrice));
      expect(resultModel.quoteRequired, equals(originalModel.quoteRequired));
      expect(resultModel.styleValues?.length, equals(originalModel.styleValues?.length));
      expect(resultModel.styleValues?[0].styleTraitId, equals(originalModel.styleValues?[0].styleTraitId));
      expect(resultModel.styleValues?[0].value, equals(originalModel.styleValues?[0].value));
      expect(resultModel.availability?.message, equals(originalModel.availability?.message));
      expect(resultModel.availability?.messageType, equals(originalModel.availability?.messageType));
      expect(resultModel.productUnitOfMeasures?.length, equals(originalModel.productUnitOfMeasures?.length));
      expect(resultModel.productUnitOfMeasures?[0].unitOfMeasure, equals(originalModel.productUnitOfMeasures?[0].unitOfMeasure));
      expect(resultModel.trackInventory, equals(originalModel.trackInventory));
      expect(resultModel.allowZeroPricing, equals(originalModel.allowZeroPricing));
    });
  });
}