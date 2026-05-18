import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AutocompleteResult', () {
    test('fromJson should parse attributionToken', () {
      final json = jsonDecode('''
        {
          "products": [],
          "isRetailSearchCompletionResults": true,
          "attributionToken": "abc123token"
        }
      ''');
      final result = AutocompleteResult.fromJson(json);

      expect(result.isRetailSearchCompletionResults, isTrue);
      expect(result.attributionToken, equals("abc123token"));
    });

    test('fromJson should handle missing attributionToken', () {
      final json = jsonDecode('''
        {
          "products": [],
          "isRetailSearchCompletionResults": false
        }
      ''');
      final result = AutocompleteResult.fromJson(json);

      expect(result.attributionToken, isNull);
    });

    test('fromJson should handle empty attributionToken', () {
      final json = jsonDecode('''
        {
          "products": [],
          "attributionToken": ""
        }
      ''');
      final result = AutocompleteResult.fromJson(json);

      expect(result.attributionToken, equals(""));
    });

    test('toJson should include attributionToken when present', () {
      final result = AutocompleteResult(
        attributionToken: "abc123token",
        isRetailSearchCompletionResults: true,
      );
      final json = result.toJson();

      expect(json['attributionToken'], equals("abc123token"));
    });
  });
}
