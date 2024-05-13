// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  static const String root = 'root';
  static const String welcome = 'welcome';
  static const String domainSelection = 'domainSelection';
  static const String login = 'login';
  static const String shop = 'shop';
  static const String search = 'search';
  static const String account = 'account';
  static const String cart = 'cart';
  static const String productDetails = 'productDetails';
  static const String checkout = 'checkout';
  static const String checkoutSuccess = 'checkoutSuccess';
  static const String productList = 'productList';
  static const String settings = 'settings';
  static const String biometricLogin = 'biometricLogin';
  static const String orderHistory = 'orderHistory';
  static const String barcodeScanner = 'barcodeScanner';
  static const String wishlists = 'wishlists';
  static const String wishlistsDetails = 'wishlistsDetails';
  static const String wishListInfo = 'wishListInfo';
  static const String wishListCreate = 'wishListCreate';
}

class RoutePaths {
  static const String root = '/';
  static const String welcome = '/welcome';
  static const String domainSelection = '/${RouteNames.domainSelection}';
  static const String login = '/${RouteNames.login}';
  static const String shop = '/${RouteNames.shop}';
  static const String search = '/${RouteNames.search}';
  static const String account = '/${RouteNames.account}';
  static const String cart = '/${RouteNames.cart}';
  static const String productDetails =
      '/${RouteNames.productDetails}/:productId';
  static const String checkout = '/${RouteNames.checkout}';
  static const String checkoutSuccess = '/${RouteNames.checkoutSuccess}';
  static const String shopProdlist =
      '/${RouteNames.shop}/${RouteNames.productList}';
  static const String shopProdDetails = '$shopProdlist/:id';
  static const String settings = '${RoutePaths.account}/${RouteNames.settings}';
  static const String biometricLogin = '/${RouteNames.biometricLogin}';
  static const String orderHistory =
      '/${RoutePaths.account}/${RouteNames.orderHistory}';
  static const String barcodeScanner = '/${RouteNames.barcodeScanner}';
  static const String wishlists =
      '${RoutePaths.account}/${RouteNames.wishlists}';
  static const String wishlistsDetails = '$wishlists/:id';
  static const String wishListInfo = '/${RouteNames.wishListInfo}';
  static const String wishListCreate = '/${RouteNames.wishListCreate}';
}

enum AppRoute {
  root(name: RouteNames.root, fullPath: RoutePaths.root),
  welcome(name: RouteNames.welcome, fullPath: RoutePaths.welcome),
  domainSelection(
      name: RouteNames.domainSelection, fullPath: RoutePaths.domainSelection),
  login(name: RouteNames.login, fullPath: RoutePaths.login),
  shop(name: RouteNames.shop, fullPath: RoutePaths.shop),
  search(name: RouteNames.search, fullPath: RoutePaths.search),
  account(name: RouteNames.account, fullPath: RoutePaths.account),
  cart(name: RouteNames.cart, fullPath: RoutePaths.cart),
  productList(name: RouteNames.productList, fullPath: RoutePaths.shopProdlist),
  productDetails(
      name: RouteNames.productDetails, fullPath: RoutePaths.productDetails),
  checkout(name: RouteNames.checkout, fullPath: RoutePaths.checkout),
  checkoutSuccess(
      name: RouteNames.checkoutSuccess, fullPath: RoutePaths.checkoutSuccess),
  settings(name: RouteNames.settings, fullPath: RoutePaths.settings),
  biometricLogin(
      name: RouteNames.biometricLogin, fullPath: RoutePaths.biometricLogin),
  orderHistory(
      name: RouteNames.orderHistory, fullPath: RoutePaths.orderHistory),
  barcodeScanner(
      name: RouteNames.barcodeScanner, fullPath: RoutePaths.barcodeScanner),
  wishlist(name: RouteNames.wishlists, fullPath: RoutePaths.wishlists),
  wishlistsDetails(
      name: RouteNames.wishlistsDetails, fullPath: RoutePaths.wishlistsDetails),
  wishListInfo(
      name: RouteNames.wishListInfo, fullPath: RoutePaths.wishListInfo),
  wishListCreate(name: RouteNames.wishListCreate, fullPath: RoutePaths.wishListCreate);

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

    if (splittedList.length == 1) {
      return '/${splittedList.first}';
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
