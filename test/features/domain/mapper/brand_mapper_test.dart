
import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockProductEntityMapper extends ProductEntityMapper {}

void main() {
  group('BrandEntityMapper', () {
    test('should correctly map Brand to BrandEntity', () {
      // Arrange
      final model = Brand(
        id: "1",
        name: "Nike",
        manufacturer: "Nike Inc.",
        externalUrl: "https://www.nike.com",
        detailPagePath: "/brands/nike",
        productListPagePage: "/products/nike",
        logoSmallImagePath: "/images/nike_small.png",
        logoLargeImagePath: "/images/nike_large.png",
        logoAltText: "Nike Logo",
        featuredImagePath: "/images/nike_featured.png",
        featuredImageAltText: "Nike Featured",
        htmlContent: "<p>Nike Brand</p>",
        topSellerProducts: [],
      );

      // Act
      final result = BrandEntityMapper.toEntity(model);

      // Assert
      expect(result.id, model.id);
      expect(result.name, model.name);
      expect(result.manufacturer, model.manufacturer);
      expect(result.externalUrl, model.externalUrl);
      expect(result.detailPagePath, model.detailPagePath);
      expect(result.productListPagePage, model.productListPagePage);
      expect(result.logoSmallImagePath, model.logoSmallImagePath);
      expect(result.logoLargeImagePath, model.logoLargeImagePath);
      expect(result.logoAltText, model.logoAltText);
      expect(result.featuredImagePath, model.featuredImagePath);
      expect(result.featuredImageAltText, model.featuredImageAltText);
      expect(result.htmlContent, model.htmlContent);
      expect(result.topSellerProducts, isEmpty);
    });

    test('should correctly map BrandEntity to Brand', () {
      // Arrange
      final entity = BrandEntity(
        id: "2",
        name: "Adidas",
        manufacturer: "Adidas AG",
        externalUrl: "https://www.adidas.com",
        detailPagePath: "/brands/adidas",
        productListPagePage: "/products/adidas",
        logoSmallImagePath: "/images/adidas_small.png",
        logoLargeImagePath: "/images/adidas_large.png",
        logoAltText: "Adidas Logo",
        featuredImagePath: "/images/adidas_featured.png",
        featuredImageAltText: "Adidas Featured",
        htmlContent: "<p>Adidas Brand</p>",
        topSellerProducts: [],
      );

      // Act
      final result = BrandEntityMapper.toModel(entity);

      // Assert
      expect(result.id, entity.id);
      expect(result.name, entity.name);
      expect(result.manufacturer, entity.manufacturer);
      expect(result.externalUrl, entity.externalUrl);
      expect(result.detailPagePath, entity.detailPagePath);
      expect(result.productListPagePage, entity.productListPagePage);
      expect(result.logoSmallImagePath, entity.logoSmallImagePath);
      expect(result.logoLargeImagePath, entity.logoLargeImagePath);
      expect(result.logoAltText, entity.logoAltText);
      expect(result.featuredImagePath, entity.featuredImagePath);
      expect(result.featuredImageAltText, entity.featuredImageAltText);
      expect(result.htmlContent, entity.htmlContent);
      expect(result.topSellerProducts, isEmpty);
    });

    test('should handle null Brand model correctly', () {
      // Act
      final result = BrandEntityMapper.toEntity(null);

      // Assert
      expect(result.id, isNull);
      expect(result.name, isNull);
      expect(result.manufacturer, isNull);
      expect(result.externalUrl, isNull);
      expect(result.detailPagePath, isNull);
      expect(result.productListPagePage, isNull);
      expect(result.logoSmallImagePath, isNull);
      expect(result.logoLargeImagePath, isNull);
      expect(result.logoAltText, isNull);
      expect(result.featuredImagePath, isNull);
      expect(result.featuredImageAltText, isNull);
      expect(result.htmlContent, isNull);
      expect(result.topSellerProducts, isNull);
    });
  });

  group('BrandAlphabetEntityMapper', () {
    test('should correctly map BrandAlphabet to BrandAlphabetEntity', () {
      // Arrange
      final model = BrandAlphabet(
        letter: "A",
        count: 5,
      );

      // Act
      final result = BrandAlphabetEntityMapper.toEntity(model);

      // Assert
      expect(result.letter, model.letter);
      expect(result.count, model.count);
    });

    test('should handle null BrandAlphabet model correctly', () {
      // Act
      final result = BrandAlphabetEntityMapper.toEntity(null);

      // Assert
      expect(result.letter, isNull);
      expect(result.count, isNull);
    });
  });
}
