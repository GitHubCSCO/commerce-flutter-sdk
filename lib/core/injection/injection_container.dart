import 'package:commerce_flutter_app/core/config/route_config.dart';
import 'package:commerce_flutter_app/features/domain/service/commerce_api_service_provider.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service.dart';
import 'package:commerce_flutter_app/features/domain/service/core_service_provider.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_app/features/domain/usecases/account_usecase/account_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/action_link_usecase/action_link_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/auth_usecase/auth_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_history_usecase/search_history_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_cms_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/cms/search_page_cms_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search/search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/account_header/account_header_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/action_link/action_link_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain_redirect/domain_redirect_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/settings_domain/settings_domain_cubit.dart';
import 'package:commerce_flutter_app/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final sl = GetIt.instance;

Future<void> initInjectionContainer() async {
  sl
    //router
    ..registerLazySingleton(() => getRouter())

    //auth
    ..registerFactory(() => AuthCubit(authUsecase: sl()))
    ..registerFactory(() => AuthUsecase())

    //domain selection
    ..registerFactory(() => DomainCubit(domainUsecase: sl()))
    ..registerFactory(() => DomainUsecase())

    //domain redirect
    ..registerFactory(() => DomainRedirectCubit(domainUsecase: sl()))

    //login
    ..registerFactory(() => LoginCubit(loginUsecase: sl()))
    ..registerFactory(() => LoginUsecase())

    //logout
    ..registerFactory(() => LogoutCubit(logoutUsecase: sl()))
    ..registerFactory(() => LogoutUsecase())

    //shop
    ..registerFactory(() => ShopPageBloc(shopUseCase: sl()))
    ..registerFactory(() => ShopUseCase())

    //search
    ..registerFactory(() => SearchBloc(searchUseCase: sl()))
    ..registerFactory(() => SearchPageCmsBloc(searchUseCase: sl()))
    ..registerFactory(() => SearchCmsUseCase())
    ..registerFactory(() => SearchUseCase())

    //account
    ..registerFactory(() => AccountPageBloc(accountUseCase: sl()))
    ..registerFactory(() => AccountUseCase())
    ..registerFactory(() => AccountHeaderCubit(accountUseCase: sl()))

    //settings domain
    ..registerFactory(() => SettingsDomainCubit(domainUsecase: sl()))

    //product carousel
    ..registerFactory(() => ProductCarouselCubit(productCarouselUseCase: sl()))
    ..registerFactory(() => ProductCarouselUseCase())

    // product details
    ..registerFactory(() => ProductDetailsBloc(productDetailsUseCase: sl()))
    ..registerFactory(() => ProductDetailsUseCase())

    // product details pricing
    ..registerFactory(
        () => ProductDetailsPricingBloc(productDetailsPricingUseCase: sl()))
    ..registerFactory(() => ProductDetailsPricingUseCase())

    // product details Add to cart
    ..registerFactory(() => ProductDetailsAddToCartBloc())

    //carousel
    ..registerFactory(() => CarouselIndicatorCubit())

    //action link
    ..registerFactory(() => ActionLinkCubit(actionLinkUseCase: sl()))
    ..registerFactory(() => ActionLinkUseCase())

    //search history
    ..registerFactory(() => SearchHistoryCubit(searchHistoryUseCase: sl()))
    ..registerFactory(() => SearchHistoryUseCase())

    //commerce api service provider
    ..registerLazySingleton<ICommerceAPIServiceProvider>(
        () => CommerceAPIServiceProvider())

    //core service provider
    ..registerLazySingleton<ICoreServiceProvider>(() => CoreServiceProvider())

    //services
    ..registerLazySingleton<IRealTimePricingService>(() =>
        RealTimePricingService(
            clientService: sl(), cacheService: sl(), networkService: sl()))
    ..registerLazySingleton<IRealTimeInventoryService>(() =>
        RealTimeInventoryService(
            clientService: sl(), cacheService: sl(), networkService: sl()))
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
        ))
    ..registerLazySingleton<IAutocompleteService>(() => AutoCompleteService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<ICatalogpagesService>(() => CatalogpagesService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ));
}
