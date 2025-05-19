import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/fakes/services/fake_auth_stream_service.dart';
import '../env/test_config_constants.dart';

void main() async {
  final localStorageService = FakeLocalStorageService();
  final secureStorageService = FakeSecureStorageService();
  final loggerService = FakeLoggerService(true);
  final authStreamService = FakeAuthStreamService();
  ClientConfig.hostUrl = "spire-huongsts.insitesoftqa.com";
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
  final realtimePricingService = RealTimePricingService(
      clientService: clientService,
      networkService: networkService,
      cacheService: cacheService);

  // Authenticate
  await authenticationService.logInAsync("huong.admin", "admin1@");

  //get realtime pricing
  final getRealtimePricingResult =
      await realtimePricingService.getProductRealTimePrices(
    RealTimePricingParameters(productPriceParameters: [
      ProductPriceQueryParameter(
        productId: "44f80651-a306-4fc0-93b2-a96600fac4bf",
        qtyOrdered: 1,
        configuration: ["961d9f4c-90cb-40ab-ab5f-aae100bd9706"],
      ),
    ]),
  );

  switch (getRealtimePricingResult) {
    case Success(value: final value):
      {
        print(value
            ?.realTimePricingResults?.first.extendedUnitRegularPriceDisplay);
      }

    case Failure(errorResponse: final errorResponse):
      {
        print(errorResponse.message);
      }
  }
}
