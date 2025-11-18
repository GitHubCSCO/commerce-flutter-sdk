import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import '../env/test_config_constants.dart';

void main() async {
  final localStorageService = FakeLocalStorageService();
  final secureStorageService = FakeSecureStorageService();
  final loggerService = FakeLoggerService(true);
  final authStreamService = FakeAuthStreamService();
  ClientConfig.hostUrl = TestConfigConstants.url;
  ClientConfig.clientId = TestConfigConstants.clientId;
  ClientConfig.clientSecret = TestConfigConstants.clientSecret;

  final clientService = ClientService(
      localStorageService: localStorageService,
      secureStorageService: secureStorageService,
      loggerService: loggerService,
      authStreamService: authStreamService);

  final cacheService = FakeCacheService();
  final networkService = FakeNetworkService(true);

  final sessionService = SessionService(
    clientService: clientService,
    cacheService: cacheService,
    networkService: networkService,
  );

  final authenticationService = AuthenticationService(
    clientService: clientService,
    sessionService: sessionService,
    cacheService: cacheService,
    networkService: networkService,
  );

  final productService = ProductService(
    clientService: clientService,
    networkService: networkService,
    cacheService: cacheService,
  );

  // Authenticate
  await authenticationService.logInAsync(
      TestConfigConstants.userName, TestConfigConstants.password);

  final getProductResult = await productService
      .getProductsNoCache(ProductsQueryParameters(pageSize: 1));
// 5e62fc1a-a74e-4975-adda-ac4f00ee110d
  switch (getProductResult) {
    case Success(value: final value):
      {
        print(value?.products);
      }

    case Failure(errorResponse: final errorResponse):
      {
        print(errorResponse.message);
      }
  }
}
