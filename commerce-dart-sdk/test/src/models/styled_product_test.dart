import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('StyledProduct', () {
    test('fromJson should correctly deserialize JSON to StyledProduct object',
        () {
      // Arrange
      final json = {
        "productId": "123",
        "name": "Test Product",
        "shortDescription": "A test product",
        "erpNumber": "ERP-001",
        "mediumImagePath": "/path/to/medium/image.jpg",
        "smallImagePath": "/path/to/small/image.jpg",
        "largeImagePath": "/path/to/large/image.jpg",
        "qtyOnHand": 50,
        "numberInCart": 2,
        "pricing": {
          "price": 20.0,
          "currency": "USD"
        }, // Assuming ProductPrice structure
        "quoteRequired": true,
        "styleValues": [
          {
            "styleTraitName": "Color",
            "styleTraitId": "1",
            "value": "Red",
            "valueDisplay": "Red"
          }
        ],
        "availability": {
          "message": "In stock",
          "messageType": 1,
          "requiresRealTimeInventory": false
        },
        "productUnitOfMeasures": [
          {
            "unitOfMeasure": "Each",
            "unitOfMeasureDisplay": "Each",
            "description": "Each unit"
          }
        ],
        "productImages": [
          {
            "id": "1",
            "smallImagePath": "/path/to/image.jpg",
            "largeImagePath": "/path/to/large/image.jpg",
            "altText": "Product Image"
          }
        ],
        "warehouses": [
          {
            "id": "WH-001",
            "name": "Main Warehouse",
            "city": "CityName",
            "countryId": "US",
            "latitude": 34.0522,
            "longitude": -118.2437,
            "isDefault": true
          }
        ],
        "trackInventory": true
      };

      // Act
      final styledProduct = StyledProduct.fromJson(json);

      // Assert
      expect(styledProduct.productId, "123");
      expect(styledProduct.name, "Test Product");
      expect(styledProduct.shortDescription, "A test product");
      expect(styledProduct.erpNumber, "ERP-001");
      expect(styledProduct.qtyOnHand, 50);
      expect(styledProduct.numberInCart, 2);
      expect(styledProduct.pricing, isNotNull);
      expect(styledProduct.styleValues?.first.styleTraitName, "Color");
      expect(styledProduct.availability?.message, "In stock");
      expect(styledProduct.productUnitOfMeasures?.first.unitOfMeasure, "Each");
      expect(styledProduct.productImages?.first.id, "1");
      expect(styledProduct.warehouses?.first.name, "Main Warehouse");
      expect(styledProduct.trackInventory, true);
    });

    test('toJson should correctly serialize StyledProduct object to JSON', () {
      // Arrange
      final styledProduct = StyledProduct(
          productId: "123",
          name: "Test Product",
          shortDescription: "A test product",
          erpNumber: "ERP-001",
          mediumImagePath: "/path/to/medium/image.jpg",
          smallImagePath: "/path/to/small/image.jpg",
          largeImagePath: "/path/to/large/image.jpg",
          qtyOnHand: 50,
          numberInCart: 2,
          pricing: ProductPrice(
              actualPrice: 20.0), // Assuming ProductPrice structure
          quoteRequired: true,
          styleValues: [
            StyleValue(
                styleTraitName: "Color",
                styleTraitId: "1",
                value: "Red",
                valueDisplay: "Red")
          ],
          availability: Availability(
              message: "In stock",
              messageType: 1,
              requiresRealTimeInventory: false),
          productUnitOfMeasures: [
            ProductUnitOfMeasure(
                unitOfMeasure: "Each",
                unitOfMeasureDisplay: "Each",
                description: "Each unit")
          ],
          productImages: [
            ProductImage(
                id: "1",
                smallImagePath: "/path/to/image.jpg",
                largeImagePath: "/path/to/large/image.jpg",
                altText: "Product Image")
          ],
          warehouses: [
            Warehouse(
                id: "WH-001",
                name: "Main Warehouse",
                city: "CityName",
                countryId: "US",
                latitude: 34.0522,
                longitude: -118.2437,
                isDefault: true)
          ],
          trackInventory: true);

      // Act
      final json = styledProduct.toJson();

      // Assert
      expect(json["productId"], "123");
      expect(json["name"], "Test Product");
      expect(json["shortDescription"], "A test product");
      expect(json["erpNumber"], "ERP-001");
      expect(json["qtyOnHand"], 50);
      expect(json["numberInCart"], 2);
      expect(json["pricing"], isNotNull);
      expect(json["styleValues"]?.first["styleTraitName"], "Color");
      expect(json["availability"]?["message"], "In stock");
      expect(json["productUnitOfMeasures"]?.first["unitOfMeasure"], "Each");
      expect(json["productImages"]?.first["id"], "1");
      expect(json["warehouses"]?.first["name"], "Main Warehouse");
      expect(json["trackInventory"], true);
    });

    test('fromJson should handle empty JSON gracefully', () {
      // Arrange
      Map<String, dynamic> json = {};

      // Act
      final styledProduct = StyledProduct.fromJson(json);

      // Assert
      expect(styledProduct.productId, isNull);
      expect(styledProduct.name, isNull);
      expect(styledProduct.qtyOnHand, isNull);
      expect(styledProduct.numberInCart, isNull);
      expect(styledProduct.pricing, isNull);
      expect(styledProduct.styleValues, isNull);
      expect(styledProduct.availability, isNull);
      expect(styledProduct.productUnitOfMeasures, isNull);
      expect(styledProduct.productImages, isNull);
      expect(styledProduct.warehouses, isNull);
      expect(styledProduct.trackInventory, isNull);
    });

    test('toJson should handle empty StyledProduct object gracefully', () {
      // Arrange
      final styledProduct = StyledProduct();

      // Act
      final json = styledProduct.toJson();

      // Assert
      expect(json["productId"], isNull);
      expect(json["name"], isNull);
      expect(json["qtyOnHand"], isNull);
      expect(json["numberInCart"], isNull);
      expect(json["pricing"], isNull);
      expect(json["styleValues"], isNull);
      expect(json["availability"], isNull);
      expect(json["productUnitOfMeasures"], isNull);
      expect(json["productImages"], isNull);
      expect(json["warehouses"], isNull);
      expect(json["trackInventory"], isNull);
    });
  });
}
