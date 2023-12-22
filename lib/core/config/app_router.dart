import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: <RouteBase>[
  GoRoute(path: '/', builder: (context, state) => LoginScreen()),
  StatefulShellRoute.indexedStack(
    builder: (BuildContext context, GoRouterState state,
        StatefulNavigationShell navigationShell) {
      // Return the widget that implements the custom shell (in this case
      // using a BottomNavigationBar). The StatefulNavigationShell is passed
      // to be able access the state of the shell and to navigate to other
      // branches in a stateful way.
      return NavBarScreen(navigationShell: navigationShell);
    },
    branches: <StatefulShellBranch>[
      // The route branch for the first tab of the bottom navigation bar.
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            // The screen to display as the root in the first tab of the
            // bottom navigation bar.
            path: '/a',
            builder: (BuildContext context, GoRouterState state) =>
                ShopScreen(),
          )
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            // The screen to display as the root in the first tab of the
            // bottom navigation bar.
            path: '/b',
            builder: (BuildContext context, GoRouterState state) =>
                SearchScreen(),
          )
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            // The screen to display as the root in the first tab of the
            // bottom navigation bar.
            path: '/c',
            builder: (BuildContext context, GoRouterState state) =>
                AccountScreen(),
          )
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            // The screen to display as the root in the first tab of the
            // bottom navigation bar.
            path: '/d',
            builder: (BuildContext context, GoRouterState state) =>
                CartScreen(),
          )
        ],
      ),
    ],
  )
]);
