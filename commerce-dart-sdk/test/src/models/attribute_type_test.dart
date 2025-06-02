import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AttributeType', () {
    test('fromJson should create a valid AttributeType instance', () {
      final json = jsonDecode('''
        {
          "attributeTypeId": "type123",
          "name": "Attribute Name",
          "nameDisplay": "Display Name",
          "sort": 2,
          "attributeValueFacets": [
            {
              "attributeValueId": "facet1",
              "value": "Value1",
              "valueDisplay": "Display Value 1",
              "sortOrder": 1,
              "isActive": true
            },
            {
              "attributeValueId": "facet2",
              "value": "Value2",
              "valueDisplay": "Display Value 2",
              "sortOrder": 2,
              "isActive": false
            }
          ],
          "id": "id123",
          "label": "Label",
          "isFilter": true,
          "isComparable": false,
          "isActive": true,
          "sortOrder": 3,
          "attributeValues": [
            {
              "attributeValueId": "attrVal1",
              "value": "Value1",
              "valueDisplay": "Display Value 1",
              "sortOrder": 1,
              "isActive": true
            }
          ]
        }
      ''');
      final attributeType = AttributeType.fromJson(json);

      // Validate fields
      expect(attributeType.attributeTypeId, equals("type123"));
      expect(attributeType.name, equals("Attribute Name"));
      expect(attributeType.nameDisplay, equals("Display Name"));
      expect(attributeType.sort, equals(2));
      expect(attributeType.attributeValueFacets?.length, equals(2));
      expect(attributeType.attributeValueFacets?[0].value, equals("Value1"));
      expect(attributeType.isFilter, equals(true));
      expect(attributeType.sortOrder, equals(3));
      expect(attributeType.attributeValues?.length, equals(1));
      expect(attributeType.attributeValues?[0].attributeValueId,
          equals("attrVal1"));
    });

    test('toJson should convert AttributeType instance to valid JSON', () {
      final attributeType = AttributeType(
        attributeTypeId: "type123",
        name: "Attribute Name",
        nameDisplay: "Display Name",
        sort: 2,
        attributeValueFacets: [
          AttributeValue(
              attributeValueId: "facet1",
              value: "Value1",
              valueDisplay: "Display Value 1",
              sortOrder: 1,
              isActive: true),
          AttributeValue(
              attributeValueId: "facet2",
              value: "Value2",
              valueDisplay: "Display Value 2",
              sortOrder: 2,
              isActive: false)
        ],
        id: "id123",
        label: "Label",
        isFilter: true,
        isComparable: false,
        isActive: true,
        sortOrder: 3,
        attributeValues: [
          AttributeValue(
              attributeValueId: "attrVal1",
              value: "Value1",
              valueDisplay: "Display Value 1",
              sortOrder: 1,
              isActive: true)
        ],
      );

      final json = attributeType.toJson();

      // Validate JSON structure and content
      expect(json['attributeTypeId'], equals("type123"));
      expect(json['name'], equals("Attribute Name"));
      expect(json['nameDisplay'], equals("Display Name"));
      expect(json['sort'], equals(2));
      expect(json['attributeValueFacets'][0]['value'], equals("Value1"));
      expect(json['isFilter'], equals(true));
      expect(json['sortOrder'], equals(3));
      expect(
          json['attributeValues'][0]['attributeValueId'], equals("attrVal1"));
    });
  });
}
