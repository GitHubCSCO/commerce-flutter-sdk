import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  group('Account', () {
    final account = Account();

    test('should be a subclass of [BaseModel]', () {
      expect(account, isA<BaseModel>());
    });

    final accountJson = jsonDecode(fixture('Account.json'));

    test('fromJson should create a valid Account instance', () {
      final account = Account.fromJson(accountJson);

      expect(account.id, equals("account123"));
      expect(account.email, equals("user@example.com"));
      expect(account.userName, equals("user123"));
      expect(account.isSubscribed, isTrue);
      expect(account.canApproveOrders, isFalse);
      expect(account.lastLoginOn,
          equals(DateTime.parse("2023-12-25T05:27:40.686Z")));
    });

    test('toJson should convert Account instance to valid JSON', () {
      final account = Account(
        id: "account123",
        email: "user@example.com",
        userName: "user123",
        isSubscribed: true,
        canApproveOrders: false,
        lastLoginOn: DateTime.parse("2023-12-25T05:27:40.686Z"),
      );

      final json = account.toJson();
      expect(json['id'], equals("account123"));
      expect(json['email'], equals("user@example.com"));
      expect(json['userName'], equals("user123"));
      expect(json['isSubscribed'], isTrue);
      expect(json['canApproveOrders'], isFalse);
      expect(json['lastLoginOn'], equals("2023-12-25T05:27:40.686Z"));
    });
  });

  group('Vmi', () {
    final vmi = Vmi();

    test('should be a subclass of [BaseModel]', () {
      expect(vmi, isA<BaseModel>());
    });

    final vmiJson = jsonDecode(fixture('Vmi.json'));

    test('fromJson should create a valid Vmi instance', () {
      final vmi = Vmi.fromJson(vmiJson);

      expect(vmi.vmiUsers, isList);
      expect(vmi.vmiUsers, everyElement(isA<VmiUser>()));
      expect(vmi.vmiUsers?.first.userId, equals("user1"));
    });

    test('toJson should convert Vmi instance to valid JSON', () {
      final vmi = Vmi(
        vmiUsers: [
          VmiUser(
            userId: "user1",
            vmiLocationNames: ["Location1", "Location2"],
            vmiRoles: ["Role1", "Role2"],
          ),
        ],
      );

      final json = vmi.toJson();
      expect(json['vmiUsers'], isList);
      expect(json['vmiUsers'][0]['userId'], equals("user1"));
      expect(json['vmiUsers'][0]['vmiLocationNames'], contains("Location1"));
      expect(json['vmiUsers'][0]['vmiRoles'], contains("Role1"));
    });
  });

  group('VmiUser', () {
    final vmiUser = VmiUser();

    test('should be a subclass of [BaseModel]', () {
      expect(vmiUser, isA<BaseModel>());
    });

    final vmiUserJson = jsonDecode(fixture('VmiUser.json'));

    test('fromJson should create a valid VmiUser instance', () {
      final vmiUser = VmiUser.fromJson(vmiUserJson);

      expect(vmiUser.userId, equals("user1"));
      expect(vmiUser.vmiLocationNames, contains("Location1"));
      expect(vmiUser.vmiRoles, contains("Role1"));
    });

    test('toJson should convert VmiUser instance to valid JSON', () {
      final vmiUser = VmiUser(
        userId: "user1",
        vmiLocationNames: ["Location1", "Location2"],
        vmiRoles: ["Role1", "Role2"],
      );

      final json = vmiUser.toJson();
      expect(json['userId'], equals("user1"));
      expect(json['vmiLocationNames'], contains("Location1"));
      expect(json['vmiRoles'], contains("Role1"));
    });
  });
}
