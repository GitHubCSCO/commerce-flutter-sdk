import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('Address', () {
    test('fromJson should create a valid Address instance', () {
      final json = jsonDecode('''
        {
          "id": "123",
          "customerNumber": "456",
          "customerSequence": "001",
          "customerName": "John Doe",
          "label": "Company, John Doe, City, ST",
          "firstName": "John",
          "lastName": "Doe",
          "companyName": "Company",
          "attention": "Manager",
          "address1": "123 Street",
          "address2": "Suite 100",
          "city": "City",
          "postalCode": "12345",
          "state": {"id": "state123", "name": "State", "abbreviation": "ST"},
          "country": {"id": "country123", "name": "Country", "abbreviation": "CN"},
          "phone": "1234567890",
          "fullAddress": "123 Street, City, ST 12345",
          "email": "test@example.com",
          "fax": "0987654321",
          "isVmiLocation": true
        }
      ''');
      final address = Address.fromJson(json);

      // Validate fields
      expect(address.id, equals("123"));
      expect(address.customerNumber, equals("456"));
      expect(address.customerSequence, equals("001"));
      expect(address.customerName, equals("John Doe"));
      expect(address.label, equals("Company, John Doe, City, ST"));
      expect(address.firstName, equals("John"));
      expect(address.state?.abbreviation, equals("ST"));
    });

    test('toJson should convert Address instance to valid JSON', () {
      final address = Address(
        id: "123",
        customerNumber: "456",
        customerSequence: "001",
        customerName: "John Doe",
        label: "Company, John Doe, City, ST",
        firstName: "John",
        lastName: "Doe",
        companyName: "Company",
        attention: "Manager",
        address1: "123 Street",
        address2: "Suite 100",
        city: "City",
        postalCode: "12345",
        state: StateModel(id: "state123", name: "State", abbreviation: "ST"),
        country: Country(id: "country123", name: "Country", abbreviation: "CN"),
        phone: "1234567890",
        fullAddress: "123 Street, City, ST 12345",
        email: "test@example.com",
        fax: "0987654321",
        isVmiLocation: true,
      );

      final json = address.toJson();

      // Validate JSON structure and content
      expect(json['id'], equals("123"));
      expect(json['customerNumber'], equals("456"));
      expect(json['state']['abbreviation'], equals("ST"));
      expect(json['country']['abbreviation'], equals("CN"));
    });
  });
}
