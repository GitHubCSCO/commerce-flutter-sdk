import 'package:commerce_flutter_app/features/domain/service/interfaces/interfaces.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import '../../sdk/services/mock_api_service_provider.dart';
import '../../sdk/services/mock_services.dart';

final mockSL = GetIt.instance;

Future<void> initInjectionContainerMock() async {
  mockSL
    //commerce api service provider
    ..registerLazySingleton<ICommerceAPIServiceProvider>(
        () => MockAPIServiceProvider())
    ..registerLazySingleton<ICoreServiceProvider>(
        () => MockCoreServiceProvider())
    //services
    ..registerLazySingleton<IAuthStreamService>(() => FakeAuthStreamService())
    ..registerLazySingleton<IWebsiteService>(() => MockWebsiteService())
    ..registerLazySingleton<IProductService>(() => MockProductService())
    ..registerLazySingleton<IAuthenticationService>(
        () => MockAuthenticationService())
    ..registerLazySingleton<ISessionService>(() => MockSessionService())
    ..registerLazySingleton<IContentConfigurationService>(
        () => MockContentConfigurationService())
    ..registerLazySingleton<IMobileContentService>(
        () => MockMobileContentService())
    ..registerLazySingleton<IMobileSpireContentService>(
        () => MockMobileSpireContentService())
    ..registerLazySingleton<IClientService>(() => MockClientService())
    ..registerLazySingleton<ICacheService>(() => MockCacheService())
    ..registerLazySingleton<INetworkService>(() => MockNetworkService())
    ..registerLazySingleton<ISecureStorageService>(
        () => MockSecureStorageService())
    ..registerLazySingleton<ILocalStorageService>(
        () => MockLocalStorageService())
    ..registerLazySingleton<ISettingsService>(() => MockSettingsService())
    ..registerLazySingleton<IAdminClientService>(() => MockAdminClientService())
    ..registerLazySingleton<IAccountService>(() => MockAccountService())
    ..registerLazySingleton<ITrackingService>(() => MockTrackingService())
    ..registerLazySingleton<ILocalizationService>(
        () => MockLocalizationService());
}
