import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('CostCode', () {
    test('fromJson should create a valid CostCode instance', () {
      final json = jsonDecode('''
        {
          "id": "123",
          "CostCode": "001",
          "description": "Main job",
          "isActive": true
        }
      ''');
      final costCode = CostCode.fromJson(json);

      expect(costCode.id, equals("123"));
      expect(costCode.code, equals("001"));
      expect(costCode.description, equals("Main job"));
      expect(costCode.isActive, isTrue);
    });

    test('toJson should convert CostCode instance to valid JSON', () {
      final costCode = CostCode(
        id: "123",
        code: "001",
        description: "Main job",
        isActive: true,
      );

      final json = costCode.toJson();
      expect(json['id'], equals("123"));
      expect(json['CostCode'], equals("001"));
      expect(json['description'], equals("Main job"));
      expect(json['isActive'], isTrue);
    });
  });
}
