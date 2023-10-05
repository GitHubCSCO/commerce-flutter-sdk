import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:test/test.dart';

class MockLocalStorageService implements ILocalStorageService {
  Map<String, String?> store = {};

  @override
  String? load(String key) => store[key];

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }

  @override
  Future<void> save(String key, String value) async {
    store[key] = value;
  }
}

class MockSecureStorageService implements ISecureStorageService {
  Map<String, String?> store = {};

  @override
  String? load(String key) => store[key];

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }

  @override
  Future<void> save(String key, String value) async {
    store[key] = value;
  }
}

void main() {
  ILocalStorageService localStorageService = MockLocalStorageService();
  ISecureStorageService secureStorageService = MockSecureStorageService();

  // used Implementation rather than Interface of clientService
  // to get the cookies
  IClientService clientService = ClientService(
    localStorageService: localStorageService,
    secureStorageService: secureStorageService,
  );

  clientService.host = 'https://mobilespire.commerce.insitesandbox.com';
  ClientConfig.hostUrl = 'https://mobilespire.commerce.insitesandbox.com';
  ClientConfig.clientId = 'fluttermobile';
  ClientConfig.clientSecret = 'd66d0479-07f7-47b2-ee1e-0d3a536e6091';

  ProductService sutProductservice =
      ProductService(clientService: clientService);
  group(
      'ProductService',
      () => {
            test('Check if getting response is possible', () async {
              final response = await sutProductservice
                  .getProductsNoCache(ProductsQueryParameters(pageSize: 2));
              final productCollectionResult = response.model;

              if (productCollectionResult == null) expect(true, false);
              if (productCollectionResult?.products == null) {
                expect(true, false);
              }

              final productList = productCollectionResult?.products;
              for (Product product in productList!) {
                print(product.altText ??
                    product.productTitle ??
                    product.pageTitle ??
                    "No title");
              }
            })
          });
}
