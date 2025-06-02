import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('WishListLine', () {
    test('fromJson should correctly deserialize JSON to WishListLine object',
        () {
      // Arrange
      final json = {
        "id": "12345",
        "productUri": "/product/12345",
        "productId": "P12345",
        "smallImagePath": "/images/product.jpg",
        "altText": "Sample Product",
        "productName": "Sample Product Name",
        "manufacturerItem": "M123",
        "customerName": "Customer A",
        "shortDescription": "This is a short description",
        "qtyOnHand": 10,
        "qtyOrdered": 2,
        "erpNumber": "E12345",
        "pricing": null, // Example: Add relevant structure for nested object
        "quoteRequired": true,
        "isActive": true,
        "canEnterQuantity": true,
        "canShowPrice": false,
        "canAddToCart": true,
        "canShowUnitOfMeasure": true,
        "canBackOrder": false,
        "trackInventory": true,
        "availability":
            null, // Example: Add relevant structure for nested object
        "breakPrices": null, // Example: Add array of relevant structure
        "unitOfMeasure": "PCS",
        "unitOfMeasureDisplay": "Pieces",
        "unitOfMeasureDescription": "Pieces Description",
        "baseUnitOfMeasure": "EA",
        "baseUnitOfMeasureDisplay": "Each",
        "qtyPerBaseUnitOfMeasure": 1,
        "selectedUnitOfMeasure": "PCS",
        "productUnitOfMeasures": null, // Example: Add relevant structure
        "packDescription": "Pack of 10",
        "createdOn": "2024-11-14T12:00:00.000Z",
        "notes": "Sample note",
        "createdByDisplayName": "Admin User",
        "isSharedLine": false,
        "isVisible": true,
        "isDiscontinued": false,
        "sortOrder": 1,
        "brand": null, // Example: Add relevant structure for nested object
        "isQtyAdjusted": false,
        "allowZeroPricing": false
      };

      // Act
      final wishListLine = WishListLine.fromJson(json);

      // Assert
      expect(wishListLine.id, "12345");
      expect(wishListLine.productName, "Sample Product Name");
      expect(wishListLine.qtyOnHand, 10);
      expect(wishListLine.canAddToCart, true);
      expect(wishListLine.unitOfMeasure, "PCS");
      expect(wishListLine.createdOn?.toIso8601String(),
          "2024-11-14T12:00:00.000Z");
    });

    test('toJson should correctly serialize WishListLine object to JSON', () {
      // Arrange
      final wishListLine = WishListLine(
        id: "12345",
        productUri: "/product/12345",
        productId: "P12345",
        productName: "Sample Product Name",
        qtyOnHand: 10,
        canAddToCart: true,
        unitOfMeasure: "PCS",
        createdOn: DateTime.parse("2024-11-14T12:00:00.000Z"),
      );

      // Act
      final json = wishListLine.toJson();

      // Assert
      expect(json["id"], "12345");
      expect(json["productName"], "Sample Product Name");
      expect(json["qtyOnHand"], 10);
      expect(json["canAddToCart"], true);
      expect(json["unitOfMeasure"], "PCS");
      expect(json["createdOn"], "2024-11-14T12:00:00.000Z");
    });
  });
}
