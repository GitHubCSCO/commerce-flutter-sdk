import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('Autocomplete', () {
    test('fromJson should create a valid Autocomplete instance', () {
      final json = jsonDecode('''
        {
          "products": [
            {
              "id": "prod1",
              "title": "Product 1",
              "subtitle": "Subtitle 1",
              "image": "image1.png"
            }
          ]
        }
      ''');
      final autocomplete = Autocomplete.fromJson(json);

      // Validate fields
      expect(autocomplete.products?.length, equals(1));
      expect(autocomplete.products?[0].id, equals("prod1"));
      expect(autocomplete.products?[0].title, equals("Product 1"));
    });

    test('toJson should convert Autocomplete instance to valid JSON', () {
      final autocomplete = Autocomplete(
        products: [
          AutocompleteProduct(
            id: "prod1",
            title: "Product 1",
            subtitle: "Subtitle 1",
            image: "image1.png",
          )
        ],
      );

      final json = autocomplete.toJson();

      // Validate JSON structure and content
      expect(json['products'][0]['id'], equals("prod1"));
      expect(json['products'][0]['title'], equals("Product 1"));
      expect(json['products'][0]['subtitle'], equals("Subtitle 1"));
      expect(json['products'][0]['image'], equals("image1.png"));
    });
  });
}
