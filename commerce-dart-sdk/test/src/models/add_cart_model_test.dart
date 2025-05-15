import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AddCartModel', () {
    test('fromJson should create a valid AddCartModel instance', () {
      final json = jsonDecode('''
        {
          "billToId": "123",
          "shipToId": "456",
          "notes": "Some notes",
          "vmiLocationId": "789"
        }
      ''');
      final addCartModel = AddCartModel.fromJson(json);

      // Validate fields
      expect(addCartModel.billToId, equals("123"));
      expect(addCartModel.shipToId, equals("456"));
      expect(addCartModel.notes, equals("Some notes"));
      expect(addCartModel.vmiLocationId, equals("789"));
    });

    test('toJson should convert AddCartModel instance to valid JSON', () {
      final addCartModel = AddCartModel(
        billToId: "123",
        shipToId: "456",
        notes: "Some notes",
        vmiLocationId: "789",
      );

      final json = addCartModel.toJson();

      // Validate JSON structure and content
      expect(json['billToId'], equals("123"));
      expect(json['shipToId'], equals("456"));
      expect(json['notes'], equals("Some notes"));
      expect(json['vmiLocationId'], equals("789"));
    });
  });
}
