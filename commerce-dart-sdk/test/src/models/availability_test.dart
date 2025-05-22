import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('Availability', () {
    test('fromJson should create a valid Availability instance', () {
      final json = jsonDecode('''
        {
          "messageType": 1,
          "message": "Item is in stock",
          "requiresRealTimeInventory": true
        }
      ''');
      final availability = Availability.fromJson(json);

      // Validate fields
      expect(availability.messageType, equals(1));
      expect(availability.message, equals("Item is in stock"));
      expect(availability.requiresRealTimeInventory, isTrue);
    });

    test('toJson should convert Availability instance to valid JSON', () {
      final availability = Availability(
        messageType: 1,
        message: "Item is in stock",
        requiresRealTimeInventory: true,
      );

      final json = availability.toJson();

      // Validate JSON structure and content
      expect(json['messageType'], equals(1));
      expect(json['message'], equals("Item is in stock"));
      expect(json['requiresRealTimeInventory'], isTrue);
    });
  });
}
