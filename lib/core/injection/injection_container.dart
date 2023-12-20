import 'dart:typed_data';
import 'package:commerce_flutter_app/services/cache_fake.dart';
import 'package:commerce_flutter_app/services/local_storage_fake.dart';
import 'package:commerce_flutter_app/services/network_fake.dart';
import 'package:commerce_flutter_app/services/secure_storage_fake.dart';
import 'package:get_it/get_it.dart';
import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton<IMobileSpireContentService>(
        () => MobileSpireContentService(
              clientService: sl(),
              cacheService: sl(),
              networkService: sl(),
            ))
    ..registerLazySingleton<IClientService>(() =>
        ClientService(localStorageService: sl(), secureStorageService: sl()))
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

    //product page
    ..registerLazySingleton<ICacheService>(() => FakeCacheService())
    ..registerLazySingleton<INetworkService>(() => FakeNetworkService(true))
    ..registerLazySingleton<ISecureStorageService>(
        () => FakeSecureStorageService())
    ..registerLazySingleton<ILocalStorageService>(
        () => FakeLocalStorageService());
}
