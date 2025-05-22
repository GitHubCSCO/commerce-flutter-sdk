import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('AddressFieldDisplayCollection', () {
    test(
        'fromJson should create a valid AddressFieldDisplayCollection instance',
        () {
      final json = jsonDecode('''
        {
          "address1": {"displayName": "Street Address 1", "isVisible": true},
          "city": {"displayName": "City", "isVisible": true},
          "country": {"displayName": "Country", "isVisible": false}
        }
      ''');
      final collection = AddressFieldDisplayCollection.fromJson(json);

      // Validate fields
      expect(collection.address1?.displayName, equals("Street Address 1"));
      expect(collection.address1?.isVisible, equals(true));
      expect(collection.city?.displayName, equals("City"));
      expect(collection.city?.isVisible, equals(true));
      expect(collection.country?.displayName, equals("Country"));
      expect(collection.country?.isVisible, equals(false));
    });

    test(
        'toJson should convert AddressFieldDisplayCollection instance to valid JSON',
        () {
      final collection = AddressFieldDisplayCollection(
        address1: AddressFieldDisplay(
            displayName: "Street Address 1", isVisible: true),
        city: AddressFieldDisplay(displayName: "City", isVisible: true),
        country: AddressFieldDisplay(displayName: "Country", isVisible: false),
      );

      final json = collection.toJson();

      // Validate JSON structure and content
      expect(json['address1']['displayName'], equals("Street Address 1"));
      expect(json['address1']['isVisible'], equals(true));
      expect(json['city']['displayName'], equals("City"));
      expect(json['city']['isVisible'], equals(true));
      expect(json['country']['displayName'], equals("Country"));
      expect(json['country']['isVisible'], equals(false));
    });
  });
}
