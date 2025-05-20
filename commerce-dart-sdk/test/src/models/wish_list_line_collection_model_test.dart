import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('WishListLineCollectionModel', () {
    test(
        'fromJson should correctly deserialize JSON to WishListLineCollectionModel object',
        () {
      // Arrange
      final json = {
        "wishListLines": [
          {
            "id": "12345",
            "productName": "Sample Product",
            "qtyOnHand": 10,
            "canAddToCart": true,
            "unitOfMeasure": "PCS",
            "createdOn": "2024-11-14T12:00:00.000Z"
          },
          {
            "id": "67890",
            "productName": "Another Product",
            "qtyOnHand": 20,
            "canAddToCart": false,
            "unitOfMeasure": "EA",
            "createdOn": "2024-11-15T12:00:00.000Z"
          }
        ],
        "pagination": {
          "page": 1,
          "pageSize": 10,
          "numberOfPages": 2,
          "totalItemCount": 20
        }
      };

      // Act
      final collection = WishListLineCollectionModel.fromJson(json);

      // Assert
      expect(collection.wishListLines?.length, 2);
      expect(collection.wishListLines?[0].id, "12345");
      expect(collection.wishListLines?[1].productName, "Another Product");
      expect(collection.pagination?.page, 1);
      expect(collection.pagination?.totalItemCount, 20);
    });

    test(
        'toJson should correctly serialize WishListLineCollectionModel object to JSON',
        () {
      // Arrange
      final collection = WishListLineCollectionModel(
        wishListLines: [
          WishListLine(
            id: "12345",
            productName: "Sample Product",
            qtyOnHand: 10,
            canAddToCart: true,
            unitOfMeasure: "PCS",
            createdOn: DateTime.parse("2024-11-14T12:00:00.000Z"),
          ),
          WishListLine(
            id: "67890",
            productName: "Another Product",
            qtyOnHand: 20,
            canAddToCart: false,
            unitOfMeasure: "EA",
            createdOn: DateTime.parse("2024-11-15T12:00:00.000Z"),
          ),
        ],
        pagination: Pagination(
          page: 1,
          pageSize: 10,
          numberOfPages: 2,
          totalItemCount: 20,
        ),
      );

      // Act
      final json = collection.toJson();

      // Assert
      expect(json["wishListLines"]?.length, 2);
      expect(json["wishListLines"]?[0]["id"], "12345");
      expect(json["pagination"]?["page"], 1);
      expect(json["pagination"]?["totalItemCount"], 20);
    });

    test('fromJson should handle empty JSON gracefully', () {
      // Arrange
      Map<String, dynamic> json = {};

      // Act
      final collection = WishListLineCollectionModel.fromJson(json);

      // Assert
      expect(collection.wishListLines, isNull);
      expect(collection.pagination, isNull);
    });

    test('toJson should handle empty WishListLineCollectionModel gracefully',
        () {
      // Arrange
      final collection = WishListLineCollectionModel();

      // Act
      final json = collection.toJson();

      // Assert
      expect(json["wishListLines"], isNull);
      expect(json["pagination"], isNull);
    });
  });
}
