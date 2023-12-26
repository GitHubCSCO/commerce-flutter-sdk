import 'dart:async';
import 'package:commerce_flutter_app/core/constants/route_names.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_screen.dart';
import 'package:commerce_flutter_app/main.dart';
import 'package:flutter/material.dart';
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
  // LoginBloc loginBloc = sl<LoginBloc>();

  late final GoRouter router = GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(loginBloc.stream),
      redirect: (BuildContext context, GoRouterState state) {
        print("a");
        if (loginBloc.state is AuthenticationAuthState) {
          print("b");

          print(loginBloc.state);
          AuthenticationAuthState authState =
              loginBloc.state as AuthenticationAuthState;
          final bool loggedIn = authState.status == AuthStatus.authenticated;
          if (loggedIn) {
            return '/shop';
          } else {
            return '/';
          }
        }
      },
      routes: <RouteBase>[
        GoRoute(name: RouteNames.welcome, path: '/', builder: (context, state) => const WelcomeScreen()),
        GoRoute(name: RouteNames.login, path: '/login', builder: (context, state) => const LoginScreen()),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return NavBarScreen(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // The route branch for the first tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  // The screen to display as the root in the first tab of the
                  // bottom navigation bar.
                  name: RouteNames.shop,
                  path: '/shop',
                  builder: (BuildContext context, GoRouterState state) =>
                      ShopScreen(),
                )
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: RouteNames.search,
                  path: '/search',
                  builder: (BuildContext context, GoRouterState state) =>
                      SearchScreen(),
                )
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: RouteNames.account,
                  path: '/account',
                  builder: (BuildContext context, GoRouterState state) =>
                      AccountScreen(),
                )
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: RouteNames.cart,
                  path: '/cart',
                  builder: (BuildContext context, GoRouterState state) =>
                      CartScreen(),
                )
              ],
            ),
          ],
        )
      ]);
}
