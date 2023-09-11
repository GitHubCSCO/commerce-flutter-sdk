import 'dart:convert';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_dart_sdk/src/services/client_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<void> main() async {
  String urlString = '/api/v1/warehouses/126729d8-8e2b-48f3-94fe-af42004af05b';

  final localStorageService = MockLocalStorageService();
  final secureStorageService = MockSecureStorageService();

  final clientService = ClientService(
    localStorageService: localStorageService,
    secureStorageService: secureStorageService,
  );

  clientService.host = 'https://mobilespire.commerce.insitesandbox.com';

  print('SET');

  print(ClientConfig.hostUrl);
  print(clientService.host);
  print(clientService.client.options.baseUrl);
  var response = await clientService.getAsync(urlString);

  // var response = await clientService.client.get(urlString);
  var responseData = response.data;
  Warehouse foundWarehouse = Warehouse.fromJson(responseData);

  print(foundWarehouse.toJson());
}
