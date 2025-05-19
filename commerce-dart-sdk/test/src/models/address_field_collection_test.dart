import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AddressFieldCollection', () {
    test('fromJson should create a valid AddressFieldCollection instance', () {
      final json = jsonDecode('''
        {
          "billToAddressFields": {
            "address1": {"displayName": "Street Address 1", "isVisible": true},
            "city": {"displayName": "City", "isVisible": true}
          },
          "shipToAddressFields": {
            "address1": {"displayName": "Street Address 2", "isVisible": false},
            "country": {"displayName": "Country", "isVisible": true}
          }
        }
      ''');
      final collection = AddressFieldCollection.fromJson(json);

      // Validate billToAddressFields
      expect(collection.billToAddressFields?.address1?.displayName,
          equals("Street Address 1"));
      expect(collection.billToAddressFields?.address1?.isVisible, equals(true));
      expect(collection.billToAddressFields?.city?.displayName, equals("City"));
      expect(collection.billToAddressFields?.city?.isVisible, equals(true));

      // Validate shipToAddressFields
      expect(collection.shipToAddressFields?.address1?.displayName,
          equals("Street Address 2"));
      expect(
          collection.shipToAddressFields?.address1?.isVisible, equals(false));
      expect(collection.shipToAddressFields?.country?.displayName,
          equals("Country"));
      expect(collection.shipToAddressFields?.country?.isVisible, equals(true));
    });

    test('toJson should convert AddressFieldCollection instance to valid JSON',
        () {
      final collection = AddressFieldCollection(
        billToAddressFields: AddressFieldDisplayCollection(
          address1: AddressFieldDisplay(
              displayName: "Street Address 1", isVisible: true),
          city: AddressFieldDisplay(displayName: "City", isVisible: true),
        ),
        shipToAddressFields: AddressFieldDisplayCollection(
          address1: AddressFieldDisplay(
              displayName: "Street Address 2", isVisible: false),
          country: AddressFieldDisplay(displayName: "Country", isVisible: true),
        ),
      );

      final json = collection.toJson();

      // Validate JSON structure and content for billToAddressFields
      expect(json['billToAddressFields']['address1']['displayName'],
          equals("Street Address 1"));
      expect(
          json['billToAddressFields']['address1']['isVisible'], equals(true));
      expect(
          json['billToAddressFields']['city']['displayName'], equals("City"));
      expect(json['billToAddressFields']['city']['isVisible'], equals(true));

      // Validate JSON structure and content for shipToAddressFields
      expect(json['shipToAddressFields']['address1']['displayName'],
          equals("Street Address 2"));
      expect(
          json['shipToAddressFields']['address1']['isVisible'], equals(false));
      expect(json['shipToAddressFields']['country']['displayName'],
          equals("Country"));
      expect(json['shipToAddressFields']['country']['isVisible'], equals(true));
    });
  });
}
