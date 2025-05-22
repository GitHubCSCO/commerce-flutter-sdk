import 'dart:convert';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../../mocks/mocks.dart';

void main() {
  late ProductService sut;
  late IClientService clientService;
  late INetworkService networkService;

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
    networkService = MockNetworkService();
    clientService.host = ClientConfig.hostUrl;
    sut = ProductService(
      clientService: clientService,
      networkService: networkService,
      cacheService: MockCacheService(),
    );
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
            () => networkService.isOnline(),
          ).thenAnswer(
            (_) => Future.value(true),
          );
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
              Success(
                Response(
                  data: {'products': productListMap},
                  requestOptions: RequestOptions(),
                  statusCode: 200,
                ),
              ),
            ),
          );

          /// ACT
          ///
          final response =
              await sut.getProductsNoCache(ProductsQueryParameters());

          late final GetProductCollectionResult? productCollectionResult;
          switch (response) {
            case Success(value: final value):
              {
                productCollectionResult = value!;
              }

            case Failure():
              {
                productCollectionResult = null;
              }
          }

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

      /// Test disabled since exception occurs in a deeper level
//       test(
//         'invoke exception',
//         () async {
//           /// ARRANGE
//           ///
//           when(
//             () => clientService.getAsync(
//               any(
//                 that: startsWith(
//                   CommerceAPIConstants.productsUrl,
//                 ),
//               ),
//             ),
//           ).thenThrow(Exception('FakeException'));

//           /// ACT
//           ///
//           final response =
//               await sut.getProductsNoCache(ProductsQueryParameters());

//           switch (response) {
//             case Success():
//               {
//                 fail('Should not be a success');
//               }

//             case Failure(errorResponse: final errorResponse):
//               {
//                 expect(errorResponse, isNotNull);
//                 // expect(errorResponse.message, 'Exception: FakeException');
//               }
//           }
//           // final productCollectionResult = response;
// //
//           // expect(productCollectionResult, isNull);
//           // expect(response.exception, isNotNull);

//           // expect(response.exception.toString(),
//           // 'Exception: Exception: FakeException');
//         },
      // )
    },
  );
}
