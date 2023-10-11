import 'dart:convert';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../../mocks/mocks.dart';

void main() {
  late ProductService sut;
  late IClientService clientService;

  final productList = [
    Product(
      altText: 'fakeProduct1',
      id: '001',
    ),
    Product(
      altText: 'fakeProduct2',
      id: '002',
      qtyOnHand: 5,
    ),
    Product(
      altText: 'fakeProduct3',
      id: '003',
      brand: Brand(name: 'fakeBrand1'),
    ),
    Product(
      altText: 'fakeProduct4',
      id: '004',
      unitOfMeasures: [
        ProductUnitOfMeasure(description: 'fakeDescription1'),
        ProductUnitOfMeasure(unitOfMeasureDisplay: '\$'),
      ],
    ),
  ];

  final productListMap =
      productList.map((product) => product.toJson()).toList();

  setUp(() {
    ClientConfig.hostUrl = 'example.com';
    clientService = MockClientService();
    clientService.host = ClientConfig.hostUrl;
    sut = ProductService(clientService: clientService);
  });

  group(
    'fixProduct()',
    () => {
      test(
        'check for empty product',
        () {
          var product = Product();
          sut.fixProduct(product);

          var expectedProduct = Product(
            pricing: ProductPrice(),
            availability: Availability(),
          );

          expect(product.pricing, isNotNull);
          expect(product.availability, isNotNull);
          expect(product.toJson(), expectedProduct.toJson());
        },
      ),
    },
  );

  group(
    'getProductsNoCache()',
    () => {
      test(
        'recieve actual data',
        () async {
          /// ARRANGE
          ///
          when(
            () => clientService.getAsync(
              any(
                that: startsWith(
                  CommerceAPIConstants.productsUrl,
                ),
              ),
            ),
          ).thenAnswer(
            (_) => Future.value(
              Response(
                data: {'products': productListMap},
                requestOptions: RequestOptions(),
                statusCode: 200,
              ),
            ),
          );

          /// ACT
          ///
          final response =
              await sut.getProductsNoCache(ProductsQueryParameters());
          final productCollectionResult = response.model;

          /// ASSERT
          ///
          // Check whether
          verify(() => clientService.getAsync(any())).called(1);

          // Check whether recieved products list is not null
          expect(productCollectionResult, isNotNull);
          expect(productCollectionResult?.products, isNotNull);

          // Check if the recieved list is similar to the expected list
          // currently disabled due to unimplemented operator==

          final actualList = productCollectionResult?.products!
              .map((product) => product.toJson())
              .toList();

          expect(actualList!.length, productList.length);
          for (int i = 0; i < productList.length; i++) {
            Product expectedProduct = productList[i];
            sut.fixProduct(expectedProduct);
            expect(jsonEncode(actualList[i]), jsonEncode(expectedProduct));
          }
        },
      ),
      test(
        'invoke exception',
        () async {
          /// ARRANGE
          ///
          when(
            () => clientService.getAsync(
              any(
                that: startsWith(
                  CommerceAPIConstants.productsUrl,
                ),
              ),
            ),
          ).thenThrow(Exception('FakeException'));

          /// ACT
          ///
          final response =
              await sut.getProductsNoCache(ProductsQueryParameters());
          final productCollectionResult = response.model;

          expect(productCollectionResult, isNull);
          expect(response.exception, isNotNull);

          expect(response.exception.toString(),
              'Exception: Exception: FakeException');
        },
      )
    },
  );
}
