import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('FieldValidationDto', () {
    test('fromJson should create a valid FieldValidationDto instance', () {
      final json = jsonDecode('''
        {
          "isRequired": true,
          "isDisabled": false,
          "maxLength": 100
        }
      ''');
      final fieldValidation = FieldValidationDto.fromJson(json);

      expect(fieldValidation.isRequired, isTrue);
      expect(fieldValidation.isDisabled, isFalse);
      expect(fieldValidation.maxLength, equals(100));
    });

    test('toJson should convert FieldValidationDto instance to valid JSON', () {
      final fieldValidation = FieldValidationDto(
        isRequired: true,
        isDisabled: false,
        maxLength: 100,
      );

      final json = fieldValidation.toJson();
      expect(json['isRequired'], isTrue);
      expect(json['isDisabled'], isFalse);
      expect(json['maxLength'], equals(100));
    });
  });
}
