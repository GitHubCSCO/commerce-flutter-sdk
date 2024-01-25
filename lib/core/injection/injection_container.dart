import 'package:commerce_flutter_app/features/domain/service/commerce_api_service_provider.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/usecases/account_usecase/account_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_selection_usecase/domain_selection_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_history_usecase/search_history_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/domain_redirect/domain_redirect_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/domain_selection/domain_selection_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_app/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final sl = GetIt.instance;

Future<void> initInjectionContainer() async {
  sl

    //auth
    ..registerLazySingleton(() => AuthCubit())

    //domain redirect
    ..registerFactory(() => DomainRedirectCubit(domainSelectionUsecase: sl()))

    //domain selection
    ..registerFactory(() => DomainSelectionCubit(sl()))
    ..registerFactory(() => DomainSelectionUsecase())

    //login
    ..registerFactory(() => LoginCubit(loginUsecase: sl()))
    ..registerFactory(() => LoginUsecase())

    //shop
    ..registerFactory(() => ShopPageBloc(shopUseCase: sl()))
    ..registerFactory(() => ShopUseCase(contentConfigurationService: sl()))

    //search
    ..registerFactory(() => SearchPageBloc(searchUseCase: sl()))
    ..registerFactory(() => SearchUseCase(contentConfigurationService: sl()))

    //account
    ..registerFactory(() => AccountPageBloc(accountUseCase: sl()))
    ..registerFactory(() => AccountUseCase(contentConfigurationService: sl()))

    //product carousel
    ..registerFactory(() => ProductCarouselCubit(productCarouselUseCase: sl()))
    ..registerFactory(() =>
        ProductCarouselUseCase(productService: sl(), websiteService: sl()))

    //carousel
    ..registerFactory(() => CarouselIndicatorCubit())

    //search history
    ..registerFactory(() => SearchHistoryCubit(searchHistoryUseCase: sl()))
    ..registerFactory(() => SearchHistoryUseCase(cacheService: sl()))


    //commerce api service provider
    ..registerLazySingleton<ICommerceAPIServiceProvider>(
        () => CommerceAPIServiceProvider())

    //services
    ..registerLazySingleton<IWebsiteService>(() => WebsiteService(
        clientService: sl(),
        sessionService: sl(),
        cacheService: sl(),
        networkService: sl()))
    ..registerLazySingleton<IProductService>(() => ProductService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
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
        () => ContentConfigurationService(commerceAPIServiceProvider: sl()))
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
    ..registerLazySingleton<ICacheService>(() => FakeCacheService())
    ..registerLazySingleton<INetworkService>(() => FakeNetworkService(true))
    ..registerLazySingleton<ISecureStorageService>(
        () => FakeSecureStorageService())
    ..registerLazySingleton<ILocalStorageService>(() => LocalStorageService())
    ..registerLazySingleton<ISettingsService>(() => SettingsService(
          cacheService: sl(),
          clientService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IAdminClientService>(() => AdminClientService(
          localStorageService: sl(),
          secureStorageService: sl(),
        ))
    ..registerLazySingleton<IAccountService>(() => AccountService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ));
}
