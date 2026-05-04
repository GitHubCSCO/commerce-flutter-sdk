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
        detailPagePath: "/brands/nike",
        logoSmallImagePath: "/images/nike_small.png",
        logoLargeImagePath: "/images/nike_large.png",
        logoImageAltText: "Nike Logo",
        urlSegment: "nike",
      );

      // Act
      final result = BrandEntityMapper.toEntity(model);

      // Assert
      expect(result.id, model.id);
      expect(result.name, model.name);
      expect(result.detailPagePath, model.detailPagePath);
      expect(result.logoSmallImagePath, model.logoSmallImagePath);
      expect(result.logoLargeImagePath, model.logoLargeImagePath);
      expect(result.logoImageAltText, model.logoImageAltText);
      expect(result.urlSegment, model.urlSegment);
    });

    test('should correctly map BrandEntity to Brand', () {
      // Arrange
      const entity = BrandEntity(
        id: "2",
        name: "Adidas",
        detailPagePath: "/brands/adidas",
        logoSmallImagePath: "/images/adidas_small.png",
        logoLargeImagePath: "/images/adidas_large.png",
        logoImageAltText: "Adidas Logo",
        urlSegment: "adidas",
      );

      // Act
      final result = BrandEntityMapper.toModel(entity);

      // Assert
      expect(result.id, entity.id);
      expect(result.name, entity.name);
      expect(result.detailPagePath, entity.detailPagePath);
      expect(result.logoSmallImagePath, entity.logoSmallImagePath);
      expect(result.logoLargeImagePath, entity.logoLargeImagePath);
      expect(result.logoImageAltText, entity.logoImageAltText);
      expect(result.urlSegment, entity.urlSegment);
    });

    test('should handle null Brand model correctly', () {
      // Act
      final result = BrandEntityMapper.toEntity(null);

      // Assert
      expect(result.id, isNull);
      expect(result.name, isNull);
      expect(result.detailPagePath, isNull);
      expect(result.logoSmallImagePath, isNull);
      expect(result.logoLargeImagePath, isNull);
      expect(result.logoImageAltText, isNull);
      expect(result.urlSegment, isNull);
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
