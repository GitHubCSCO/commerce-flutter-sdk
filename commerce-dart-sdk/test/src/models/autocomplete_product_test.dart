import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AutocompleteProduct', () {
    test('fromJson should create a valid AutocompleteProduct instance', () {
      final json = jsonDecode('''
        {
          "id": "prod1",
          "title": "Product 1",
          "subtitle": "Subtitle 1",
          "image": "image1.png",
          "name": "Product Name",
          "erpNumber": "12345",
          "url": "http://example.com",
          "manufacturerItemNumber": "M123",
          "isNameCustomerOverride": true,
          "brandName": "Brand A",
          "brandDetailPagePath": "/brand",
          "binNumber": "Bin123"
        }
      ''');
      final product = AutocompleteProduct.fromJson(json);

      // Validate fields
      expect(product.id, equals("prod1"));
      expect(product.title, equals("Product 1"));
      expect(product.isNameCustomerOverride, equals(true));
      expect(product.brandName, equals("Brand A"));
    });

    test('toJson should convert AutocompleteProduct instance to valid JSON',
        () {
      final product = AutocompleteProduct(
        id: "prod1",
        title: "Product 1",
        subtitle: "Subtitle 1",
        image: "image1.png",
        name: "Product Name",
        erpNumber: "12345",
        url: "http://example.com",
        manufacturerItemNumber: "M123",
        isNameCustomerOverride: true,
        brandName: "Brand A",
        brandDetailPagePath: "/brand",
        binNumber: "Bin123",
      );

      final json = product.toJson();

      // Validate JSON structure and content
      expect(json['id'], equals("prod1"));
      expect(json['title'], equals("Product 1"));
      expect(json['isNameCustomerOverride'], equals(true));
      expect(json['brandName'], equals("Brand A"));
    });
  });
}
