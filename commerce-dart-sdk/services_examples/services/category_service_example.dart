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

  final categoryService = CategoryService(
    clientService: clientService,
    networkService: networkService,
    cacheService: cacheService,
  );

  // Authenticate
  await authenticationService.logInAsync(
      TestConfigConstants.userName, TestConfigConstants.password);

  // Get all categories
  final getCategoriesResult = await categoryService.getCategoryList();

  switch (getCategoriesResult) {
    case Success(value: final value):
      {
        print(value);
      }
    case Failure(errorResponse: final errorResponse):
      {
        print(errorResponse.message);
      }
  }

  // Get a single category
  final getCategoryResult =
      await categoryService.getCategory('8abc025d-7052-4238-b9a0-ac4f00eafd61');

  switch (getCategoryResult) {
    case Success(value: final value):
      {
        print(value);
      }
    case Failure(errorResponse: final errorResponse):
      {
        print(errorResponse.message);
      }
  }

  // Get featured categories
  final getFeaturedCategoriesResult =
      await categoryService.getFeaturedCategories();

  switch (getFeaturedCategoriesResult) {
    case Success(value: final value):
      {
        print(value);
      }
    case Failure(errorResponse: final errorResponse):
      {
        print(errorResponse.message);
      }
  }
}
