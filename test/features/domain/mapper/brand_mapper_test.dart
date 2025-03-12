import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('BrandEntityMapper', () {
    test('toEntity should map Brand to BrandEntity', () {
      // Arrange
      final brand = Brand(
        id: '123',
        name: 'Test Brand',
        manufacturer: 'Test Manufacturer',
        externalUrl: 'http://example.com',
        detailPagePath: '/brands/test',
        productListPagePage: '/products/brand/test',
        logoSmallImagePath: '/images/small-logo.png',
        logoLargeImagePath: '/images/large-logo.png',
        logoAltText: 'Brand Logo Alt Text',
        featuredImagePath: '/images/featured.png',
        featuredImageAltText: 'Featured Image Alt Text',
        htmlContent: '<p>Test content</p>',
        topSellerProducts: [
          Product(id: 'product1', name: 'Product 1'),
          Product(id: 'product2', name: 'Product 2'),
        ],
      );

      // Act
      final entity = BrandEntityMapper.toEntity(brand);

      // Assert
      expect(entity.id, equals(brand.id));
      expect(entity.name, equals(brand.name));
      expect(entity.manufacturer, equals(brand.manufacturer));
      expect(entity.externalUrl, equals(brand.externalUrl));
      expect(entity.detailPagePath, equals(brand.detailPagePath));
      expect(entity.productListPagePage, equals(brand.productListPagePage));
      expect(entity.logoSmallImagePath, equals(brand.logoSmallImagePath));
      expect(entity.logoLargeImagePath, equals(brand.logoLargeImagePath));
      expect(entity.logoAltText, equals(brand.logoAltText));
      expect(entity.featuredImagePath, equals(brand.featuredImagePath));
      expect(entity.featuredImageAltText, equals(brand.featuredImageAltText));
      expect(entity.htmlContent, equals(brand.htmlContent));
      expect(entity.topSellerProducts?.length, equals(2));
      expect(entity.topSellerProducts?[0].id, equals('product1'));
      expect(entity.topSellerProducts?[1].id, equals('product2'));
    });

    test('toEntity should handle null Brand', () {
      // Act
      final entity = BrandEntityMapper.toEntity(null);

      // Assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
      expect(entity.topSellerProducts, isNull);
    });

    test('toEntity should handle Brand with null properties', () {
      // Arrange
      final brand = Brand();

      // Act
      final entity = BrandEntityMapper.toEntity(brand);

      // Assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
      expect(entity.manufacturer, isNull);
      expect(entity.externalUrl, isNull);
      expect(entity.detailPagePath, isNull);
      expect(entity.productListPagePage, isNull);
      expect(entity.logoSmallImagePath, isNull);
      expect(entity.logoLargeImagePath, isNull);
      expect(entity.logoAltText, isNull);
      expect(entity.featuredImagePath, isNull);
      expect(entity.featuredImageAltText, isNull);
      expect(entity.htmlContent, isNull);
      expect(entity.topSellerProducts, isNull);
    });

    test('toModel should map BrandEntity to Brand', () {
      // Arrange
      final entity = BrandEntity(
        id: '123',
        name: 'Test Brand',
        manufacturer: 'Test Manufacturer',
        externalUrl: 'http://example.com',
        detailPagePath: '/brands/test',
        productListPagePage: '/products/brand/test',
        logoSmallImagePath: '/images/small-logo.png',
        logoLargeImagePath: '/images/large-logo.png',
        logoAltText: 'Brand Logo Alt Text',
        featuredImagePath: '/images/featured.png',
        featuredImageAltText: 'Featured Image Alt Text',
        htmlContent: '<p>Test content</p>',
        topSellerProducts: [
          ProductEntity(id: 'product1', name: 'Product 1'),
          ProductEntity(id: 'product2', name: 'Product 2'),
        ],
      );

      // Act
      final model = BrandEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.manufacturer, equals(entity.manufacturer));
      expect(model.externalUrl, equals(entity.externalUrl));
      expect(model.detailPagePath, equals(entity.detailPagePath));
      expect(model.productListPagePage, equals(entity.productListPagePage));
      expect(model.logoSmallImagePath, equals(entity.logoSmallImagePath));
      expect(model.logoLargeImagePath, equals(entity.logoLargeImagePath));
      expect(model.logoAltText, equals(entity.logoAltText));
      expect(model.featuredImagePath, equals(entity.featuredImagePath));
      expect(model.featuredImageAltText, equals(entity.featuredImageAltText));
      expect(model.htmlContent, equals(entity.htmlContent));
      expect(model.topSellerProducts?.length, equals(2));
      expect(model.topSellerProducts?[0].id, equals('product1'));
      expect(model.topSellerProducts?[1].id, equals('product2'));
    });

    test('toModel should handle entity with null properties', () {
      // Arrange
      const entity = BrandEntity();

      // Act
      final model = BrandEntityMapper.toModel(entity);

      // Assert
      expect(model.id, isNull);
      expect(model.name, isNull);
      expect(model.manufacturer, isNull);
      expect(model.externalUrl, isNull);
      expect(model.detailPagePath, isNull);
      expect(model.productListPagePage, isNull);
      expect(model.logoSmallImagePath, isNull);
      expect(model.logoLargeImagePath, isNull);
      expect(model.logoAltText, isNull);
      expect(model.featuredImagePath, isNull);
      expect(model.featuredImageAltText, isNull);
      expect(model.htmlContent, isNull);
      expect(model.topSellerProducts, isNull);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = Brand(
        id: '123',
        name: 'Test Brand',
        manufacturer: 'Test Manufacturer',
        externalUrl: 'http://example.com',
        detailPagePath: '/brands/test',
        productListPagePage: '/products/brand/test',
        logoSmallImagePath: '/images/small-logo.png',
        logoLargeImagePath: '/images/large-logo.png',
        logoAltText: 'Brand Logo Alt Text',
        featuredImagePath: '/images/featured.png',
        featuredImageAltText: 'Featured Image Alt Text',
        htmlContent: '<p>Test content</p>',
        topSellerProducts: [
          Product(id: 'product1', name: 'Product 1'),
          Product(id: 'product2', name: 'Product 2'),
        ],
      );

      // Act
      final entity = BrandEntityMapper.toEntity(originalModel);
      final resultModel = BrandEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.name, equals(originalModel.name));
      expect(resultModel.manufacturer, equals(originalModel.manufacturer));
      expect(resultModel.externalUrl, equals(originalModel.externalUrl));
      expect(resultModel.detailPagePath, equals(originalModel.detailPagePath));
      expect(resultModel.productListPagePage,
          equals(originalModel.productListPagePage));
      expect(resultModel.logoSmallImagePath,
          equals(originalModel.logoSmallImagePath));
      expect(resultModel.logoLargeImagePath,
          equals(originalModel.logoLargeImagePath));
      expect(resultModel.logoAltText, equals(originalModel.logoAltText));
      expect(resultModel.featuredImagePath,
          equals(originalModel.featuredImagePath));
      expect(resultModel.featuredImageAltText,
          equals(originalModel.featuredImageAltText));
      expect(resultModel.htmlContent, equals(originalModel.htmlContent));
      expect(resultModel.topSellerProducts?.length,
          equals(originalModel.topSellerProducts?.length));
      expect(resultModel.topSellerProducts?[0].id,
          equals(originalModel.topSellerProducts?[0].id));
      expect(resultModel.topSellerProducts?[1].id,
          equals(originalModel.topSellerProducts?[1].id));
    });
  });

  group('BrandAlphabetEntityMapper', () {
    test('toEntity should map BrandAlphabet to BrandAlphabetEntity', () {
      // Arrange
      final model = BrandAlphabet(letter: 'A', count: 10);

      // Act
      final entity = BrandAlphabetEntityMapper.toEntity(model);

      // Assert
      expect(entity.letter, equals('A'));
      expect(entity.count, equals(10));
    });

    test('toEntity should handle null BrandAlphabet', () {
      // Act
      final entity = BrandAlphabetEntityMapper.toEntity(null);

      // Assert
      expect(entity.letter, isNull);
      expect(entity.count, isNull);
    });

    test('toEntity should handle BrandAlphabet with null properties', () {
      // Arrange
      final model = BrandAlphabet();

      // Act
      final entity = BrandAlphabetEntityMapper.toEntity(model);

      // Assert
      expect(entity.letter, isNull);
      expect(entity.count, isNull);
    });
  });
}
