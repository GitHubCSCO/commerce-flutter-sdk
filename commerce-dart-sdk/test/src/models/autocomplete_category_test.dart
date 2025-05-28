import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AutocompleteCategory', () {
    test('fromJson should create a valid AutocompleteCategory instance', () {
      final json = jsonDecode('''
        {
          "id": "cat1",
          "title": "Category Title",
          "subtitle": "Category Subtitle",
          "url": "http://example.com/category",
          "image": "category.png"
        }
      ''');
      final category = AutocompleteCategory.fromJson(json);

      // Validate fields
      expect(category.id, equals("cat1"));
      expect(category.title, equals("Category Title"));
      expect(category.url, equals("http://example.com/category"));
    });

    test('toJson should convert AutocompleteCategory instance to valid JSON',
        () {
      final category = AutocompleteCategory(
        id: "cat1",
        title: "Category Title",
        subtitle: "Category Subtitle",
        url: "http://example.com/category",
        image: "category.png",
      );

      final json = category.toJson();

      // Validate JSON structure and content
      expect(json['id'], equals("cat1"));
      expect(json['title'], equals("Category Title"));
      expect(json['url'], equals("http://example.com/category"));
    });
  });
}
