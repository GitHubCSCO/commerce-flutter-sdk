import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('BrandProductLine Model', () {
    const brandProductLineJsonString = '''
      {
        "uri": "https://mobilespire.commerce.insitesandbox.com/api/v1/brands/916319a7-5a51-4d90-87ca-ac75014fe5f7/productlines/65d304fc-54c2-4be3-abf6-ac750150e2d3",
        "id": "65d304fc-54c2-4be3-abf6-ac750150e2d3",
        "name": "Commercial",
        "sortOrder": 0,
        "productListPagePath": "/Brands/HeroManufacturing/Commercial",
        "featuredImagePath": "https://d1ants667w2408.cloudfront.net/userfiles/images/powertools/hee3567-300x300.jpg",
        "featuredImageAltText": "asdasdsa",
        "isFeatured": true,
        "isSponsored": false,
        "properties": {}
      }
    ''';

    test('fromJson should create a valid BrandProductLine object from JSON',
        () {
      // Decode the JSON string
      final json = jsonDecode(brandProductLineJsonString);

      // Deserialize JSON to BrandProductLine object
      final brandProductLine = BrandProductLine.fromJson(json);

      // Validate each field
      expect(brandProductLine.id, "65d304fc-54c2-4be3-abf6-ac750150e2d3");
      expect(brandProductLine.name, "Commercial");
      expect(brandProductLine.sortOrder, 0);
      expect(brandProductLine.productListPagePath,
          "/Brands/HeroManufacturing/Commercial");
      expect(brandProductLine.featuredImagePath,
          "https://d1ants667w2408.cloudfront.net/userfiles/images/powertools/hee3567-300x300.jpg");
      expect(brandProductLine.featuredImageAltText, "asdasdsa");
      expect(brandProductLine.isFeatured, true);
      expect(brandProductLine.isSponsored, false);
    });

    test('toJson should convert a BrandProductLine object to JSON map', () {
      // Create a BrandProductLine object
      final brandProductLine = BrandProductLine(
        id: "65d304fc-54c2-4be3-abf6-ac750150e2d3",
        name: "Commercial",
        sortOrder: 0,
        productListPagePath: "/Brands/HeroManufacturing/Commercial",
        featuredImagePath:
            "https://d1ants667w2408.cloudfront.net/userfiles/images/powertools/hee3567-300x300.jpg",
        featuredImageAltText: "asdasdsa",
        isFeatured: true,
        isSponsored: false,
      );

      // Convert to JSON
      final json = brandProductLine.toJson();

      // Validate each field
      expect(json['id'], "65d304fc-54c2-4be3-abf6-ac750150e2d3");
      expect(json['name'], "Commercial");
      expect(json['sortOrder'], 0);
      expect(
          json['productListPagePath'], "/Brands/HeroManufacturing/Commercial");
      expect(json['featuredImagePath'],
          "https://d1ants667w2408.cloudfront.net/userfiles/images/powertools/hee3567-300x300.jpg");
      expect(json['featuredImageAltText'], "asdasdsa");
      expect(json['isFeatured'], true);
      expect(json['isSponsored'], false);
    });
  });
}
