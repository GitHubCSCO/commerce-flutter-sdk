import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Approuter {
  LoginBloc loginBloc = sl<LoginBloc>();

  late final GoRouter router = GoRouter(
      initialLocation: '/',
      redirect: (BuildContext context, GoRouterState state) {
        if (loginBloc.state is AuthenticationAuthState) {
          AuthenticationAuthState authState =
              loginBloc.state as AuthenticationAuthState;
          final bool loggedIn = authState.status == AuthStatus.authenticated;
          if (loggedIn) {
            return '/a';
          } else {
            return '/';
          }
        }
      },
      routes: <RouteBase>[
        GoRoute(path: '/', builder: (context, state) => LoginScreen()),
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
                  path: '/a',
                  builder: (BuildContext context, GoRouterState state) =>
                      ShopScreen(),
                )
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/b',
                  builder: (BuildContext context, GoRouterState state) =>
                      SearchScreen(),
                )
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/c',
                  builder: (BuildContext context, GoRouterState state) =>
                      AccountScreen(),
                )
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/d',
                  builder: (BuildContext context, GoRouterState state) =>
                      CartScreen(),
                )
              ],
            ),
          ],
        )
      ]);
}
