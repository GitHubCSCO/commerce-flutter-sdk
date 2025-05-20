import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('CustomerValidationDto', () {
    test('fromJson should create a valid CustomerValidationDto instance', () {
      final json = jsonDecode('''
        {
          "firstName": {"isRequired": true, "maxLength": 50},
          "lastName": {"isRequired": true},
          "city": {"isRequired": false, "maxLength": 100}
        }
      ''');
      final validationDto = CustomerValidationDto.fromJson(json);

      expect(validationDto.firstName?.isRequired, isTrue);
      expect(validationDto.firstName?.maxLength, equals(50));
      expect(validationDto.lastName?.isRequired, isTrue);
      expect(validationDto.city?.isRequired, isFalse);
      expect(validationDto.city?.maxLength, equals(100));
    });

    test('toJson should convert CustomerValidationDto instance to valid JSON',
        () {
      final validationDto = CustomerValidationDto(
        firstName: FieldValidationDto(isRequired: true, maxLength: 50),
        lastName: FieldValidationDto(isRequired: true),
        city: FieldValidationDto(isRequired: false, maxLength: 100),
      );

      final json = validationDto.toJson();
      expect(json['firstName']?['isRequired'], isTrue);
      expect(json['firstName']?['maxLength'], equals(50));
      expect(json['lastName']?['isRequired'], isTrue);
      expect(json['city']?['isRequired'], isFalse);
      expect(json['city']?['maxLength'], equals(100));
    });
  });
}
