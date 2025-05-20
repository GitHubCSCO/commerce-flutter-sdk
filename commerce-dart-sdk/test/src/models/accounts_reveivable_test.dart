import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  group('AccountsReceivable', () {
    test('fromJson should create a valid AccountsReceivable instance', () {
      final json = jsonDecode(fixture('AccountsReceivable.json'));
      final accountsReceivable = AccountsReceivable.fromJson(json);

      // Validate agingBucketTotal
      expect(accountsReceivable.agingBucketTotal, isA<AgingBucket>());
      expect(accountsReceivable.agingBucketTotal?.label, equals("Total"));
      expect(accountsReceivable.agingBucketTotal?.amount, equals(5000));
      expect(accountsReceivable.agingBucketTotal?.amountDisplay,
          equals("\$5,000.00"));

      // Validate agingBucketFuture
      expect(accountsReceivable.agingBucketFuture, isA<AgingBucket>());
      expect(accountsReceivable.agingBucketFuture?.label, equals("Future"));
      expect(accountsReceivable.agingBucketFuture?.amount, equals(1000));
      expect(accountsReceivable.agingBucketFuture?.amountDisplay,
          equals("\$1,000.00"));

      // Validate agingBuckets list
      expect(accountsReceivable.agingBuckets, isList);
      expect(accountsReceivable.agingBuckets?.length, equals(3));
      expect(accountsReceivable.agingBuckets?.first, isA<AgingBucket>());
      expect(accountsReceivable.agingBuckets?[0].label, equals("0-30 days"));
      expect(accountsReceivable.agingBuckets?[0].amount, equals(1000));
      expect(accountsReceivable.agingBuckets?[0].amountDisplay,
          equals("\$1,000.00"));
    });

    test('toJson should convert AccountsReceivable instance to valid JSON', () {
      final accountsReceivable = AccountsReceivable(
        agingBucketFuture: AgingBucket(
          label: "Future",
          amount: 1000,
          amountDisplay: "\$1,000.00",
        ),
        agingBucketTotal: AgingBucket(
          label: "Total",
          amount: 5000,
          amountDisplay: "\$5,000.00",
        ),
        agingBuckets: [
          AgingBucket(
              label: "0-30 days", amount: 1000, amountDisplay: "\$1,000.00"),
          AgingBucket(
              label: "31-60 days", amount: 2000, amountDisplay: "\$2,000.00"),
          AgingBucket(
              label: "61-90 days", amount: 2000, amountDisplay: "\$2,000.00"),
        ],
      );

      final json = accountsReceivable.toJson();

      // Validate JSON structure and content
      expect(json['agingBucketFuture']['label'], equals("Future"));
      expect(json['agingBucketFuture']['amount'], equals(1000));
      expect(json['agingBucketFuture']['amountDisplay'], equals("\$1,000.00"));

      expect(json['agingBucketTotal']['label'], equals("Total"));
      expect(json['agingBucketTotal']['amount'], equals(5000));
      expect(json['agingBucketTotal']['amountDisplay'], equals("\$5,000.00"));

      expect(json['agingBuckets'][0]['label'], equals("0-30 days"));
      expect(json['agingBuckets'][0]['amount'], equals(1000));
      expect(json['agingBuckets'][0]['amountDisplay'], equals("\$1,000.00"));
      expect(json['agingBuckets'][1]['amount'], equals(2000));
      expect(json['agingBuckets'][2]['amountDisplay'], equals("\$2,000.00"));
    });
  });
}
