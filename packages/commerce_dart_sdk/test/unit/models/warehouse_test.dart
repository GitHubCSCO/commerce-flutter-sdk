import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

import 'package:test/test.dart';

void main() {
  Map<String, dynamic> jsonValue = {
    "uri":
        "https://mobilespire.commerce.insitesandbox.com/api/v1/warehouses/126729d8-8e2b-48f3-94fe-af42004af05b",
    "id": "126729d8-8e2b-48f3-94fe-af42004af05b",
    "name": "Banani",
    "address1":
        "Green Grandeur (4th ,10th and 13th floor), Plot 58/E, Kemal Ataturk Avenue, Dhaka",
    "address2": "",
    "city": "Dhaka",
    "contactName": "",
    "countryId": "b1ab0470-e310-e311-ba31-d43d7e4e88b2",
    "deactivateOn": null,
    "description": "Banani W",
    "phone": "",
    "postalCode": "1213",
    "shipSite": "",
    "state": "",
    "isDefault": false,
    "alternateWarehouses": [],
    "latitude": 0,
    "longitude": 0,
    "hours": "",
    "distance": 0,
    "allowPickup": false,
    "pickupShipViaId": null,
    "properties": {}
  };

  group(
      'Warehouse Test',
      () => {
            test('FromJSON', () {
              Warehouse inputWarehouse = Warehouse.fromJson(jsonValue);
              Map<String, dynamic> expectedJson = inputWarehouse.toJson();

              // print(inputWarehouse.toJson());
              // print('---\n');
              // print(expectedWarehouse.toJson());

              expect(jsonValue, expectedJson);
            })
          });
}
