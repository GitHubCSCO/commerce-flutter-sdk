// ignore_for_file: avoid_print

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_dart_sdk/src/services/client_service.dart';

import 'package:test/test.dart';

class MockLocalStorageService implements ILocalStorageService {
  Map<String, String?> store = {};

  @override
  String? load(String key) => store[key];

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }

  @override
  Future<void> save(String key, String value) async {
    store[key] = value;
  }
}

class MockSecureStorageService implements ISecureStorageService {
  Map<String, String?> store = {};

  @override
  String? load(String key) => store[key];

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }

  @override
  Future<void> save(String key, String value) async {
    store[key] = value;
  }
}

void main() {
  String jsonString =
      '{"uri":"https://mobilespire.commerce.insitesandbox.com/api/v1/warehouses/126729d8-8e2b-48f3-94fe-af42004af05b","id":"126729d8-8e2b-48f3-94fe-af42004af05b","name":"Banani","address1":"Green Grandeur (4th ,10th and 13th floor), Plot 58/E, Kemal Ataturk Avenue, Dhaka","address2":"","city":"Dhaka","contactName":"","countryId":"b1ab0470-e310-e311-ba31-d43d7e4e88b2","deactivateOn":null,"description":"Banani W","phone":"","postalCode":"1213","shipSite":"","state":"","isDefault":false,"alternateWarehouses":[],"latitude":0.000000,"longitude":0.000000,"hours":"","distance":0.0,"allowPickup":false,"pickupShipViaId":null,"properties":{}}';
  ServiceBase serviceBase = ServiceBase(
      clientService: ClientService(
    localStorageService: MockLocalStorageService(),
    secureStorageService: MockSecureStorageService(),
  ));

  group(
      'Warehouse Test',
      () => {
            test('FromJSON', () async {
              Warehouse inputWarehouse =
                  serviceBase.deserializeFromString<Warehouse>(
                      jsonString, Warehouse.fromJson);
              var expectedJson = serviceBase.serializeToJson<Warehouse>(
                  inputWarehouse, (Warehouse w) => w.toJson());

              print(inputWarehouse.toJson());
              print('---\n');
              print(expectedJson);

              Warehouse outputWarehouse =
                  await serviceBase.deserializeFromMap<Warehouse>(
                      expectedJson, Warehouse.fromJson);

              print('---\n');
              print(outputWarehouse.toJson());

              expect(inputWarehouse.toJson(), outputWarehouse.toJson());
            })
          });
}
