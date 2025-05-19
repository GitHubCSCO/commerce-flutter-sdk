import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final profile = AccountPaymentProfile();

  test('should be a subclass of [BaseModel]', () {
    expect(profile, isA<BaseModel>());
  });

  Map<String, dynamic> modelJson =
      jsonDecode(fixture('AccountPaymentProfile.json'));

  group('AccountPaymentProfile', () {
    test('fromJson should create a valid AccountPaymentProfile instance', () {
      final profile = AccountPaymentProfile.fromJson(modelJson);

      expect(profile.id, equals("string"));
      expect(profile.description, equals("Sample Description"));
      expect(profile.cardType, equals("Visa"));
      expect(profile.expirationDate, equals("12/24"));
      expect(profile.maskedCardNumber, equals("**** **** **** 1234"));
      expect(profile.cardIdentifier, equals("card123"));
      expect(profile.cardHolderName, equals("John Doe"));
      expect(profile.address1, equals("123 Main St"));
      expect(profile.city, equals("Sample City"));
      expect(profile.state, equals("CA"));
      expect(profile.postalCode, equals("12345"));
      expect(profile.country, equals("US"));
      expect(profile.isDefault, isTrue);
    });

    test('toJson should convert AccountPaymentProfile instance to valid JSON',
        () {
      final profile = AccountPaymentProfile(
        id: "string",
        description: "Sample Description",
        cardType: "Visa",
        expirationDate: "12/24",
        maskedCardNumber: "**** **** **** 1234",
        cardIdentifier: "card123",
        cardHolderName: "John Doe",
        address1: "123 Main St",
        city: "Sample City",
        state: "CA",
        postalCode: "12345",
        country: "US",
        isDefault: true,
      );

      final json = profile.toJson();
      expect(json['id'], equals("string"));
      expect(json['description'], equals("Sample Description"));
      expect(json['cardType'], equals("Visa"));
      expect(json['expirationDate'], equals("12/24"));
      expect(json['maskedCardNumber'], equals("**** **** **** 1234"));
      expect(json['cardIdentifier'], equals("card123"));
      expect(json['cardHolderName'], equals("John Doe"));
      expect(json['address1'], equals("123 Main St"));
      expect(json['city'], equals("Sample City"));
      expect(json['state'], equals("CA"));
      expect(json['postalCode'], equals("12345"));
      expect(json['country'], equals("US"));
      expect(json['isDefault'], isTrue);
    });

    test('cardNumberEnding should return last 4 digits', () {
      final profile = AccountPaymentProfile(maskedCardNumber: "1234");
      expect(profile.cardNumberEnding, equals("1234"));
    });

    test('expirationMonth should return correct month', () {
      final profile = AccountPaymentProfile(expirationDate: "12/24");
      expect(profile.expirationMonth, equals(12));
    });

    test('expirationYear should return correct year', () {
      final profile = AccountPaymentProfile(expirationDate: "12/24");
      expect(profile.expirationYear, equals(24));
    });

    test('isExpired should return true if card is expired', () {
      final profile = AccountPaymentProfile(expirationDate: "01/20");
      expect(profile.isExpired, isTrue);
    });

    test('isExpired should return false if card is not expired', () {
      final profile = AccountPaymentProfile(expirationDate: "12/25");
      expect(profile.isExpired, isFalse);
    });
  });
}
