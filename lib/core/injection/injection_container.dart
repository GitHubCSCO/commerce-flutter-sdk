import 'package:commerce_flutter_app/core/config/route_config.dart';
import 'package:commerce_flutter_app/features/domain/service/app_configuration_service.dart';
import 'package:commerce_flutter_app/features/domain/service/biometric_authentication_service.dart';
import 'package:commerce_flutter_app/features/domain/service/commerce_api_service_provider.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service.dart';
import 'package:commerce_flutter_app/features/domain/service/core_service_provider.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/device_service.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/biometric_authentication_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/device_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/network_service.dart';
import 'package:commerce_flutter_app/features/domain/usecases/account_usecase/account_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/action_link_usecase/action_link_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/auth_usecase/auth_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_content_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_shipping_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/checkout_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/payment_details/payment_details_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/platform_usecase/platform_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/warehouse_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quick_order_usecase/order_pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quick_order_usecase/quick_order_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_history_usecase/search_history_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_cms_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/add_to_cart_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quick_order/auto_complete/quick_order_auto_complete_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quick_order/order_list/order_list_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/refresh/pull_to_refresh_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/cms/search_page_cms_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search/search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/account_header/account_header_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_auth/biometric_auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_controller/biometric_controller_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_options/biometric_options_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/bottom_menu_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/expansion_panel/expansion_panel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/date_selection/date_selection_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain_redirect/domain_redirect_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_history/order_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/quick_order/order_item_pricing_inventory_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/settings_domain/settings_domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_add_to/wish_list_add_to_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_create/wish_list_create_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/style_trait/style_trait_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/warehouse_inventory/warehouse_inventory_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_details/wish_list_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_information/wish_list_information_cubit.dart';
import 'package:commerce_flutter_app/services/local_storage_service.dart';
import 'package:commerce_flutter_app/services/secure_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

final sl = GetIt.instance;

Future<void> initInjectionContainer() async {
  sl
    //router
    ..registerLazySingleton(() => getRouter())

    //auth
    ..registerFactory(() => AuthCubit(authUsecase: sl()))
    ..registerFactory(() => AuthUsecase())

    //biometric options
    ..registerFactory(() => BiometricOptionsCubit(biometricUsecase: sl()))
    ..registerFactory(() => BiometricUsecase())

    //biometric auth
    ..registerFactory(() => BiometricAuthCubit(biometricUsecase: sl()))

    //biometric controller
    ..registerFactory(() => BiometricControllerCubit(biometricUsecase: sl()))

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

    //order history
    ..registerFactory(() => OrderHistoryCubit(orderUsecase: sl()))
    ..registerFactory(() => OrderUsecase())

    //Pull to refresh
    ..registerFactory(() => PullToRefreshBloc())

    //CMS
    ..registerFactory(() => CmsCubit(
        actionLinkUseCase: sl(),
        productCarouselUseCase: sl(),
        searchHistoryUseCase: sl()))

    //shop
    ..registerFactory(() => ShopPageBloc(shopUseCase: sl()))
    ..registerFactory(() => ShopUseCase())

    //search
    ..registerFactory(() => SearchBloc(searchUseCase: sl()))
    ..registerFactory(() => SearchPageCmsBloc(searchUseCase: sl()))
    ..registerFactory(() => SearchCmsUseCase())
    ..registerFactory(() => SearchUseCase())
    ..registerFactory(() => AddToCartCubit(addToCartUsecase: sl()))
    ..registerFactory(() => AddToCartUsecase())
    ..registerFactory(() => SearchProductsCubit(searchUseCase: sl()))

    //account
    ..registerFactory(() => AccountPageBloc(accountUseCase: sl()))
    ..registerFactory(() => AccountUseCase())
    ..registerFactory(() => AccountHeaderCubit(accountUseCase: sl()))

    //cart
    ..registerFactory(() => CartPageBloc(cartUseCase: sl()))
    ..registerFactory(() => CartUseCase())
    ..registerFactory(() => CartShippingSelectionBloc(shippingUseCase: sl()))
    ..registerFactory(() => CartShippingUseCase())
    ..registerFactory(() => CartContentBloc(contentUseCase: sl()))
    ..registerFactory(() => CartContentUseCase())
    ..registerFactory(() => CartCountCubit(cartUseCase: sl()))

    //checkout
    ..registerFactory(() => ExpansionPanelCubit())
    ..registerFactory(() => CheckoutBloc(checkoutUsecase: sl()))
    ..registerFactory(() => CheckoutUsecase())
    ..registerFactory(() => PaymentDetailsBloc(paymentDetailsUseCase: sl()))
    ..registerFactory(() => PaymentDetailsUseCase())
    ..registerFactory(() => TokenExBloc())
    ..registerFactory(() => ReviewOrderCubit())

    //quickOrder
    ..registerFactory(() => OrderListBloc(quickOrderUseCase: sl()))
    ..registerFactory(() => QuickOrderUseCase())
    ..registerFactory(() => QuickOrderAutoCompleteBloc(searchUseCase: sl()))
    ..registerFactory(
        () => OrderItemPricingInventoryCubit(pricingInventoryUseCase: sl()))
    ..registerFactory(() => OrderPricingInventoryUseCase())

    //barcode
    ..registerFactory(() => BarcodeScanBloc())

    //wishlist
    ..registerFactory(() => WishListCubit(wishListUsecase: sl()))
    ..registerFactory(() => WishListUsecase())
    ..registerFactory(() => WishListDetailsCubit(wishListDetailsUsecase: sl()))
    ..registerFactory(() => WishListDetailsUsecase())
    ..registerFactory(() => WishListInformationCubit(wishListUsecase: sl()))
    ..registerFactory(() => WishListCreateCubit(wishListUsecase: sl()))
    ..registerFactory(() => WishListAddToCubit(wishListUsecase: sl()))

    //date selection
    ..registerFactory(() => DateSelectionCubit())

    //settings domain
    ..registerFactory(() => SettingsDomainCubit(domainUsecase: sl()))

    //bottom menu
    ..registerFactory(() => BottomMenuCubit(platformUseCase: sl()))
    ..registerFactory(() => PlatformUseCase())

    //product carousel
    ..registerFactory(() => ProductCarouselCubit(productCarouselUseCase: sl()))
    ..registerFactory(() => ProductCarouselUseCase())

    // product details
    ..registerFactory(() => ProductDetailsBloc(productDetailsUseCase: sl()))
    ..registerFactory(() => ProductDetailsUseCase())

    // product details pricing
    ..registerFactory(() => ProductDetailsPricingBloc(
        productDetailsPricingUseCase: sl(),
        productDetailsStyleTraitUseCase: sl()))
    ..registerFactory(() => ProductDetailsPricingUseCase())

    // product details Add to cart
    ..registerFactory(() => ProductDetailsAddToCartBloc(
        productDetailsAddToCartUseCase: sl(),
        productDetailsStyleTraitUseCase: sl()))
    ..registerFactory(() => ProductDetailsAddToCartUseCase())

    //product style trait

    ..registerFactory(() => ProductDetailsStyleTraitsUseCase())
    ..registerFactory(() => StyleTraitCubit(styleTraitsUseCase: sl()))

    // warehouse inventory

    ..registerFactory(
        () => WarehouseInventoryCubit(warehouseInventoryUsecase: sl()))
    ..registerFactory(() => WarehouseInventoryUsecase())

    //carousel
    ..registerFactory(() => CarouselIndicatorCubit())

    //action link
    // ..registerFactory(() => ActionLinkCubit(actionLinkUseCase: sl()))
    ..registerFactory(() => ActionLinkUseCase())

    //search history
    // ..registerFactory(() => SearchHistoryCubit(searchHistoryUseCase: sl()))
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
    ..registerLazySingleton<IBiometricAuthenticationService>(
        () => BiometricAuthenticationService(commerceAPIServiceProvider: sl()))
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
    ..registerLazySingleton<INetworkService>(() => NetworkService())
    ..registerLazySingleton<ISecureStorageService>(() => SecureStorageService())
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
        ))
    ..registerLazySingleton<ICartService>(() => CartService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IOrderService>(() => OrderService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerSingletonAsync<IDeviceService>(() async {
      final service = DeviceService();
      await service.init();
      return service;
    })
    ..registerSingletonAsync<IAppConfigurationService>(() async {
      final service = AppConfigurationService(
          commerceAPIServiceProvider: sl(),
          clientService: sl(),
          cacheService: sl(),
          networkService: sl());
      await service.init();
      return service;
    })
    ..registerLazySingleton<FirebaseOptions>(
      () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return FirebaseOptions(
              apiKey:
                  sl<IAppConfigurationService>().firebaseAndroidApiKey ?? "",
              appId: sl<IAppConfigurationService>().firebaseAndroidAppId ?? "",
              messagingSenderId: sl<IAppConfigurationService>()
                      .firebaseAndroidMessagingSenderId ??
                  "",
              projectId:
                  sl<IAppConfigurationService>().firebaseAndroidProjectId ?? "",
              storageBucket:
                  sl<IAppConfigurationService>().firebaseAndroidStorageBucket ??
                      "",
            );
          case TargetPlatform.iOS:
            return FirebaseOptions(
              apiKey: sl<IAppConfigurationService>().firebaseIOSApiKey ?? "",
              appId: sl<IAppConfigurationService>().firebaseIOSAppId ?? "",
              messagingSenderId:
                  sl<IAppConfigurationService>().firebaseIOSMessagingSenderId ??
                      "",
              projectId:
                  sl<IAppConfigurationService>().firebaseIOSProjectId ?? "",
              storageBucket:
                  sl<IAppConfigurationService>().firebaseIOSStorageBucket ?? "",
              iosBundleId:
                  sl<IAppConfigurationService>().firebaseIOSBundleId ?? "",
            );
          default:
            return const FirebaseOptions(
                apiKey: "", appId: "", messagingSenderId: "", projectId: "");
        }
      },
    )
    ..registerLazySingleton<IWishListService>(() => WishListService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ));

  await sl.allReady();
}
