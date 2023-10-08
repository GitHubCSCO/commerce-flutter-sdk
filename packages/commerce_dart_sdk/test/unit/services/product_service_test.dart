import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:test/test.dart';
import '../../mocks/mocks.dart';

void main() {
  late ProductService sut;
  late IClientService clientService;

  final productList = [
    Product(),
  ];

  setUp(() {
    clientService = MockClientService();
    sut = ProductService(clientService: clientService);
  });

  group(
      'fixProduct()',
      () => {
            test('check for empty product', () {
              var product = Product();
              sut.fixProduct(product);

              expect(product.pricing, isNotNull);
              expect(product.availability, isNotNull);
            })
          });
}

  // DO NOT Remove - the following is a flaky test intended to observe how to
  // use this particular service in actual app
  //
  // group(
  //     'ProductService',
  //     () => {
  //           test('Check if getting response is possible', () async {
  //             final response = await sutProductservice
  //                 .getProductsNoCache(ProductsQueryParameters(pageSize: 2));
  //             final productCollectionResult = response.model;

  //             if (productCollectionResult == null) expect(true, false);
  //             if (productCollectionResult?.products == null) {
  //               expect(true, false);
  //             }

  //             final productList = productCollectionResult?.products;
  //             for (Product product in productList!) {
  //               print(product.altText ??
  //                   product.productTitle ??
  //                   product.pageTitle ??
  //                   "No title");
  //             }
  //           })
  //         });
// }
