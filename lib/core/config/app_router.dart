import 'dart:async';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/domain_selection.dart';
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
  final GoRouter router = GoRouter(
    initialLocation: AppRoute.welcome.path,
    routes: <RouteBase>[
      AppRoute.welcome.createRoute(
        (context, state) => const WelcomeScreen(),
      ),
      AppRoute.domainSelection.createRoute(
        (context, state) => const DomainSelectionScreen(),
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
                (context, state) => ShopScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              AppRoute.search.createRoute(
                (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              AppRoute.account.createRoute(
                (context, state) => const AccountScreen(),
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
    ],
  );
}
