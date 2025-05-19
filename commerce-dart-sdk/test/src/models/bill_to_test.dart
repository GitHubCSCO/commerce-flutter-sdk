import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('BillTo', () {
    test('fromJson should create a valid BillTo instance', () {
      final json = jsonDecode('''
        {
          "accountsReceivable": null,
          "budgetEnforcementLevel": "Customer",
          "costCodeTitle": "Job #",
          "costCodes": [{"id": "123", "CostCode": "001", "description": "Main job", "isActive": true}],
          "customerCurrencySymbol": "\$",
          "isDefault": true,
          "isGuest": false,
          "shipTos": [{"isDefault": true, "isNew": false, "oneTimeAddress": false}],
          "shipTosUri": "/api/shiptos",
          "validation": {"firstName": {"isRequired": true, "maxLength": 50}}
        }
      ''');
      final billTo = BillTo.fromJson(json);

      expect(billTo.budgetEnforcementLevel, equals("Customer"));
      expect(billTo.costCodeTitle, equals("Job #"));
      expect(billTo.costCodes?.length, equals(1));
      expect(billTo.costCodes?[0].code, equals("001"));
      expect(billTo.customerCurrencySymbol, equals("\$"));
      expect(billTo.isDefault, isTrue);
      expect(billTo.shipTos?.length, equals(1));
      expect(billTo.shipTos?[0].isDefault, isTrue);
      expect(billTo.validation?.firstName?.isRequired, isTrue);
    });

    test('toJson should convert BillTo instance to valid JSON', () {
      final billTo = BillTo(
        budgetEnforcementLevel: "Customer",
        costCodeTitle: "Job #",
        costCodes: [
          CostCode(
              id: "123", code: "001", description: "Main job", isActive: true)
        ],
        customerCurrencySymbol: "\$",
        isDefault: true,
        isGuest: false,
        shipTos: [ShipTo(isDefault: true, isNew: false, oneTimeAddress: false)],
        shipTosUri: "/api/shiptos",
        validation: CustomerValidationDto(
            firstName: FieldValidationDto(isRequired: true, maxLength: 50)),
      );

      final json = billTo.toJson();
      expect(json['budgetEnforcementLevel'], equals("Customer"));
      expect(json['costCodeTitle'], equals("Job #"));
      expect(json['customerCurrencySymbol'], equals("\$"));
      expect(json['isDefault'], isTrue);
      expect(json['shipTos']?[0]['isDefault'], isTrue);
      expect(json['validation']?['firstName']?['isRequired'], isTrue);
    });
  });
}
