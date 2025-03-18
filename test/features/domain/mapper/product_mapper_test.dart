import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
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
  });
}
