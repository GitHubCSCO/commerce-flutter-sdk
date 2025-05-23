import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:commerce_flutter_sdk/src/core/config/route_config.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/services.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/account_usecase/account_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/action_link_usecase/action_link_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/add_credit_card_usecase/add_credit_card_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/add_shipping_address_usecase/add_shipping_address_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/auth_usecase/auth_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_category_usecase/brand_category_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_product_lines_usecase/brand_product_lines_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_usecase/brand_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/billto_shipto_usecase/address_selection/billto_shipto_address_selection_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/billto_shipto_usecase/billto_shipto_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/billing_address_create_usecase/billing_address_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/cart_cms_usecase/cart_cms_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/cart_usecase/cart_content_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/cart_usecase/cart_shipping_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/category_usecase/category_useacase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/checkout_usecase/checkout_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/checkout_usecase/payment_details/payment_details_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/curent_location_usecase/current_location_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/dealer_location_usecase/dealer_location_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/in_app_browser/in_app_browser_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/language_usecase/language_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/invoice_usecase/invoice_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/location_note_usecase/location_note_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/location_search_usecase/location_search_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/login_usecase/forgot_password_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/order_approval_usecase/order_approval_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/pickup_location_usecase/pickup_location_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/platform_usecase/platform_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/warehouse_inventory_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/previous_orders_usecase/previous_orders_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/product_list_filter_usecase/product_list_filter_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/promo_code_usecase/promo_code_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quick_order_usecase/count_inventory_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quick_order_usecase/order_pricing_inventory_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quick_order_usecase/quick_order_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_all_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_communication_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_confirmation_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_details_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_pricing_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/request_quote_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/remote_config/remote_config_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/root_usecase/root_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/saved_order/saved_order_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/saved_payments_usecase/saved_payments_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/search_history_usecase/search_history_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/search_usecase/search_cms_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/search_usecase/add_to_cart_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/selection_usecase/selection_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/show_hide_pricing_inventory_usecase/show_hide_pricing_inventory_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/vmi_usecase/vmi_location_note_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/vmi_usecase/vmi_location_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/vmi_usecase/vmi_main_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/billto_shipto/address_selection/billto_shipto_address_selection_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/billto_shipto/billto_shipto_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/brand/brand_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/brand_category/brand_category_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart_cms/cart_cms_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/category/category_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/language/language_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/show_hide/pricing/show_hide_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/load_website_url/load_website_url_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/location_search/location_search_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/pickup_location/pickup_location_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product/product_collection_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quick_order/auto_complete/quick_order_auto_complete_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quick_order/order_list/order_list_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/in_app_browser/in_app_browser_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/invoice_history/invoice_email/invoice_email_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/location_search_handler/location_search_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/job_quote_details/job_quote_details_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/quote_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/quote_communication/quote_communication_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/quote_details/quote_details_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/quote_pricing/quote_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/request_quote/request_quote_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/refresh/pull_to_refresh_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/remote_config/remote_config_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/search/cms/search_page_cms_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/search/search/search_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/show_hide/inventory/show_hide_inventory_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/vmi/vmi_main/vmi_page_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/account_header/account_header_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/add_credit_card/add_credit_card_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/add_shipping_address/add_shipping_address_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/billing_address/billing_address_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/biometric_auth/biometric_auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/biometric_controller/biometric_controller_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/biometric_options/biometric_options_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/bottom_menu_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/brand/brand_details/brand_details_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/brand/brand_list/brand_list_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/brand/brand_product_line/brand_product_line_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/card_expiration_cubit.dart/card_expiration_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/checkout/expansion_panel/expansion_panel_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/count_inventory/count_inventory_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/current_location_cubit/current_location_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/date_selection/date_selection_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/dealer_location_finder/dealer_location_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/domain_redirect/domain_redirect_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/invoice_history/invoice_detail/invoice_detail_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/invoice_history/invoice_history_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/invoice_history/invoice_history_filter/invoice_history_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/location_note/location_note_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/login/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/login/login_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_approval/order_approval_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_approval/order_approval_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_approval/order_approval_handler/order_approval_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_approval_details/order_approval_details_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_details/order_details_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_history/order_history_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/previous_orders_cubit/previous_orders_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_list_filter/product_list_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/promo_code_cubit/promo_code_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quick_order/order_item_pricing_inventory_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/quote_all_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/quote_confirmation/quote_confirmation_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/quote_tab_switch/quote_tab_switch_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote_filter/quote_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/saved_order/saved_order_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/saved_order_handler/saved_order_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/saved_order_details/saved_order_details_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/saved_payments/saved_payments_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/selection/sales_rep_selection/sales_rep_selection_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/selection/user_selection/user_selection_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/settings_domain/settings_domain_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/vmi_location_note/vmi_location_note_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_add_to/wish_list_add_to_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_create/wish_list_create_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/style_trait/style_trait_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/warehouse_inventory/warehouse_inventory_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_details/wish_list_details_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_handler/wish_list_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_information/wish_list_information_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_information/wish_list_tags_controller_cubit.dart';
import 'package:commerce_flutter_sdk/src/services/local_storage_service.dart';
import 'package:commerce_flutter_sdk/src/services/secure_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjectionContainer() async {
  sl
    //router
    ..registerLazySingleton(() => getRouter(loggerService: sl()))

    //root
    ..registerFactory(() => RootBloc(rootUsecase: sl()))
    ..registerFactory(() => RootUsecase())

    //auth
    ..registerFactory(
        () => AuthCubit(authUsecase: sl(), authStreamService: sl()))
    ..registerFactory(() => AuthUsecase())

    //language
    ..registerFactory(() => LanguageBloc(languageUsecase: sl()))
    ..registerLazySingleton(() => LanguageUsecase())

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
    ..registerFactory(
        () => DomainRedirectCubit(domainUsecase: sl(), languageUsecase: sl()))

    // vmi
    ..registerFactory(() => VMIPageBloc(vmiMainUseCase: sl()))
    ..registerFactory(() => VMIMainUseCase())

    // vmi locations
    ..registerFactory(() => VMILocationBloc(vmiLocationUseCase: sl()))
    ..registerFactory(() => VMILocationUseCase())

    //location note
    ..registerFactory(() => LocationNoteCubit(locationNoteUsecase: sl()))
    ..registerFactory(() => LocationNoteUsecase())

    // vmi location note
    ..registerFactory(() => VMILocationNoteCubit(vmilocationNoteUsecase: sl()))
    ..registerFactory(() => VmiLocationNoteUsecase())

    // current location
    ..registerFactory(() => CurrentLocationCubit(currentLocationUseCase: sl()))
    ..registerFactory(() => CurrentLocationUseCase())

    // dealer location
    ..registerFactory(() => DealerLocationCubit(dealerLocationUsecase: sl()))
    ..registerFactory(() => DealerLocationUsecase())

    // location  search
    ..registerFactory(() => LocationSearchBloc(locationSearchUseCase: sl()))
    ..registerFactory(() => LocationSearchUseCase())
    ..registerFactory(() => LocationSearchHandlerCubit())

    // gmap cubit
    ..registerFactory(() => GMapCubit())

    // previous orders
    ..registerFactory(() => PreviousOrdersCubit(previousOrdersUseCse: sl()))
    ..registerFactory(() => PreviousOrdersUseCse())

    //login
    ..registerFactory(() => LoginCubit(loginUsecase: sl()))
    ..registerFactory(() => LoginUsecase())
    ..registerFactory(() => ForgotPasswordCubit(forgotPasswordUseCase: sl()))
    ..registerFactory(() => ForgotPasswordUseCase())

    //logout
    ..registerFactory(() => LogoutCubit(logoutUsecase: sl()))
    ..registerFactory(() => LogoutUsecase())

    //order history
    ..registerFactory(() =>
        OrderHistoryCubit(orderUsecase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => OrderUsecase())

    //order details
    ..registerFactory(() =>
        OrderDetailsCubit(orderUsercase: sl(), pricingInventoryUseCase: sl()))

    //saved order
    ..registerFactory(() =>
        SavedOrderCubit(savedOrderUsecase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => SavedOrderUsecase())
    ..registerFactory(() => SavedOrderDetailsCubit(
        savedOrderUsecase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => SavedOrderHandlerCubit(savedOrderUsecase: sl()))

    //order approval
    ..registerFactory(() => OrderApprovalUseCase())
    ..registerFactory(() => OrderApprovalCubit(
        orderApprovalUseCase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => OrderApprovalDetailsCubit(
        orderApprovalUseCase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(
        () => OrderApprovalFilterCubit(orderApprovalUseCase: sl()))
    ..registerFactory(() => OrderApprovalHandlerCubit())

    //Invoice history
    ..registerFactory(() => InvoiceUseCase())
    ..registerFactory(() => InvoiceHistoryCubit(invoiceUseCase: sl()))
    ..registerFactory(() => InvoiceHistoryFilterCubit(invoiceUseCase: sl()))
    ..registerFactory(() => InvoiceDetailCubit(invoiceUseCase: sl()))
    ..registerFactory(() => InvoiceEmailCubit(invoiceUseCase: sl()))

    //Pull to refresh
    ..registerFactory(() => PullToRefreshBloc())

    //CMS
    ..registerFactory(() => CmsCubit(
        actionLinkUseCase: sl(),
        productCarouselUseCase: sl(),
        searchHistoryUseCase: sl(),
        pricingInventoryUseCase: sl()))

    //shop
    ..registerFactory(() => ShopPageBloc(shopUseCase: sl()))
    ..registerFactory(() => SearchHistoryCubit(searchHistoryUseCase: sl()))
    ..registerFactory(() => ShopUseCase())

    //search
    ..registerFactory(() => SearchBloc(searchUseCase: sl()))
    ..registerFactory(() => SearchPageCmsBloc(searchUseCase: sl()))
    ..registerFactory(() => SearchCmsUseCase())
    ..registerFactory(() => SearchUseCase())
    ..registerFactory(() => AddToCartCubit(addToCartUsecase: sl()))
    ..registerFactory(() => AddToCartUsecase())
    ..registerFactory(() =>
        SearchProductsCubit(searchUseCase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(
        () => ProductListFilterCubit(productListFilterUsecase: sl()))
    ..registerFactory(() => ProductListFilterUsecase())

    //pricing and inventory
    ..registerFactory(() => PricingInventoryUseCase())

    //product
    ..registerFactory(() => ProductCollectionBloc(searchUseCase: sl()))

    //account
    ..registerFactory(() => AccountPageBloc(accountUseCase: sl()))
    ..registerFactory(() => AccountUseCase())
    ..registerFactory(() => AccountHeaderCubit(accountUseCase: sl()))

    //account
    ..registerFactory(() => RemoteConfigCubit(remoteConfigUsecase: sl()))
    ..registerFactory(() => RemoteConfigUsecase())

    // my quote
    ..registerFactory(() => QuoteBloc(quoteUsecase: sl()))
    ..registerFactory(() => QuoteUsecase())
    ..registerFactory(() => QuoteTabSwitchCubit())

    // quote filter
    ..registerFactory(() => QuoteFilterCubit(quoteUseCase: sl()))

    // select user
    ..registerFactory(() => UserSelectionCubit(selectionUsecase: sl()))
    ..registerFactory(() => SelectionUsecase())

    // select sales rep
    ..registerFactory(() => SalesRepSelectionCubit(selectionUsecase: sl()))

    // request quote
    ..registerFactory(() => RequestQuoteBloc(requestQuoteUsecase: sl()))
    ..registerFactory(() => RequestQuoteUsecase())

    // request quote selection
    ..registerFactory(() => RequestQuoteSelectionBloc())

    //quote details
    ..registerFactory(() => QuoteDetailsBloc(
        quoteDetailsUsecase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => QuoteDetailsUsecase())

    // job quote details
    ..registerFactory(() => JobQuoteDetailsCubit(quoteDetailsUsecase: sl()))

    // quote communication
    ..registerFactory(
        () => QuoteCommunicationBloc(quoteCommunicationUsecase: sl()))
    ..registerFactory(() => QuoteCommunicationUsecase())

    // quote all
    ..registerFactory(() => QuoteAllCubit(quoteAllUsecase: sl()))
    ..registerFactory(() => QuoteAllUsecase())

    // quote pricing
    ..registerFactory(() => QuotePricingBloc(
        quotePricingUsecase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => QuotePricingUsecase())

    // quote confirmation
    ..registerFactory(() => QuoteConfirmationCubit(
        quoteConfirmationUsecase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => QuoteConfirmationUsecase())

    //shop category
    ..registerFactory(() => CategoryBloc(categoryUseCase: sl()))
    ..registerFactory(() => CategoryUseCase())

    //shop brand
    ..registerFactory(() => BrandBloc(brandUseCase: sl()))
    ..registerFactory(() => BrandListCubit(brandUseCase: sl()))
    ..registerFactory(() => BrandDetailsCubit(brandUseCase: sl()))
    ..registerFactory(() => BrandUseCase())
    ..registerFactory(() => BrandCategoryBloc(brandCategoryUseCase: sl()))
    ..registerFactory(() => BrandCategoryUseCase())
    ..registerFactory(
        () => BrandProductLinesCubit(brandProductLinesUseCase: sl()))
    ..registerFactory(() => BrandProductLinesUseCase())

    //cart
    ..registerFactory(() => CartCmsUsecase())
    ..registerFactory(() => CartCmsPageBloc(cartCmsUsecase: sl()))
    ..registerFactory(
        () => CartPageBloc(cartUseCase: sl(), pricingInventoryUseCase: sl()))
    ..registerFactory(() => CartUseCase())
    ..registerFactory(() => CartShippingSelectionBloc(shippingUseCase: sl()))
    ..registerFactory(() => CartShippingUseCase())
    ..registerFactory(() => CartContentBloc(contentUseCase: sl()))
    ..registerFactory(() => CartContentUseCase())
    ..registerFactory(() => CartCountCubit(cartUseCase: sl()))

    //checkout
    ..registerFactory(() => ExpansionPanelCubit())
    ..registerFactory(() => CheckoutBloc(checkoutUseCase: sl()))
    ..registerFactory(() => CheckoutUsecase())
    ..registerFactory(() => PaymentDetailsBloc(paymentDetailsUseCase: sl()))
    ..registerFactory(() => PaymentDetailsUseCase())
    ..registerFactory(() => TokenExBloc())
    ..registerFactory(() => ReviewOrderCubit())

    // Add Credit Card
    ..registerFactory(() => AddCreditCardBloc(addCreditCardUsecase: sl()))
    ..registerFactory(() => AddCreditCardUsecase())

    // Billing Address
    ..registerFactory(() => BillingAddressCubit(billingAddressUsecase: sl()))
    ..registerFactory(() => BillingAddressUsecase())

    // shipping address
    ..registerFactory(
        () => AddShippingAddressCubit(addShippingAddressUsecase: sl()))
    ..registerFactory(() => AddShippingAddressUsecase())

    // saved payments
    ..registerFactory(() => SavedPaymentsCubit(savedPaymentsUsecase: sl()))
    ..registerFactory(() => SavedPaymentsUsecase())

    // PromoCdeo
    ..registerFactory(() => PromoCodeCubit(promoCodeUsecase: sl()))
    ..registerFactory(() => PromoCodeUsecase())

    // Card Expiration
    ..registerFactory(() => CardExpirationCubit())

    //quickOrder
    ..registerFactory(() => OrderListBloc(
          quickOrderUseCase: sl(),
          searchUseCase: sl(),
          pricingInventoryUseCase: sl(),
          scanningMode: ScanningMode.quick,
        ))
    ..registerFactory(() => QuickOrderUseCase())
    ..registerFactory(() => QuickOrderAutoCompleteBloc(
        searchUseCase: sl(), scanningMode: ScanningMode.quick))
    ..registerFactory(
        () => OrderItemPricingInventoryCubit(pricingInventoryUseCase: sl()))
    ..registerFactory(() => OrderPricingInventoryUseCase())

    //countInventory
    ..registerFactory(() => CountInventoryCubit(countInventoryUseCase: sl()))
    ..registerFactory(() => CountInventoryUseCase())

    //billToShipToChange
    ..registerFactory(() => BillToShipToBloc(billToShipToUseCase: sl()))
    ..registerFactory(() => BillToShipToUseCase())

    //billToShipToSelection
    ..registerFactory(() => BilltoShiptoAddressSelectionBloc(
        billToShipToAddressSelectionUseCase: sl()))
    ..registerFactory(() => BillToShipToAddressSelectionUseCase())

    //pickup location
    ..registerFactory(() => PickupLocationBloc(pickUpLocationUseCase: sl()))
    ..registerFactory(() => PickUpLocationUseCase())

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
    ..registerFactory(() => WishListHandlerCubit())
    ..registerFactory(
        () => WishListTagsControllerCubit(wishListDetailsUsecase: sl()))

    //date selection
    ..registerFactory(() => DateSelectionCubit())

    //settings domain
    ..registerFactory(() => SettingsDomainCubit(domainUsecase: sl()))

    //bottom menu
    ..registerFactory(() => BottomMenuCubit(platformUseCase: sl()))
    ..registerFactory(() => PlatformUseCase())

    //for view on website bloc
    ..registerFactory(() => LoadWebsiteUrlBloc(platformUsecase: sl()))

    //product carousel
    ..registerFactory(() => ProductCarouselCubit(pricingInventoryUseCase: sl()))
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

    //show/hide pricing inventory
    ..registerLazySingleton(
        () => ShowHidePricingBloc(showHidePricingInventoryUseCase: sl()))
    ..registerLazySingleton(
        () => ShowHideInventoryBloc(showHidePricingInventoryUseCase: sl()))
    ..registerFactory(() => ShowHidePricingInventoryUseCase())

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

    // In app browser
    ..registerFactory(() => InAppBrowserCubit(inAppBrowserUsecase: sl()))
    ..registerFactory(() => InAppBrowserUsecase())

    //services
    ..registerLazySingleton<ITrackingService>(() => CompositeTrackingService(
          trackers: [
            FirebaseTrackingService(
              sessionService: sl(),
              accountService: sl(),
              analyticsConfig: sl(),
            ),
            AppCenterTrackingService(
              sessionService: sl(),
              accountService: sl(),
              analyticsConfig: sl(),
            ),
          ],
        ))
    ..registerLazySingleton<IRealTimePricingService>(
        () => RealTimePricingService(
              clientService: sl(),
              cacheService: sl(),
              networkService: sl(),
            ))
    ..registerLazySingleton<IRealTimeInventoryService>(
        () => RealTimeInventoryService(
              clientService: sl(),
              cacheService: sl(),
              networkService: sl(),
            ))
    ..registerLazySingleton<IWebsiteService>(() => WebsiteService(
          clientService: sl(),
          sessionService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
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
          cacheService: sl(),
          networkService: sl(),
          clientService: sl(),
        ))
    ..registerLazySingleton<IMobileSpireContentService>(
        () => MobileSpireContentService(
              clientService: sl(),
              cacheService: sl(),
              networkService: sl(),
            ))
    ..registerLazySingleton<ISearchHistoryService>(
        () => SearchHistoryService(commerceAPIServiceProvider: sl()))
    ..registerLazySingleton<ILocationSearchHistoryService>(
        () => LocationSearchHistoryService(commerceAPIServiceProvider: sl()))
    ..registerLazySingleton<IClientService>(() => ClientService(
        localStorageService: sl(),
        secureStorageService: sl(),
        loggerService: sl(),
        authStreamService: sl()))
    ..registerSingletonAsync<ICacheService>(() async {
      var pref = await SharedPreferences.getInstance();
      return CacheService(
        sharedPreferences: pref,
      );
    })
    ..registerLazySingleton<INetworkService>(() => NetworkService())
    ..registerLazySingleton<ISecureStorageService>(() => SecureStorageService())
    ..registerLazySingleton<ILocalStorageService>(() => LocalStorageService())
    ..registerLazySingleton<OptiLoggerService>(
      () => OptiLogger(
        enableApiLog: false,
        enableDebugLog: false,
        enableErrorLog: false,
      ),
    )
    ..registerLazySingleton<ILoggerService>(() => sl<OptiLoggerService>())
    ..registerLazySingleton<IGeoLocationService>(() => GeoLocationService())
    ..registerLazySingleton<IMessageService>(() => MessageService(
        cacheService: sl(), networkService: sl(), clientService: sl()))
    ..registerLazySingleton<ISettingsService>(() => SettingsService(
          cacheService: sl(),
          clientService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IAdminClientService>(() => AdminClientService(
        localStorageService: sl(),
        secureStorageService: sl(),
        loggerService: sl(),
        authStreamService: sl()))
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
    ..registerLazySingleton<IWarehouseService>(() => WarehouseService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<ICartService>(() => CartService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IDealerService>(() => DealerService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IVmiLocationsService>(() => VMILocationService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IVmiService>(() => VMIService(
          commerceAPIServiceProvider: sl(),
          coreServiceProvider: sl(),
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IOrderService>(() => OrderService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IBillToService>(() => BillToService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IInvoiceService>(() => InvoiceService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerSingletonAsync<IDeviceService>(() async {
      final service = DeviceService();
      await service.init();
      return service;
    })
    ..registerLazySingleton<IQuoteService>(() => QuoteService(
        clientService: sl(), cacheService: sl(), networkService: sl()))
    ..registerLazySingleton<IJobQuoteService>(() => JobQuoteService(
        clientService: sl(), cacheService: sl(), networkService: sl()))
    ..registerLazySingleton<ITranslationService>(() => TranslationService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<ILocalizationService>(() => LocalizationService(
          commerceAPIServiceProvider: sl(),
          coreServiceProvider: sl(),
        ))
    ..registerSingletonAsync<IAppConfigurationService>(() async {
      final service = AppConfigurationService(
        commerceAPIServiceProvider: sl(),
        clientService: sl(),
        cacheService: sl(),
        networkService: sl(),
      );
      await service.init();
      return service;
    }, dependsOn: [ICacheService])
    ..registerLazySingleton<AnalyticsConfig>(() => AnalyticsConfig(
          appConfigurationService: sl(),
        ))
    ..registerLazySingleton<IWishListService>(() => WishListService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<ICategoryService>(() => CategoryService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IBrandService>(() => BrandService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IAuthStreamService>(() => AuthStreamService());

  await sl.allReady();
}
