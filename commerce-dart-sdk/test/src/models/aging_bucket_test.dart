import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AgingBucket', () {
    test('fromJson should create a valid AgingBucket instance', () {
      final json = jsonDecode('''
        {
          "amount": 5000,
          "amountDisplay": "\$5,000.00",
          "label": "Total"
        }
      ''');
      final agingBucket = AgingBucket.fromJson(json);

      // Validate fields
      expect(agingBucket.amount, equals(5000));
      expect(agingBucket.amountDisplay, equals("\$5,000.00"));
      expect(agingBucket.label, equals("Total"));
    });

    test('toJson should convert AgingBucket instance to valid JSON', () {
      final agingBucket = AgingBucket(
        amount: 5000,
        amountDisplay: "\$5,000.00",
        label: "Total",
      );

      final json = agingBucket.toJson();

      // Validate JSON structure and content
      expect(json['amount'], equals(5000));
      expect(json['amountDisplay'], equals("\$5,000.00"));
      expect(json['label'], equals("Total"));
    });
  });
}
