import 'package:commerce_flutter_sdk/src/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_image_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ProductImageEntityMapper', () {
    test('should correctly map ProductImage to ProductImageEntity', () {
      // Arrange
      final productImage = ProductImage(
        id: 'img_001',
        sortOrder: 1,
        name: 'Product Main Image',
        smallImagePath:
            'https://example.com/images/small/product_001_small.jpg',
        mediumImagePath:
            'https://example.com/images/medium/product_001_medium.jpg',
        largeImagePath:
            'https://example.com/images/large/product_001_large.jpg',
        altText: 'High-quality product image showing front view',
        imageType: 'primary',
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      expect(result.id, equals('img_001'));
      expect(result.sortOrder, equals(1));
      expect(result.name, equals('Product Main Image'));
      expect(result.smallImagePath,
          equals('https://example.com/images/small/product_001_small.jpg'));
      expect(result.mediumImagePath,
          equals('https://example.com/images/medium/product_001_medium.jpg'));
      expect(result.largeImagePath,
          equals('https://example.com/images/large/product_001_large.jpg'));
      expect(result.altText,
          equals('High-quality product image showing front view'));
      expect(result.imageType, equals('primary'));
    });

    test('should correctly map ProductImageEntity to ProductImage', () {
      // Arrange
      const productImageEntity = ProductImageEntity(
        id: 'img_002',
        sortOrder: 2,
        name: 'Product Side View',
        smallImagePath: 'https://cdn.example.com/thumb/product_002.jpg',
        mediumImagePath: 'https://cdn.example.com/medium/product_002.jpg',
        largeImagePath: 'https://cdn.example.com/full/product_002.jpg',
        altText: 'Product side view with detailed features',
        imageType: 'secondary',
      );

      // Act
      final result = ProductImageEntityMapper.toModel(productImageEntity);

      // Assert
      expect(result.id, equals('img_002'));
      expect(result.sortOrder, equals(2));
      expect(result.name, equals('Product Side View'));
      expect(result.smallImagePath,
          equals('https://cdn.example.com/thumb/product_002.jpg'));
      expect(result.mediumImagePath,
          equals('https://cdn.example.com/medium/product_002.jpg'));
      expect(result.largeImagePath,
          equals('https://cdn.example.com/full/product_002.jpg'));
      expect(
          result.altText, equals('Product side view with detailed features'));
      expect(result.imageType, equals('secondary'));
    });

    test('should handle ProductImage with all null fields', () {
      // Arrange
      final productImage = ProductImage(
        id: null,
        sortOrder: null,
        name: null,
        smallImagePath: null,
        mediumImagePath: null,
        largeImagePath: null,
        altText: null,
        imageType: null,
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      expect(result.id, isNull);
      expect(result.sortOrder, isNull);
      expect(result.name, isNull);
      expect(result.smallImagePath, isNull);
      expect(result.mediumImagePath, isNull);
      expect(result.largeImagePath, isNull);
      expect(result.altText, isNull);
      expect(result.imageType, isNull);
    });

    test('should handle ProductImageEntity with all null fields', () {
      // Arrange
      const productImageEntity = ProductImageEntity(
        id: null,
        sortOrder: null,
        name: null,
        smallImagePath: null,
        mediumImagePath: null,
        largeImagePath: null,
        altText: null,
        imageType: null,
      );

      // Act
      final result = ProductImageEntityMapper.toModel(productImageEntity);

      // Assert
      expect(result.id, isNull);
      expect(result.sortOrder, isNull);
      expect(result.name, isNull);
      expect(result.smallImagePath, isNull);
      expect(result.mediumImagePath, isNull);
      expect(result.largeImagePath, isNull);
      expect(result.altText, isNull);
      expect(result.imageType, isNull);
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final productImage = ProductImage(
        id: '',
        sortOrder: 0,
        name: '',
        smallImagePath: '',
        mediumImagePath: '',
        largeImagePath: '',
        altText: '',
        imageType: '',
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      expect(result.id, equals(''));
      expect(result.sortOrder, equals(0));
      expect(result.name, equals(''));
      expect(result.smallImagePath, equals(''));
      expect(result.mediumImagePath, equals(''));
      expect(result.largeImagePath, equals(''));
      expect(result.altText, equals(''));
      expect(result.imageType, equals(''));
    });

    test('should handle different sort orders correctly', () {
      // Arrange
      final testCases = [
        {'sortOrder': -1, 'description': 'negative sort order'},
        {'sortOrder': 0, 'description': 'zero sort order'},
        {'sortOrder': 1, 'description': 'positive sort order'},
        {'sortOrder': 999, 'description': 'large sort order'},
      ];

      for (final testCase in testCases) {
        // Arrange
        final productImage = ProductImage(
          id: 'img_sort_test',
          sortOrder: testCase['sortOrder'] as int,
          name: 'Sort Order Test Image',
          smallImagePath: 'https://example.com/small.jpg',
          mediumImagePath: 'https://example.com/medium.jpg',
          largeImagePath: 'https://example.com/large.jpg',
          altText: 'Test image for ${testCase['description']}',
          imageType: 'test',
        );

        // Act
        final result = ProductImageEntityMapper.toEntity(productImage);

        // Assert
        expect(result.sortOrder, equals(testCase['sortOrder']),
            reason: 'Failed for ${testCase['description']}');
        expect(result.altText,
            equals('Test image for ${testCase['description']}'));
      }
    });

    test('should handle various image types correctly', () {
      // Arrange
      final imageTypes = [
        'primary',
        'secondary',
        'thumbnail',
        'gallery',
        'detail',
        'zoom',
        '360',
        'video_thumbnail'
      ];

      for (final imageType in imageTypes) {
        // Arrange
        final productImage = ProductImage(
          id: 'img_${imageType}_test',
          sortOrder: 1,
          name: 'Test Image - $imageType',
          smallImagePath: 'https://example.com/small_$imageType.jpg',
          mediumImagePath: 'https://example.com/medium_$imageType.jpg',
          largeImagePath: 'https://example.com/large_$imageType.jpg',
          altText: 'Test image of type $imageType',
          imageType: imageType,
        );

        // Act
        final result = ProductImageEntityMapper.toEntity(productImage);

        // Assert
        expect(result.imageType, equals(imageType),
            reason: 'Failed for image type: $imageType');
        expect(result.name, equals('Test Image - $imageType'));
        expect(result.altText, equals('Test image of type $imageType'));
      }
    });

    test('should handle complex image paths correctly', () {
      // Arrange
      final productImage = ProductImage(
        id: 'img_complex_paths',
        sortOrder: 1,
        name: 'Complex Path Test Image',
        smallImagePath:
            'https://cdn.example.com/v2/images/products/electronics/phones/iphone/small/iphone_14_pro_max_deep_purple_small.webp?v=1.2.3&quality=80&format=webp',
        mediumImagePath:
            'https://cdn.example.com/v2/images/products/electronics/phones/iphone/medium/iphone_14_pro_max_deep_purple_medium.webp?v=1.2.3&quality=90&format=webp',
        largeImagePath:
            'https://cdn.example.com/v2/images/products/electronics/phones/iphone/large/iphone_14_pro_max_deep_purple_large.webp?v=1.2.3&quality=95&format=webp',
        altText:
            'iPhone 14 Pro Max in Deep Purple color - high resolution product image',
        imageType: 'product_hero',
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      expect(
          result.smallImagePath,
          equals(
              'https://cdn.example.com/v2/images/products/electronics/phones/iphone/small/iphone_14_pro_max_deep_purple_small.webp?v=1.2.3&quality=80&format=webp'));
      expect(
          result.mediumImagePath,
          equals(
              'https://cdn.example.com/v2/images/products/electronics/phones/iphone/medium/iphone_14_pro_max_deep_purple_medium.webp?v=1.2.3&quality=90&format=webp'));
      expect(
          result.largeImagePath,
          equals(
              'https://cdn.example.com/v2/images/products/electronics/phones/iphone/large/iphone_14_pro_max_deep_purple_large.webp?v=1.2.3&quality=95&format=webp'));
      expect(
          result.altText,
          equals(
              'iPhone 14 Pro Max in Deep Purple color - high resolution product image'));
      expect(result.imageType, equals('product_hero'));
    });

    test('should handle special characters in names and alt text correctly',
        () {
      // Arrange
      final productImage = ProductImage(
        id: 'img_special_chars',
        sortOrder: 1,
        name:
            'Café & Restaurant Equipment - "Professional Grade" (Model #2023)',
        smallImagePath: 'https://example.com/café-equipment-small.jpg',
        mediumImagePath: 'https://example.com/café-equipment-medium.jpg',
        largeImagePath: 'https://example.com/café-equipment-large.jpg',
        altText:
            'Professional café equipment featuring stainless steel construction & modern design - €2,499 value',
        imageType: 'equipment_showcase',
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      expect(
          result.name,
          equals(
              'Café & Restaurant Equipment - "Professional Grade" (Model #2023)'));
      expect(
          result.altText,
          equals(
              'Professional café equipment featuring stainless steel construction & modern design - €2,499 value'));
      expect(result.smallImagePath,
          equals('https://example.com/café-equipment-small.jpg'));
      expect(result.imageType, equals('equipment_showcase'));
    });

    test('should handle mixed null and non-null fields correctly', () {
      // Arrange
      final productImage = ProductImage(
        id: 'img_mixed_nulls',
        sortOrder: null,
        name: 'Partial Image Data',
        smallImagePath: null,
        mediumImagePath: 'https://example.com/medium_only.jpg',
        largeImagePath: null,
        altText: 'Image with only medium size available',
        imageType: null,
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      expect(result.id, equals('img_mixed_nulls'));
      expect(result.sortOrder, isNull);
      expect(result.name, equals('Partial Image Data'));
      expect(result.smallImagePath, isNull);
      expect(result.mediumImagePath,
          equals('https://example.com/medium_only.jpg'));
      expect(result.largeImagePath, isNull);
      expect(result.altText, equals('Image with only medium size available'));
      expect(result.imageType, isNull);
    });

    test('should handle very long names and alt text correctly', () {
      // Arrange
      final longName =
          'Professional Grade Industrial Equipment for Commercial Kitchen Applications with Advanced Temperature Control and Energy Efficiency Features' *
              3;
      final longAltText =
          'Detailed product image showing the complete industrial kitchen equipment with all accessories, temperature controls, safety features, and energy efficiency indicators visible' *
              2;

      final productImage = ProductImage(
        id: 'img_long_text',
        sortOrder: 5,
        name: longName,
        smallImagePath: 'https://example.com/long_name_small.jpg',
        mediumImagePath: 'https://example.com/long_name_medium.jpg',
        largeImagePath: 'https://example.com/long_name_large.jpg',
        altText: longAltText,
        imageType: 'detailed_view',
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      expect(result.name, equals(longName));
      expect(result.altText, equals(longAltText));
      expect(result.id, equals('img_long_text'));
      expect(result.sortOrder, equals(5));
      expect(result.imageType, equals('detailed_view'));
    });

    test('should handle copyWith functionality correctly', () {
      // Arrange
      const originalEntity = ProductImageEntity(
        id: 'img_original',
        sortOrder: 1,
        name: 'Original Image',
        smallImagePath: 'https://example.com/original_small.jpg',
        mediumImagePath: 'https://example.com/original_medium.jpg',
        largeImagePath: 'https://example.com/original_large.jpg',
        altText: 'Original alt text',
        imageType: 'original',
      );

      // Act
      final copiedEntity = originalEntity.copyWith(
        name: 'Updated Image Name',
        sortOrder: 2,
        altText: 'Updated alt text',
      );

      // Assert
      expect(copiedEntity.id, equals('img_original')); // unchanged
      expect(copiedEntity.sortOrder, equals(2)); // changed
      expect(copiedEntity.name, equals('Updated Image Name')); // changed
      expect(copiedEntity.smallImagePath,
          equals('https://example.com/original_small.jpg')); // unchanged
      expect(copiedEntity.mediumImagePath,
          equals('https://example.com/original_medium.jpg')); // unchanged
      expect(copiedEntity.largeImagePath,
          equals('https://example.com/original_large.jpg')); // unchanged
      expect(copiedEntity.altText, equals('Updated alt text')); // changed
      expect(copiedEntity.imageType, equals('original')); // unchanged
    });

    test('should handle roundtrip conversion correctly', () {
      // Arrange
      final originalImage = ProductImage(
        id: 'img_roundtrip',
        sortOrder: 3,
        name: 'Roundtrip Test Image',
        smallImagePath: 'https://example.com/roundtrip_small.jpg',
        mediumImagePath: 'https://example.com/roundtrip_medium.jpg',
        largeImagePath: 'https://example.com/roundtrip_large.jpg',
        altText: 'Image for testing roundtrip conversion',
        imageType: 'test_image',
      );

      // Act
      final entity = ProductImageEntityMapper.toEntity(originalImage);
      final convertedBack = ProductImageEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.id, equals(originalImage.id));
      expect(convertedBack.sortOrder, equals(originalImage.sortOrder));
      expect(convertedBack.name, equals(originalImage.name));
      expect(
          convertedBack.smallImagePath, equals(originalImage.smallImagePath));
      expect(
          convertedBack.mediumImagePath, equals(originalImage.mediumImagePath));
      expect(
          convertedBack.largeImagePath, equals(originalImage.largeImagePath));
      expect(convertedBack.altText, equals(originalImage.altText));
      expect(convertedBack.imageType, equals(originalImage.imageType));
    });

    test('should handle entity JSON serialization correctly', () {
      // Arrange
      const productImageEntity = ProductImageEntity(
        id: 'img_json_test',
        sortOrder: 4,
        name: 'JSON Test Image',
        smallImagePath: 'https://example.com/json_small.jpg',
        mediumImagePath: 'https://example.com/json_medium.jpg',
        largeImagePath: 'https://example.com/json_large.jpg',
        altText: 'Image for testing JSON serialization',
        imageType: 'json_test',
      );

      // Act
      final json = productImageEntity.toJson();
      final fromJson = ProductImageEntity.fromJson(json);

      // Assert
      expect(fromJson.id, equals(productImageEntity.id));
      expect(fromJson.sortOrder, equals(productImageEntity.sortOrder));
      expect(fromJson.name, equals(productImageEntity.name));
      expect(
          fromJson.smallImagePath, equals(productImageEntity.smallImagePath));
      expect(
          fromJson.mediumImagePath, equals(productImageEntity.mediumImagePath));
      expect(
          fromJson.largeImagePath, equals(productImageEntity.largeImagePath));
      expect(fromJson.altText, equals(productImageEntity.altText));
      expect(fromJson.imageType, equals(productImageEntity.imageType));
    });

    test('should handle entity equality correctly', () {
      // Arrange
      const entity1 = ProductImageEntity(
        id: 'img_equality_test',
        sortOrder: 1,
        name: 'Equality Test Image',
        smallImagePath: 'https://example.com/equality_small.jpg',
        mediumImagePath: 'https://example.com/equality_medium.jpg',
        largeImagePath: 'https://example.com/equality_large.jpg',
        altText: 'Image for testing equality',
        imageType: 'equality_test',
      );

      const entity2 = ProductImageEntity(
        id: 'img_equality_test',
        sortOrder: 1,
        name: 'Equality Test Image',
        smallImagePath: 'https://example.com/equality_small.jpg',
        mediumImagePath: 'https://example.com/equality_medium.jpg',
        largeImagePath: 'https://example.com/equality_large.jpg',
        altText: 'Image for testing equality',
        imageType: 'equality_test',
      );

      const entity3 = ProductImageEntity(
        id: 'img_different',
        sortOrder: 1,
        name: 'Equality Test Image',
        smallImagePath: 'https://example.com/equality_small.jpg',
        mediumImagePath: 'https://example.com/equality_medium.jpg',
        largeImagePath: 'https://example.com/equality_large.jpg',
        altText: 'Image for testing equality',
        imageType: 'equality_test',
      );

      // Act & Assert
      expect(entity1, equals(entity2)); // Should be equal
      expect(entity1,
          isNot(equals(entity3))); // Should not be equal (different id)
      expect(entity1.hashCode,
          equals(entity2.hashCode)); // Hash codes should be equal
    });

    test('should handle malformed URLs gracefully', () {
      // Arrange
      final productImage = ProductImage(
        id: 'img_malformed_urls',
        sortOrder: 1,
        name: 'Malformed URL Test',
        smallImagePath: 'not-a-valid-url',
        mediumImagePath: 'ftp://invalid-protocol.com/image.jpg',
        largeImagePath: 'https://missing-domain',
        altText: 'Image with malformed URLs',
        imageType: 'url_test',
      );

      // Act
      final result = ProductImageEntityMapper.toEntity(productImage);

      // Assert
      // The mapper should handle malformed URLs as strings without validation
      expect(result.smallImagePath, equals('not-a-valid-url'));
      expect(result.mediumImagePath,
          equals('ftp://invalid-protocol.com/image.jpg'));
      expect(result.largeImagePath, equals('https://missing-domain'));
      expect(result.altText, equals('Image with malformed URLs'));
      expect(result.imageType, equals('url_test'));
    });
  });
}
