import 'dart:async';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_screen.dart';
import 'package:commerce_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class Approuter {
  LoginBloc loginBloc = sl<LoginBloc>();

  late final GoRouter router = GoRouter(
      initialLocation: AppRoute.login.path,
      refreshListenable: GoRouterRefreshStream(loginBloc.stream),
      redirect: (BuildContext context, GoRouterState state) {
        debugPrint("a");
        if (loginBloc.state is AuthenticationAuthState) {
          debugPrint("b");

          debugPrint('${loginBloc.state}');
          AuthenticationAuthState authState =
              loginBloc.state as AuthenticationAuthState;
          final bool loggedIn = authState.status == AuthStatus.authenticated;
          if (loggedIn) {
            return AppRoute.shop.path;
          } else {
            return AppRoute.login.path;
          }
        }
      },
      routes: <RouteBase>[
        AppRoute.welcome.createRoute(
          (context, state) => const WelcomeScreen(),
        ),
        AppRoute.login.createRoute(
          (context, state) => const LoginScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return NavBarScreen(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // The route branch for the first tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                AppRoute.shop.createRoute(
                  (context, state) => BlocProvider<ShopPageBloc>(
                      create: (context) => sl<ShopPageBloc>()..add(ShopPageLoadEvent()),
                      child: ShopScreen()
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                AppRoute.search.createRoute(
                  (context, state) => BlocProvider<SearchPageBloc>(
                      create: (context) => sl<SearchPageBloc>()..add(SearchPageLoadEvent()),
                      child: SearchScreen()
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                AppRoute.account.createRoute(
                  (context, state) => BlocProvider<AccountPageBloc>(
                      create: (context) => sl<AccountPageBloc>()..add(AccountPageLoadEvent()),
                      child: AccountScreen()
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                AppRoute.cart.createRoute(
                  (context, state) => CartScreen(),
                ),
              ],
            ),
          ],
        )
      ]);
}
