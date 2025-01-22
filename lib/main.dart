import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/config/analytics_config.dart';
import 'package:commerce_flutter_app/core/config/prod_config_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/config/test_config_constants.dart';
import 'package:commerce_flutter_app/core/extensions/firebase_options_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/core/utils/bloc_observer.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/load_website_url/load_website_url_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/location_search_handler/location_search_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_approval/order_approval_handler/order_approval_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order_handler/saved_order_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_handler/wish_list_handler_cubit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initialHiveDatabase();
  initCommerceSDK();
  await initInjectionContainer();
  await initAppEssentials();

  //If error log is not enabled we should not do anything when an error is presented
  //By default if isErrorLogEnabled is true: FlutterError.presentError = FlutterError.dumpErrorToConsole
  if (sl<OptiLoggerService>().isErrorLogEnabled == false) {
    FlutterError.presentError = (_) => {};
  }

  if (sl<OptiLoggerService>().isDebugLogEnabled) {
    Bloc.observer = const AppBlocObserver();
  }

  await initAnalyticsTracker();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<AuthCubit>()..loadAuthenticationState()),
        BlocProvider(create: (context) => sl<LogoutCubit>()),
        BlocProvider(create: (context) => sl<DomainCubit>()),
        BlocProvider(
            create: (context) => sl<CartCountCubit>()..loadCurrentCartCount()),
        BlocProvider(create: (context) => sl<SavedOrderHandlerCubit>()),
        BlocProvider(create: (context) => sl<WishListHandlerCubit>()),
        BlocProvider(create: (context) => sl<OrderApprovalHandlerCubit>()),
        BlocProvider<LoadWebsiteUrlBloc>(
            create: (context) => sl<LoadWebsiteUrlBloc>()),
        BlocProvider(create: (context) => sl<RootBloc>()),
        BlocProvider<SearchHistoryCubit>(
          create: (context) => sl<SearchHistoryCubit>()..getSearchHistory(),
        ),
        BlocProvider<LocationSearchHandlerCubit>(
            create: (context) => sl<LocationSearchHandlerCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initAnalyticsTracker() async {
  if (sl<AnalyticsConfig>().appCenterSecret?.isNullOrEmpty == false) {
    await AppCenter.start(secret: sl<AnalyticsConfig>().appCenterSecret!);
  }
  if (sl<AnalyticsConfig>().firebaseOptions?.isValid() == true) {
    await Firebase.initializeApp(
      options: sl<AnalyticsConfig>().firebaseOptions,
    );

    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  FlutterError.onError = (errorDetails) async {
    //Some products does not have valid publicly accessible image url
    //We should not report those to crashlytics or in appcenter
    if (errorDetails.exception is NetworkImageLoadException) {
      //if sl<OptiLoggerService>().isErrorLogEnabled is true
      //console logging through FlutterError.presentError
      FlutterError.presentError(errorDetails);
    } else {
      if (sl<AnalyticsConfig>().firebaseOptions?.isValid() == true) {
        await FirebaseCrashlytics.instance
            .recordFlutterFatalError(errorDetails);
      }
      if (sl<AnalyticsConfig>().appCenterSecret?.isNullOrEmpty == false) {
        await AppCenterCrashes.trackException(
          message: errorDetails.exception.toString(),
          type: errorDetails.exception.runtimeType,
          stackTrace: errorDetails.stack,
        );
      }
    }
  };
}

void initialHiveDatabase() async {
  await Hive.initFlutter();
}

void initCommerceSDK() {
  ClientConfig.hostUrl = null;
  ClientConfig.clientId = ProdConfigConstants.clientId;
  ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
}

Future<void> initAppEssentials() async {
  var colorString = await sl<ILocalStorageService>()
      .load(CoreConstants.primaryColorCachingKey);
  if (colorString != null) {
    // Convert back to Color
    OptiAppColors.primaryColor = Color(int.parse(colorString, radix: 16));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<LoadWebsiteUrlBloc, LoadWebsiteUrlState>(
            listener: (_, state) {
              switch (state) {
                case LoadWebsiteUrlLoadedState():
                  launchUrlString(state.authorizedURL);
                case LoadCustomUrlLoadedState():
                  launchUrlString(state.customURL);
                case LoadWebsiteUrlFailureState():
                  CustomSnackBar.showSnackBarMessage(
                    context,
                    state.error,
                  );
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (_, state) async {
              if (state.status == AuthStatus.unauthenticated) {
                await sl<CartCountCubit>().onCartItemChange();
              }
            },
          )
        ],
        child: BlocBuilder<RootBloc, RootState>(
          buildWhen: (previous, current) => current is RootInitial,
          builder: (context, state) {
            final lightTheme = getTheme();
            return MaterialApp.router(
              title: sl<IDeviceService>().applicationName ?? 'Commerce Mobile',
              routerConfig: sl<GoRouter>(),
              theme: lightTheme,
            );
          },
        ));
  }
}
