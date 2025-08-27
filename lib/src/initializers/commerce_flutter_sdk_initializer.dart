import 'package:commerce_flutter_sdk/src/app.dart';
import 'package:commerce_flutter_sdk/commerce_config.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/utils/asset_provider.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/opti_logger_service_interface.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/initializers/analytics_initializer.dart';
import 'package:commerce_flutter_sdk/src/initializers/commerce_sdk_initializer.dart';
import 'package:commerce_flutter_sdk/src/initializers/essentials_initializer.dart';
import 'package:commerce_flutter_sdk/src/initializers/hive_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:commerce_flutter_sdk/src/core/utils/bloc_observer.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/load_website_url/load_website_url_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/location_search_handler/location_search_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_approval/order_approval_handler/order_approval_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/saved_order_handler/saved_order_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_handler/wish_list_handler_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommerceFlutterSDK {
  static Future<void> initialize({required CommerceConfig config}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting();

    await AssetPathResolver.setRunningAsPackage(
        config.isRunningAsPackage ?? false);

    // 1️⃣ Core setup
    await HiveInitializer().init();
    await initInjectionContainer();
    if (config.overrideServices != null) {
      await config.overrideServices!(GetIt.I);
    }
    CommerceSdkInitializer().init();

    // 2️⃣ Theme / essentials
    await EssentialsInitializer().init();

    // 3️⃣ Analytics & crash reporting
    await AnalyticsInitializer().init();

    // 4️⃣ Error & Bloc observer
    final logger = GetIt.I<OptiLoggerService>();
    if (!logger.isErrorLogEnabled) {
      FlutterError.presentError = (_) {};
    }
    if (logger.isDebugLogEnabled) {
      Bloc.observer = const AppBlocObserver();
    }

    // 5️⃣ Finally: run the SDK’s own root app,
    // wrapped in all the BlocProviders/Listeners
    runApp(_withBlocsAndListeners(const CommerceApp()));
  }

  static Widget _withBlocsAndListeners(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => GetIt.I<AuthCubit>()..loadAuthenticationState()),
        BlocProvider(create: (_) => GetIt.I<LogoutCubit>()),
        BlocProvider(create: (_) => GetIt.I<DomainCubit>()),
        BlocProvider(
            create: (_) => GetIt.I<CartCountCubit>()..loadCurrentCartCount()),
        BlocProvider(create: (_) => GetIt.I<SavedOrderHandlerCubit>()),
        BlocProvider(create: (_) => GetIt.I<WishListHandlerCubit>()),
        BlocProvider(create: (_) => GetIt.I<OrderApprovalHandlerCubit>()),
        BlocProvider(create: (_) => GetIt.I<LoadWebsiteUrlBloc>()),
        BlocProvider(create: (_) => GetIt.I<RootBloc>()),
        BlocProvider(
            create: (_) => GetIt.I<SearchHistoryCubit>()..getSearchHistory()),
        BlocProvider(create: (_) => GetIt.I<LocationSearchHandlerCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoadWebsiteUrlBloc, LoadWebsiteUrlState>(
            listener: (_, state) {
              if (state is LoadWebsiteUrlLoadedState &&
                  !state.isloadInAppBrowser) {
                launchUrlString(state.authorizedURL);
              }
              if (state is LoadCustomUrlLoadedState) {
                launchUrlString(state.customURL);
              }
              if (state is LoadWebsiteUrlFailureState) {
                CustomSnackBar.showSnackBarMessage(_, state.error);
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (_, state) {
              if (state.status == AuthStatus.unauthenticated) {
                GetIt.I<CartCountCubit>().onCartItemChange();
              }
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
