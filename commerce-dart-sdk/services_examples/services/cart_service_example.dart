import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/fakes/services/fake_auth_stream_service.dart';
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

  final cartService = CartService(
    clientService: clientService,
    networkService: networkService,
    cacheService: cacheService,
  );

  // Authenticate
  await authenticationService.logInAsync('saif', 'tester1');

  await sessionService.getCurrentSession();
  // Get all carts
  final getCartResponse = await cartService.getCurrentCart(
    CartQueryParameters(
        allowInvalidAddress: false,
        alsoPurchasedMaxResults: 0,
        forceRecalculation: false,
        expand: [
          'cartlines',
          'costcodes',
          'shipping',
          'tax',
          'carriers',
          'paymentoptions'
        ]),
  );

  switch (getCartResponse) {
    case Success(value: final value):
      {
        print(value?.cartLines?.length);
      }
    case Failure(errorResponse: final errorResponse):
      {
        print(errorResponse.message);
      }
  }
}
