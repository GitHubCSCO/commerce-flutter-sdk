import 'package:commerce_flutter_sdk/src/features/domain/entity/product_content_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_content_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ProductContentEntityMapper', () {
    late ProductContentEntityMapper mapper;

    setUp(() {
      mapper = ProductContentEntityMapper();
    });

    test('should correctly map ProductContent to ProductContentEntity', () {
      // Arrange
      final productContent = ProductContent(
        htmlContent:
            '<h1>Product Description</h1><p>This is a great product.</p>',
        metaDescription: 'A comprehensive product description for SEO',
        pageTitle: 'Amazing Product - Best in Class',
        metaKeywords: 'product, amazing, best, quality, electronics',
        openGraphImage: 'https://example.com/images/product-og.jpg',
        openGraphTitle: 'Amazing Product | Our Store',
        openGraphUrl: 'https://example.com/products/amazing-product',
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      expect(
          result.htmlContent,
          equals(
              '<h1>Product Description</h1><p>This is a great product.</p>'));
      expect(result.metaDescription,
          equals('A comprehensive product description for SEO'));
      expect(result.pageTitle, equals('Amazing Product - Best in Class'));
      expect(result.metaKeywords,
          equals('product, amazing, best, quality, electronics'));
      expect(result.openGraphImage,
          equals('https://example.com/images/product-og.jpg'));
      expect(result.openGraphTitle, equals('Amazing Product | Our Store'));
      expect(result.openGraphUrl,
          equals('https://example.com/products/amazing-product'));
    });

    test('should correctly map ProductContentEntity to ProductContent', () {
      // Arrange
      const productContentEntity = ProductContentEntity(
        htmlContent: '<div>Rich content with HTML</div>',
        metaDescription: 'SEO optimized description',
        pageTitle: 'Product Page Title',
        metaKeywords: 'keyword1, keyword2, keyword3',
        openGraphImage: 'https://cdn.example.com/og-image.png',
        openGraphTitle: 'Social Media Title',
        openGraphUrl: 'https://store.example.com/product/123',
      );

      // Act
      final result = mapper.toModel(productContentEntity);

      // Assert
      expect(result, isNotNull);
      expect(result!.htmlContent, equals('<div>Rich content with HTML</div>'));
      expect(result.metaDescription, equals('SEO optimized description'));
      expect(result.pageTitle, equals('Product Page Title'));
      expect(result.metaKeywords, equals('keyword1, keyword2, keyword3'));
      expect(result.openGraphImage,
          equals('https://cdn.example.com/og-image.png'));
      expect(result.openGraphTitle, equals('Social Media Title'));
      expect(
          result.openGraphUrl, equals('https://store.example.com/product/123'));
    });

    test('should handle null ProductContent model correctly', () {
      // Act
      final result = mapper.toEntity(null);

      // Assert
      expect(result.htmlContent, isNull);
      expect(result.metaDescription, isNull);
      expect(result.pageTitle, isNull);
      expect(result.metaKeywords, isNull);
      expect(result.openGraphImage, isNull);
      expect(result.openGraphTitle, isNull);
      expect(result.openGraphUrl, isNull);
    });

    test('should handle ProductContent with all null fields', () {
      // Arrange
      final productContent = ProductContent(
        htmlContent: null,
        metaDescription: null,
        pageTitle: null,
        metaKeywords: null,
        openGraphImage: null,
        openGraphTitle: null,
        openGraphUrl: null,
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      expect(result.htmlContent, isNull);
      expect(result.metaDescription, isNull);
      expect(result.pageTitle, isNull);
      expect(result.metaKeywords, isNull);
      expect(result.openGraphImage, isNull);
      expect(result.openGraphTitle, isNull);
      expect(result.openGraphUrl, isNull);
    });

    test('should handle ProductContentEntity with all null fields', () {
      // Arrange
      const productContentEntity = ProductContentEntity(
        htmlContent: null,
        metaDescription: null,
        pageTitle: null,
        metaKeywords: null,
        openGraphImage: null,
        openGraphTitle: null,
        openGraphUrl: null,
      );

      // Act
      final result = mapper.toModel(productContentEntity);

      // Assert
      expect(result, isNotNull);
      expect(result!.htmlContent, isNull);
      expect(result.metaDescription, isNull);
      expect(result.pageTitle, isNull);
      expect(result.metaKeywords, isNull);
      expect(result.openGraphImage, isNull);
      expect(result.openGraphTitle, isNull);
      expect(result.openGraphUrl, isNull);
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final productContent = ProductContent(
        htmlContent: '',
        metaDescription: '',
        pageTitle: '',
        metaKeywords: '',
        openGraphImage: '',
        openGraphTitle: '',
        openGraphUrl: '',
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      expect(result.htmlContent, equals(''));
      expect(result.metaDescription, equals(''));
      expect(result.pageTitle, equals(''));
      expect(result.metaKeywords, equals(''));
      expect(result.openGraphImage, equals(''));
      expect(result.openGraphTitle, equals(''));
      expect(result.openGraphUrl, equals(''));
    });

    test('should handle complex HTML content correctly', () {
      // Arrange
      const complexHtml = '''
        <div class="product-description">
          <h2>Features</h2>
          <ul>
            <li>High quality materials</li>
            <li>Durable construction</li>
            <li>Easy to use</li>
          </ul>
          <p>Available in multiple <strong>colors</strong> and <em>sizes</em>.</p>
          <img src="https://example.com/feature-image.jpg" alt="Product feature" />
        </div>
      ''';

      final productContent = ProductContent(
        htmlContent: complexHtml,
        metaDescription: 'Complex product with multiple features',
        pageTitle: 'Feature-Rich Product',
        metaKeywords: 'features, quality, durable, colors, sizes',
        openGraphImage: 'https://example.com/complex-og.jpg',
        openGraphTitle: 'Feature-Rich Product | Premium Store',
        openGraphUrl: 'https://example.com/products/feature-rich',
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      expect(result.htmlContent, equals(complexHtml));
      expect(result.metaDescription,
          equals('Complex product with multiple features'));
      expect(result.pageTitle, equals('Feature-Rich Product'));
      expect(result.metaKeywords,
          equals('features, quality, durable, colors, sizes'));
      expect(
          result.openGraphImage, equals('https://example.com/complex-og.jpg'));
      expect(result.openGraphTitle,
          equals('Feature-Rich Product | Premium Store'));
      expect(result.openGraphUrl,
          equals('https://example.com/products/feature-rich'));
    });

    test('should handle special characters and Unicode correctly', () {
      // Arrange
      final productContent = ProductContent(
        htmlContent: '<p>Café & Résumé with €50 discount! 🎉</p>',
        metaDescription: 'Special café product with résumé features - €50 off!',
        pageTitle: 'Café Product - Résumé Style - €50 Discount',
        metaKeywords: 'café, résumé, €50, discount, special, 🎉',
        openGraphImage: 'https://example.com/café-product.jpg',
        openGraphTitle: 'Café & Résumé Product - €50 Off! 🎉',
        openGraphUrl: 'https://example.com/products/café-résumé',
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      expect(result.htmlContent,
          equals('<p>Café & Résumé with €50 discount! 🎉</p>'));
      expect(result.metaDescription,
          equals('Special café product with résumé features - €50 off!'));
      expect(result.pageTitle,
          equals('Café Product - Résumé Style - €50 Discount'));
      expect(result.metaKeywords,
          equals('café, résumé, €50, discount, special, 🎉'));
      expect(result.openGraphImage,
          equals('https://example.com/café-product.jpg'));
      expect(
          result.openGraphTitle, equals('Café & Résumé Product - €50 Off! 🎉'));
      expect(result.openGraphUrl,
          equals('https://example.com/products/café-résumé'));
    });

    test('should handle very long content correctly', () {
      // Arrange
      final longContent =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' * 100;
      final longKeywords = List.generate(50, (i) => 'keyword$i').join(', ');

      final productContent = ProductContent(
        htmlContent: '<div>$longContent</div>',
        metaDescription:
            longContent.substring(0, 160), // Typical meta description length
        pageTitle: 'Very Long Product Title That Exceeds Normal Length Limits',
        metaKeywords: longKeywords,
        openGraphImage: 'https://example.com/very-long-product-name-image.jpg',
        openGraphTitle: 'Very Long Open Graph Title That Might Be Truncated',
        openGraphUrl: 'https://example.com/products/very-long-product-url-slug',
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      expect(result.htmlContent, equals('<div>$longContent</div>'));
      expect(result.metaDescription, equals(longContent.substring(0, 160)));
      expect(result.pageTitle,
          equals('Very Long Product Title That Exceeds Normal Length Limits'));
      expect(result.metaKeywords, equals(longKeywords));
      expect(result.openGraphImage,
          equals('https://example.com/very-long-product-name-image.jpg'));
      expect(result.openGraphTitle,
          equals('Very Long Open Graph Title That Might Be Truncated'));
      expect(result.openGraphUrl,
          equals('https://example.com/products/very-long-product-url-slug'));
    });

    test('should handle mixed null and non-null fields correctly', () {
      // Arrange
      final productContent = ProductContent(
        htmlContent: '<p>Only HTML content provided</p>',
        metaDescription: null,
        pageTitle: 'Only Page Title',
        metaKeywords: null,
        openGraphImage: 'https://example.com/only-image.jpg',
        openGraphTitle: null,
        openGraphUrl: null,
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      expect(result.htmlContent, equals('<p>Only HTML content provided</p>'));
      expect(result.metaDescription, isNull);
      expect(result.pageTitle, equals('Only Page Title'));
      expect(result.metaKeywords, isNull);
      expect(
          result.openGraphImage, equals('https://example.com/only-image.jpg'));
      expect(result.openGraphTitle, isNull);
      expect(result.openGraphUrl, isNull);
    });

    test('should handle copyWith functionality correctly', () {
      // Arrange
      const originalEntity = ProductContentEntity(
        htmlContent: '<p>Original content</p>',
        metaDescription: 'Original description',
        pageTitle: 'Original title',
        metaKeywords: 'original, keywords',
        openGraphImage: 'https://example.com/original.jpg',
        openGraphTitle: 'Original OG title',
        openGraphUrl: 'https://example.com/original',
      );

      // Act
      final copiedEntity = originalEntity.copyWith(
        htmlContent: '<p>Updated content</p>',
        pageTitle: 'Updated title',
        openGraphImage: 'https://example.com/updated.jpg',
      );

      // Assert
      expect(copiedEntity.htmlContent, equals('<p>Updated content</p>'));
      expect(copiedEntity.metaDescription,
          equals('Original description')); // unchanged
      expect(copiedEntity.pageTitle, equals('Updated title'));
      expect(
          copiedEntity.metaKeywords, equals('original, keywords')); // unchanged
      expect(copiedEntity.openGraphImage,
          equals('https://example.com/updated.jpg'));
      expect(copiedEntity.openGraphTitle,
          equals('Original OG title')); // unchanged
      expect(copiedEntity.openGraphUrl,
          equals('https://example.com/original')); // unchanged
    });

    test('should handle roundtrip conversion correctly', () {
      // Arrange
      final originalContent = ProductContent(
        htmlContent: '<div>Roundtrip test content</div>',
        metaDescription: 'Roundtrip meta description',
        pageTitle: 'Roundtrip Page Title',
        metaKeywords: 'roundtrip, test, conversion',
        openGraphImage: 'https://example.com/roundtrip.jpg',
        openGraphTitle: 'Roundtrip OG Title',
        openGraphUrl: 'https://example.com/roundtrip',
      );

      // Act
      final entity = mapper.toEntity(originalContent);
      final convertedBack = mapper.toModel(entity);

      // Assert
      expect(convertedBack, isNotNull);
      expect(convertedBack!.htmlContent, equals(originalContent.htmlContent));
      expect(convertedBack.metaDescription,
          equals(originalContent.metaDescription));
      expect(convertedBack.pageTitle, equals(originalContent.pageTitle));
      expect(convertedBack.metaKeywords, equals(originalContent.metaKeywords));
      expect(
          convertedBack.openGraphImage, equals(originalContent.openGraphImage));
      expect(
          convertedBack.openGraphTitle, equals(originalContent.openGraphTitle));
      expect(convertedBack.openGraphUrl, equals(originalContent.openGraphUrl));
    });

    test('should handle malformed URLs gracefully', () {
      // Arrange
      final productContent = ProductContent(
        htmlContent: '<p>Content with malformed URLs</p>',
        metaDescription: 'Product with various URL formats',
        pageTitle: 'URL Test Product',
        metaKeywords: 'url, test, malformed',
        openGraphImage: 'not-a-valid-url',
        openGraphTitle: 'URL Test Product',
        openGraphUrl: 'also-not-valid-url',
      );

      // Act
      final result = mapper.toEntity(productContent);

      // Assert
      // The mapper should handle malformed URLs as strings without validation
      expect(result.openGraphImage, equals('not-a-valid-url'));
      expect(result.openGraphUrl, equals('also-not-valid-url'));
      expect(result.htmlContent, equals('<p>Content with malformed URLs</p>'));
      expect(
          result.metaDescription, equals('Product with various URL formats'));
      expect(result.pageTitle, equals('URL Test Product'));
      expect(result.metaKeywords, equals('url, test, malformed'));
      expect(result.openGraphTitle, equals('URL Test Product'));
    });
  });
}
