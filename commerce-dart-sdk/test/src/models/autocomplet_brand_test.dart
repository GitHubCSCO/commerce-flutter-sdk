import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AutocompleteBrand', () {
    test('fromJson should create a valid AutocompleteBrand instance', () {
      final json = jsonDecode('''
        {
          "id": "brand1",
          "title": "Brand Title",
          "subtitle": "Brand Subtitle",
          "url": "http://example.com/brand",
          "image": "brand.png",
          "productLineId": "line123",
          "productLineName": "Product Line Name"
        }
      ''');
      final brand = AutocompleteBrand.fromJson(json);

      // Validate fields
      expect(brand.id, equals("brand1"));
      expect(brand.title, equals("Brand Title"));
      expect(brand.productLineName, equals("Product Line Name"));
    });

    test('toJson should convert AutocompleteBrand instance to valid JSON', () {
      final brand = AutocompleteBrand(
        id: "brand1",
        title: "Brand Title",
        subtitle: "Brand Subtitle",
        url: "http://example.com/brand",
        image: "brand.png",
        productLineId: "line123",
        productLineName: "Product Line Name",
      );

      final json = brand.toJson();

      // Validate JSON structure and content
      expect(json['id'], equals("brand1"));
      expect(json['title'], equals("Brand Title"));
      expect(json['productLineName'], equals("Product Line Name"));
    });
  });
}
