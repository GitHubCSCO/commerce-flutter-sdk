// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  static const String welcome = 'welcome';
  static const String domainSelection = 'domainSelection';
  static const String login = 'login';
  static const String shop = 'shop';
  static const String search = 'search';
  static const String account = 'account';
  static const String cart = 'cart';
  static const String productDetails = 'productDetails';
  static const String checkout = 'checkout';
}

enum AppRoute {
  welcome(name: RouteNames.welcome, fullPath: '/${RouteNames.welcome}'),
  domainSelection(name: RouteNames.domainSelection, fullPath: '/${RouteNames.domainSelection}'),
  login(name: RouteNames.login, fullPath: '/${RouteNames.login}'),
  shop(name: RouteNames.shop, fullPath: '/${RouteNames.shop}'),
  search(name: RouteNames.search, fullPath: '/${RouteNames.search}'),
  account(name: RouteNames.account, fullPath: '/${RouteNames.account}'),
  cart(name: RouteNames.cart, fullPath: '/${RouteNames.cart}'),
  productDetails(name: RouteNames.productDetails, fullPath: '/${RouteNames.cart}/:id'),
  checkout(name: RouteNames.checkout, fullPath: '/${RouteNames.checkout}/:id');

  const AppRoute({
    required this.name,
    required this.fullPath,
    this.pathSuffix,
  });

  final String name;
  final String fullPath;
  final String? pathSuffix;

  String get suffix {
    if (pathSuffix != null) {
      return pathSuffix!;
    }

    final splittedList =
        fullPath.split('/').where((element) => element.isNotEmpty).toList();

    if (splittedList.isEmpty) {
      return fullPath;
    }

    return splittedList.last;
  }
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
}
