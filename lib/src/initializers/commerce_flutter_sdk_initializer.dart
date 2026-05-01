import 'dart:async';

import 'package:commerce_flutter_sdk/src/app.dart';
import 'package:commerce_flutter_sdk/commerce_config.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/utils/asset_provider.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/opti_logger_service_interface.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/show_hide/inventory/show_hide_inventory_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/show_hide/pricing/show_hide_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/initializers/commerce_sdk_initializer.dart';
import 'package:commerce_flutter_sdk/src/initializers/essentials_initializer.dart';
import 'package:commerce_flutter_sdk/src/initializers/hive_initializer.dart';
import 'package:commerce_flutter_sdk/src/initializers/notification_handler.dart';
import 'package:flutter/foundation.dart';
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
    debugPrint('[CommerceFlutterSDK] starting init…');

    await _runStep('initializeDateFormatting',
        () => initializeDateFormatting());

    await _runStep(
      'AssetPathResolver.setRunningAsPackage',
      () => AssetPathResolver.setRunningAsPackage(
          config.isRunningAsPackage ?? false),
    );

    // 1️⃣ Core setup — these MUST succeed for the app to function.
    await _runStep('HiveInitializer', () => HiveInitializer().init());
    await _runStep('initInjectionContainer', () => initInjectionContainer(),
        timeout: const Duration(seconds: 45));

    if (config.overrideServices != null) {
      await _runStep(
        'config.overrideServices',
        () => config.overrideServices!(GetIt.I),
      );
    }
    await _runStep(
      'CommerceSdkInitializer',
      () async => CommerceSdkInitializer().init(),
    );

    // 2️⃣ Theme / essentials
    await _runStep('EssentialsInitializer', () => EssentialsInitializer().init());

    // 3️⃣ Notifications — FIRE AND FORGET.
    // Previously this was awaited, which meant a hung permission request or
    // failed APNs registration in TestFlight could prevent runApp() from ever
    // being called, leaving the iOS launch storyboard visible (the "blank
    // white screen" symptom). Notifications are not critical to first paint,
    // so we kick them off asynchronously and let the app render immediately.
    unawaited(_initializeNotificationsSafely());

    // 4️⃣ Bloc observer
    final logger = GetIt.I<OptiLoggerService>();
    if (logger.isDebugLogEnabled) {
      Bloc.observer = const AppBlocObserver();
    }

    // 5️⃣ Finally: run the SDK's own root app, wrapped in all the
    // BlocProviders/Listeners.
    debugPrint('[CommerceFlutterSDK] init complete, calling runApp()');
    runApp(_withBlocsAndListeners(const CommerceApp()));
  }

  /// Wraps a single init step with a timeout and structured logging so a
  /// hang or thrown exception is visible in TestFlight Console logs rather
  /// than producing a silent blank screen. Throws on failure so the caller
  /// in main.dart can show the fatal-error UI.
  static Future<void> _runStep(String label, Future<void> Function() step,
      {Duration timeout = const Duration(seconds: 30)}) async {
    final sw = Stopwatch()..start();
    try {
      await step().timeout(timeout);
      debugPrint('[CommerceFlutterSDK] ✓ $label (${sw.elapsedMilliseconds}ms)');
    } catch (e, st) {
      debugPrint('[CommerceFlutterSDK] ✗ $label FAILED after '
          '${sw.elapsedMilliseconds}ms: $e');
      debugPrint('$st');
      rethrow;
    }
  }

  /// Notification initialization runs in the background and must never throw
  /// out of its scope. Any failure here is logged but does not affect app
  /// startup.
  static Future<void> _initializeNotificationsSafely() async {
    try {
      final coreServiceProvider = sl<ICoreServiceProvider>();
      await NotificationHandler.getInstance(coreServiceProvider)
          .initialize()
          .timeout(const Duration(seconds: 15));
      debugPrint('[CommerceFlutterSDK] ✓ NotificationHandler initialized');
    } catch (e, st) {
      debugPrint('[CommerceFlutterSDK] ✗ NotificationHandler failed: $e');
      debugPrint('$st');
    }
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
        BlocProvider<ShowHidePricingBloc>(
          create: (context) => sl<ShowHidePricingBloc>(),
        ),
        BlocProvider<ShowHideInventoryBloc>(
          create: (context) => sl<ShowHideInventoryBloc>(),
        ),
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
