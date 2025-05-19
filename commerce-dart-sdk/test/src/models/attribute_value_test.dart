import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AttributeValue', () {
    test('fromJson should create a valid AttributeValue instance', () {
      final json = jsonDecode('''
        {
          "attributeValueId": "attrValue123",
          "value": "Value1",
          "valueDisplay": "Display Value 1",
          "sortOrder": 1,
          "isActive": true,
          "id": "valueId123",
          "count": 10,
          "selected": true
        }
      ''');
      final attributeValue = AttributeValue.fromJson(json);

      // Validate fields
      expect(attributeValue.attributeValueId, equals("attrValue123"));
      expect(attributeValue.value, equals("Value1"));
      expect(attributeValue.valueDisplay, equals("Display Value 1"));
      expect(attributeValue.sortOrder, equals(1));
      expect(attributeValue.isActive, equals(true));
      expect(attributeValue.id, equals("valueId123"));
      expect(attributeValue.count, equals(10));
      expect(attributeValue.selected, equals(true));
    });

    test('toJson should convert AttributeValue instance to valid JSON', () {
      final attributeValue = AttributeValue(
        attributeValueId: "attrValue123",
        value: "Value1",
        valueDisplay: "Display Value 1",
        sortOrder: 1,
        isActive: true,
        id: "valueId123",
        count: 10,
        selected: true,
      );

      final json = attributeValue.toJson();

      // Validate JSON structure and content
      expect(json['attributeValueId'], equals("attrValue123"));
      expect(json['value'], equals("Value1"));
      expect(json['valueDisplay'], equals("Display Value 1"));
      expect(json['sortOrder'], equals(1));
      expect(json['isActive'], equals(true));
      expect(json['id'], equals("valueId123"));
      expect(json['count'], equals(10));
      expect(json['selected'], equals(true));
    });
  });
}
