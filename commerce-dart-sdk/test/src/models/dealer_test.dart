import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('Dealer Model', () {
    final dealerJson = jsonDecode('''
      {
        "uri": "https://mobilespire.commerce.insitesandbox.com/api/v1/dealers/bb0ef3b5-2c3f-413f-a2c4-ac75014efb8e",
        "id": "bb0ef3b5-2c3f-413f-a2c4-ac75014efb8e",
        "name": "The Tool Depot - Woodbury",
        "address1": "8334 Tamarack Village",
        "address2": "",
        "city": "Woodbury",
        "state": "Minnesota",
        "postalCode": "55125",
        "countryId": "8aac0470-e310-e311-ba31-d43d7e4e88b2",
        "phone": "651-741-4631",
        "latitude": 44.943992,
        "longitude": -92.940003,
        "webSiteUrl": "",
        "htmlContent": "<html>\\n<head>\\n\\t<title></title>\\n</head>\\n<body>\\n<p><span style=\\"font-size:8px;\\"><strong>Store Hours:</strong></span></p>\\n\\n<p><span style=\\"font-size:8px;\\">Monday-Friday: 8:00 AM - 8:00 PM</span></p>\\n\\n<p><span style=\\"font-size:8px;\\">Saturday: 9:00 AM - 7:00 PM</span></p>\\n\\n<p><span style=\\"font-size:8px;\\">Sunday:&nbsp;9:00 AM - 7:00 PM</span></p>\\n</body>\\n</html>\\n",
        "distance": 11.087782290553193,
        "distanceUnitOfMeasure": null,
        "properties": {}
      }
    ''');

    test('fromJson should create a valid Dealer object from JSON', () {
      // Deserialize JSON to Dealer object
      Dealer dealer = Dealer.fromJson(dealerJson);

      // Validate each field
      expect(dealer.id, "bb0ef3b5-2c3f-413f-a2c4-ac75014efb8e");
      expect(dealer.name, "The Tool Depot - Woodbury");
      expect(dealer.address1, "8334 Tamarack Village");
      expect(dealer.address2, "");
      expect(dealer.city, "Woodbury");
      expect(dealer.state, "Minnesota");
      expect(dealer.postalCode, "55125");
      expect(dealer.countryId, "8aac0470-e310-e311-ba31-d43d7e4e88b2");
      expect(dealer.phone, "651-741-4631");
      expect(dealer.latitude, 44.943992);
      expect(dealer.longitude, -92.940003);
      expect(dealer.webSiteUrl, "");
      expect(dealer.htmlContent?.contains("Store Hours"), true);
      expect(dealer.distance, 11.087782290553193);
    });

    test('toJson should create a valid JSON from Dealer object', () {
      // Create Dealer object
      Dealer dealer = Dealer(
        id: "bb0ef3b5-2c3f-413f-a2c4-ac75014efb8e",
        name: "The Tool Depot - Woodbury",
        address1: "8334 Tamarack Village",
        address2: "",
        city: "Woodbury",
        state: "Minnesota",
        postalCode: "55125",
        countryId: "8aac0470-e310-e311-ba31-d43d7e4e88b2",
        phone: "651-741-4631",
        latitude: 44.943992,
        longitude: -92.940003,
        webSiteUrl: "",
        htmlContent:
            "<html>\n<head>\n\t<title></title>\n</head>\n<body>\n<p><span style=\"font-size:8px;\"><strong>Store Hours:</strong></span></p>\n\n<p><span style=\"font-size:8px;\">Monday-Friday: 8:00 AM - 8:00 PM</span></p>\n\n<p><span style=\"font-size:8px;\">Saturday: 9:00 AM - 7:00 PM</span></p>\n\n<p><span style=\"font-size:8px;\">Sunday:&nbsp;9:00 AM - 7:00 PM</span></p>\n</body>\n</html>\n",
        distance: 11.087782290553193,
      );

      // Convert the Dealer object to JSON
      final dealerToJson = dealer.toJson();

      // Validate that the resulting JSON matches the expected data
      expect(dealerToJson['id'], dealerJson['id']);
      expect(dealerToJson['name'], dealerJson['name']);
      expect(dealerToJson['address1'], dealerJson['address1']);
      expect(dealerToJson['address2'], dealerJson['address2']);
      expect(dealerToJson['city'], dealerJson['city']);
      expect(dealerToJson['state'], dealerJson['state']);
      expect(dealerToJson['postalCode'], dealerJson['postalCode']);
      expect(dealerToJson['countryId'], dealerJson['countryId']);
      expect(dealerToJson['phone'], dealerJson['phone']);
      expect(dealerToJson['latitude'], dealerJson['latitude']);
      expect(dealerToJson['longitude'], dealerJson['longitude']);
      expect(dealerToJson['webSiteUrl'], dealerJson['webSiteUrl']);
      expect(dealerToJson['htmlContent'], dealerJson['htmlContent']);
      expect(dealerToJson['distance'], dealerJson['distance']);
    });
  });
}
