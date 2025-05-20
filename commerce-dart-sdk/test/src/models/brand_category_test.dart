import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('BrandCategory', () {
    test('fromJson should create a valid BrandCategory instance', () {
      final json = jsonDecode('''
        {
          "brandId": "123",
          "categoryId": "456",
          "contentManagerId": "789",
          "categoryName": "Electronics",
          "categoryShortDescription": "Latest gadgets",
          "featuredImagePath": "/images/electronics.png",
          "featuredImageAltText": "Electronics category",
          "productListPagePath": "/products/electronics",
          "htmlContent": "<p>Find the best electronics here</p>",
          "subCategories": [
            {
              "brandId": "123",
              "categoryId": "457",
              "categoryName": "Smartphones",
              "categoryShortDescription": "Latest smartphones",
              "featuredImagePath": "/images/smartphones.png",
              "featuredImageAltText": "Smartphones category",
              "productListPagePath": "/products/smartphones",
              "htmlContent": "<p>Shop for the latest smartphones</p>"
            }
          ]
        }
      ''');

      final brandCategory = BrandCategory.fromJson(json);

      // Validate main category fields
      expect(brandCategory.brandId, equals("123"));
      expect(brandCategory.categoryId, equals("456"));
      expect(brandCategory.categoryName, equals("Electronics"));
      expect(
          brandCategory.featuredImagePath, equals("/images/electronics.png"));
      expect(
          brandCategory.productListPagePath, equals("/products/electronics"));
      expect(brandCategory.htmlContent,
          equals("<p>Find the best electronics here</p>"));

      // Validate subcategory fields
      expect(brandCategory.subCategories?.length, equals(1));
      expect(brandCategory.subCategories?[0]?.categoryId, equals("457"));
      expect(
          brandCategory.subCategories?[0]?.categoryName, equals("Smartphones"));
    });

    test('toJson should convert BrandCategory instance to valid JSON', () {
      final brandCategory = BrandCategory(
        brandId: "123",
        categoryId: "456",
        contentManagerId: "789",
        categoryName: "Electronics",
        categoryShortDescription: "Latest gadgets",
        featuredImagePath: "/images/electronics.png",
        featuredImageAltText: "Electronics category",
        productListPagePath: "/products/electronics",
        htmlContent: "<p>Find the best electronics here</p>",
        subCategories: [
          BrandCategory(
            brandId: "123",
            categoryId: "457",
            categoryName: "Smartphones",
            categoryShortDescription: "Latest smartphones",
            featuredImagePath: "/images/smartphones.png",
            featuredImageAltText: "Smartphones category",
            productListPagePath: "/products/smartphones",
            htmlContent: "<p>Shop for the latest smartphones</p>",
          )
        ],
      );

      final json = brandCategory.toJson();

      // Validate JSON structure and content
      expect(json['brandId'], equals("123"));
      expect(json['categoryId'], equals("456"));
      expect(json['categoryName'], equals("Electronics"));
      expect(json['featuredImagePath'], equals("/images/electronics.png"));
      expect(json['productListPagePath'], equals("/products/electronics"));
      expect(
          json['htmlContent'], equals("<p>Find the best electronics here</p>"));

      // Validate subcategory JSON structure and content
      expect(json['subCategories'][0]['categoryId'], equals("457"));
      expect(json['subCategories'][0]['categoryName'], equals("Smartphones"));
    });

    test('mapCategoryToBrandCategory should correctly map data', () {
      final subCategoryResult = GetBrandSubCategoriesResult(
        brandId: "123",
        categoryId: "457",
        categoryName: "Smartphones",
        categoryShortDescription: "Latest smartphones",
        featuredImagePath: "/images/smartphones.png",
        featuredImageAltText: "Smartphones category",
        productListPagePath: "/products/smartphones",
        htmlContent: "<p>Shop for the latest smartphones</p>",
      );

      final brandCategoryResult = GetBrandSubCategoriesResult(
        brandId: "123",
        categoryId: "456",
        categoryName: "Electronics",
        categoryShortDescription: "Latest gadgets",
        featuredImagePath: "/images/electronics.png",
        featuredImageAltText: "Electronics category",
        productListPagePath: "/products/electronics",
        htmlContent: "<p>Find the best electronics here</p>",
        subCategories: [subCategoryResult],
      );

      final brandCategory =
          BrandCategory.mapCategoryToBrandCategory(brandCategoryResult);

      // Validate main category fields
      expect(brandCategory?.brandId, equals("123"));
      expect(brandCategory?.categoryId, equals("456"));
      expect(brandCategory?.categoryName, equals("Electronics"));
      expect(
          brandCategory?.featuredImagePath, equals("/images/electronics.png"));
      expect(
          brandCategory?.productListPagePath, equals("/products/electronics"));
      expect(brandCategory?.htmlContent,
          equals("<p>Find the best electronics here</p>"));

      // Validate subcategory fields
      expect(brandCategory?.subCategories?.length, equals(1));
      expect(brandCategory?.subCategories?[0]?.categoryId, equals("457"));
      expect(brandCategory?.subCategories?[0]?.categoryName,
          equals("Smartphones"));
      expect(brandCategory?.subCategories?[0]?.htmlContent,
          equals("<p>Shop for the latest smartphones</p>"));
    });
  });
}
