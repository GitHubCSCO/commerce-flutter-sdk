import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AddressFieldDisplay', () {
    test('fromJson should create a valid AddressFieldDisplay instance', () {
      final json = jsonDecode('''
        {
          "displayName": "Street Address",
          "isVisible": true
        }
      ''');
      final addressFieldDisplay = AddressFieldDisplay.fromJson(json);

      // Validate fields
      expect(addressFieldDisplay.displayName, equals("Street Address"));
      expect(addressFieldDisplay.isVisible, equals(true));
    });

    test('toJson should convert AddressFieldDisplay instance to valid JSON',
        () {
      final addressFieldDisplay = AddressFieldDisplay(
        displayName: "Street Address",
        isVisible: true,
      );

      final json = addressFieldDisplay.toJson();

      // Validate JSON structure and content
      expect(json['displayName'], equals("Street Address"));
      expect(json['isVisible'], equals(true));
    });
  });
}
