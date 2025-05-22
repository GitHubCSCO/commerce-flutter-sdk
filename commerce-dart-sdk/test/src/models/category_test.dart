import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final category = Category();
  test('should be subclass of [BaseModel]', () {
    // Act
    // Don't need to act, because there is no function, we just want to make sure Category is a BaseModel
    // Assert
    expect(category, isA<BaseModel>());
  });

  Map<String, dynamic> modelJson =
      jsonDecode(fixture('CategoriesV1_GetByIdAsync.json'));

  group('Category', () {
    test('fromJson should create a valid Category instance', () {
      // Act
      final category = Category.fromJson(modelJson);

      // Assert
      expect(category.uri, equals("string"));
      expect(category.id, equals("00000000-0000-0000-0000-000000000000"));
      expect(category.name, equals("string"));
      expect(category.shortDescription, equals("string"));
      expect(category.urlSegment, equals("string"));
      expect(category.smallImagePath, equals("string"));
      expect(category.largeImagePath, equals("string"));
      expect(category.imageAltText, equals("string"));
      expect(category.activateOn,
          equals(DateTime.parse("2023-12-25T05:27:40.686Z")));
      expect(category.deactivateOn,
          equals(DateTime.parse("2023-12-25T05:27:40.686Z")));
      expect(category.metaKeywords, equals("string"));
      expect(category.metaDescription, equals("string"));
      expect(category.htmlContent, equals("string"));
      expect(category.sortOrder, 0);
      expect(category.isFeatured, true);
      expect(category.isDynamic, true);
      expect(category.subCategories, isList);
      expect(category.subCategories, everyElement(isA<Category>()));
      expect(category.path, equals("string"));
      expect(category.mobileBannerImageUrl, equals("string"));
      expect(category.mobilePrimaryText, equals("string"));
      expect(category.mobileSecondaryText, equals("string"));
      expect(category.mobileTextJustification, equals("string"));
      expect(category.mobileTextColor, equals("string"));
      expect(category.properties, isNotNull);
      expect(category.properties, containsPair("key1", "string"));
      expect(category.properties, containsPair("key2", null));
    });

    test('toJson should convert Category instance to a valid JSON', () {
      // Arrange
      final category = Category(
        id: "00000000-0000-0000-0000-000000000000",
        name: "string",
        shortDescription: "string",
        urlSegment: "string",
        smallImagePath: "string",
        largeImagePath: "string",
        imageAltText: "string",
        activateOn: DateTime.parse("2023-12-25T05:27:40.686Z"),
        deactivateOn: DateTime.parse("2023-12-25T05:27:40.686Z"),
        metaKeywords: "string",
        metaDescription: "string",
        htmlContent: "string",
        sortOrder: 0,
        isFeatured: true,
        isDynamic: true,
        subCategories: null,
        path: "string",
        mobileBannerImageUrl: "string",
        mobilePrimaryText: "string",
        mobileSecondaryText: "string",
        mobileTextJustification: "string",
        mobileTextColor: "string",
      )
        ..uri = "string"
        ..properties = null;

      // Act
      Map<String, dynamic> json = category.toJson();
      expect(json, isNot(json.containsKey('subCategories')));
      expect(json, isNot(equals(modelJson)));
      // Let's add those null properties inside json map
      category.subCategories = [
        Category(
          id: "00000000-0000-0000-0000-000000000000",
          name: "string",
          shortDescription: "string",
          urlSegment: "string",
          smallImagePath: "string",
          largeImagePath: "string",
          imageAltText: "string",
          activateOn: DateTime.parse("2023-12-25T05:27:40.686Z"),
          deactivateOn: DateTime.parse("2023-12-25T05:27:40.686Z"),
          metaKeywords: "string",
          metaDescription: "string",
          htmlContent: "string",
          sortOrder: 0,
          isFeatured: true,
          isDynamic: true,
          subCategories: null,
          path: "string",
          mobileBannerImageUrl: "string",
          mobilePrimaryText: "string",
          mobileSecondaryText: "string",
          mobileTextJustification: "string",
          mobileTextColor: "string",
        )
          ..uri = "string"
          ..properties = null,
      ];
      json = category.toJson();
      json['properties'] = null;

      json['subCategories'][0]['subCategories'] = null;
      json['subCategories'][0]['properties'] = null;

      modelJson['properties'] = null;
      // Assert
      expect(json, modelJson);
    });
  });
}
