import 'package:commerce_flutter_app/features/domain/service/content_configuration_service.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final sl = GetIt.instance;

Future<void> initInjectionContainer() async {
  sl

    //login
    ..registerLazySingleton(() => LoginBloc(
          LoginUsecase(sl()),
        ))

    //shop
    ..registerFactory(() => ShopPageBloc(sl()))
    ..registerLazySingleton(() => ShopUseCase(sl(), sl()))
    ..registerLazySingleton<IAuthenticationService>(() => AuthenticationService(
          sessionService: sl(),
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<ISessionService>(() => SessionService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IContentConfigurationService>(
        () => ContentConfigurationService(sl(), sl(), sl()))
    ..registerLazySingleton<IMobileContentService>(() => MobileContentService(
        cacheService: sl(), networkService: sl(), clientService: sl()))
    ..registerLazySingleton<IMobileSpireContentService>(
        () => MobileSpireContentService(
              clientService: sl(),
              cacheService: sl(),
              networkService: sl(),
            ))
    ..registerLazySingleton<IClientService>(() =>
        ClientService(localStorageService: sl(), secureStorageService: sl()))

    //product page
    ..registerLazySingleton<ICacheService>(() => FakeCacheService())
    ..registerLazySingleton<INetworkService>(() => FakeNetworkService(true))
    ..registerLazySingleton<ISecureStorageService>(
        () => FakeSecureStorageService())
    ..registerLazySingleton<ILocalStorageService>(
        () => FakeLocalStorageService());
}
