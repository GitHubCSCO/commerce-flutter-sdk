import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  welcome(name: 'welcome', path: '/'),
  domainSelection(name: 'domainSelection', path: '/domainSelection'),
  login(name: 'login', path: '/login'),
  shop(name: 'shop', path: '/shop'),
  search(name: 'search', path: '/search'),
  account(name: 'account', path: '/account'),
  cart(name: 'cart', path: '/cart'),
  productDetails(name: 'productDetails', path: '/productDetails');


  const AppRoute({required this.name, required this.path});

  final String name;
  final String path;
}

extension AppRouteNavigation on AppRoute {
  /// Navigate to a named route.
  void navigate(
    BuildContext context, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    GoRouter.of(context).goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void navigateBackStack(
      BuildContext context, {
        Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{},
        Object? extra,
      }) {
    GoRouter.of(context).pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Create a GoRoute instance for the route.
  GoRoute createRoute(Widget Function(BuildContext, GoRouterState) builder) {
    return GoRoute(
      name: name,
      path: path,
      builder: builder,
    );
  }
}
