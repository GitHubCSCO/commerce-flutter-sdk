import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('ShipTo', () {
    test('fromJson should create a valid ShipTo instance', () {
      final json = jsonDecode('''
        {
          "isDefault": true,
          "isNew": false,
          "oneTimeAddress": false,
          "validation": {"city": {"isRequired": true}}
        }
      ''');
      final shipTo = ShipTo.fromJson(json);

      expect(shipTo.isDefault, isTrue);
      expect(shipTo.isNew, isFalse);
      expect(shipTo.oneTimeAddress, isFalse);
      expect(shipTo.validation?.city?.isRequired, isTrue);
    });

    test('toJson should convert ShipTo instance to valid JSON', () {
      final shipTo = ShipTo(
        isDefault: true,
        isNew: false,
        oneTimeAddress: false,
        validation:
            CustomerValidationDto(city: FieldValidationDto(isRequired: true)),
      );

      final json = shipTo.toJson();
      expect(json['isDefault'], isTrue);
      expect(json['isNew'], isFalse);
      expect(json['oneTimeAddress'], isFalse);
      expect(json['validation']?['city']?['isRequired'], isTrue);
    });
  });
}
