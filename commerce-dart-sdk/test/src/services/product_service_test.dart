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
      productTitle: 'fakeProduct1',
      id: '001',
    ),
    Product(
      productTitle: 'fakeProduct2',
      id: '002',
      trackInventory: true,
    ),
    Product(
      productTitle: 'fakeProduct3',
      id: '003',
      brand: Brand(name: 'fakeBrand1'),
    ),
    Product(
      productTitle: 'fakeProduct4',
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
          verify(() => clientService.getAsync(any())).called(1);

          expect(productCollectionResult, isNotNull);
          expect(productCollectionResult?.products, isNotNull);

          final actualList = productCollectionResult?.products!
              .map((product) => product.toJson())
              .toList();

          expect(actualList!.length, productList.length);
        },
      ),
    },
  );
}
