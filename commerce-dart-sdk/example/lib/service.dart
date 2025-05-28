import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

ILocalStorageService localStorageService = FakeLocalStorageService();

ISecureStorageService secureStorageService = FakeSecureStorageService();

IClientService clientService = ClientService(
  localStorageService: localStorageService,
  secureStorageService: secureStorageService,
  loggerService: FakeLoggerService(false),
  authStreamService: FakeAuthStreamService(),
);

ICacheService cacheService = FakeCacheService();

INetworkService networkService = FakeNetworkService(true);

ISessionService sessionService = SessionService(
  clientService: clientService,
  cacheService: cacheService,
  networkService: networkService,
);

IAuthenticationService authenticationService = AuthenticationService(
  clientService: clientService,
  sessionService: sessionService,
  cacheService: cacheService,
  networkService: networkService,
);

IProductService productService = ProductService(
  clientService: clientService,
  cacheService: cacheService,
  networkService: networkService,
);
