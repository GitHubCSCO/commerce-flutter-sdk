import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('WishListAddToCartCollection', () {
    test(
        'fromJson should correctly deserialize JSON to WishListAddToCartCollection object',
        () {
      // Arrange
      final json = {
        "wishListLines": [
          {
            "productId": "P12345",
            "qtyOrdered": 2,
            "unitOfMeasure": "PCS",
            "notes": "Sample notes",
            "vmiBinId": "Bin123",
            "sectionOptions": [
              {
                "sectionOptionId": "Option123",
                "sectionName": "Color",
                "optionName": "Red"
              },
              {
                "sectionOptionId": "Option124",
                "sectionName": "Size",
                "optionName": "Medium"
              }
            ]
          },
          {
            "productId": "P67890",
            "qtyOrdered": 5,
            "unitOfMeasure": "EA",
            "notes": null,
            "vmiBinId": "Bin456",
            "sectionOptions": null
          }
        ]
      };

      // Act
      final collection = WishListAddToCartCollection.fromJson(json);

      // Assert
      expect(collection.wishListLines?.length, 2);
      expect(collection.wishListLines?[0].productId, "P12345");
      expect(collection.wishListLines?[0].sectionOptions?.length, 2);
      expect(collection.wishListLines?[1].qtyOrdered, 5);
      expect(collection.wishListLines?[1].sectionOptions, isNull);
    });

    test(
        'toJson should correctly serialize WishListAddToCartCollection object to JSON',
        () {
      // Arrange
      final collection = WishListAddToCartCollection(
        wishListLines: [
          AddCartLine(
            productId: "P12345",
            qtyOrdered: 2,
            unitOfMeasure: "PCS",
            notes: "Sample notes",
            vmiBinId: "Bin123",
            sectionOptions: [
              SectionOptionDto(
                sectionOptionId: "Option123",
                sectionName: "Color",
                optionName: "Red",
              ),
              SectionOptionDto(
                sectionOptionId: "Option124",
                sectionName: "Size",
                optionName: "Medium",
              ),
            ],
          ),
          AddCartLine(
            productId: "P67890",
            qtyOrdered: 5,
            unitOfMeasure: "EA",
            notes: null,
            vmiBinId: "Bin456",
            sectionOptions: null,
          ),
        ],
      );

      // Act
      final json = collection.toJson();

      // Assert
      expect(json["wishListLines"]?.length, 2);
      expect(json["wishListLines"]?[0]["productId"], "P12345");
      expect(json["wishListLines"]?[0]["sectionOptions"]?.length, 2);
      expect(json["wishListLines"]?[1]["vmiBinId"], "Bin456");
      expect(json["wishListLines"]?[1]["sectionOptions"], isNull);
    });

    test('fromJson should handle empty JSON gracefully', () {
      // Arrange
      Map<String, dynamic> json = {};

      // Act
      final collection = WishListAddToCartCollection.fromJson(json);

      // Assert
      expect(collection.wishListLines, isNull);
    });

    test('toJson should handle empty WishListAddToCartCollection gracefully',
        () {
      // Arrange
      final collection = WishListAddToCartCollection();

      // Act
      final json = collection.toJson();

      // Assert
      expect(json["wishListLines"], isNull);
    });

    test('fromJson should handle null sectionOptions gracefully', () {
      // Arrange
      final json = {
        "wishListLines": [
          {
            "productId": "P12345",
            "qtyOrdered": 2,
            "unitOfMeasure": "PCS",
            "notes": "Sample notes",
            "vmiBinId": "Bin123",
            "sectionOptions": null
          }
        ]
      };

      // Act
      final collection = WishListAddToCartCollection.fromJson(json);

      // Assert
      expect(collection.wishListLines?.length, 1);
      expect(collection.wishListLines?[0].sectionOptions, isNull);
    });

    test('toJson should handle null sectionOptions gracefully', () {
      // Arrange
      final collection = WishListAddToCartCollection(
        wishListLines: [
          AddCartLine(
            productId: "P12345",
            qtyOrdered: 2,
            unitOfMeasure: "PCS",
            notes: "Sample notes",
            vmiBinId: "Bin123",
            sectionOptions: null,
          ),
        ],
      );

      // Act
      final json = collection.toJson();

      // Assert
      expect(json["wishListLines"]?.length, 1);
      expect(json["wishListLines"]?[0]["sectionOptions"], isNull);
    });
  });
}
