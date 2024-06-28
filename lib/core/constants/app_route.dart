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
  static const String vmi = 'vmi';
  static const String productDetails = 'productDetails';
  static const String topLevelProductDetails = 'topLevelProductDetails';
  static const String checkout = 'checkout';
  static const String vmiCheckout = 'vmiCheckout';
  static const String checkoutSuccess = 'checkoutSuccess';
  static const String productList = 'productList';
  static const String settings = 'settings';
  static const String biometricLogin = 'biometricLogin';
  static const String orderHistory = 'orderHistory';
  static const String vmiOrderHistory = 'vmiOrderHistory';
  static const String quickOrder = 'quickOrder';
  static const String createOrder = 'createOrder';
  static const String countOrder = 'countOrder';
  static const String countInventory = 'countInventory';
  static const String barcodeSearch = 'barcodeSearch';
  static const String wishlists = 'wishlists';
  static const String wishlistsDetails = 'wishlistsDetails';
  static const String wishListInfo = 'wishListInfo';
  static const String wishListCreate = 'wishListCreate';
  static const String addToWishList = 'addToWishList';
  static const String forgotPassword = 'forgotPassword';
  static const String orderDetails = 'orderDetails';
  static const String vmiOrderDetails = 'vmiOrderDetails';
  static const String locationSearch = 'locationSearch';
  static const String vmiLocationNote = 'vmiLocationNote';
  static const String shopBrand = 'shopBrand';
  static const String shopBrandDetails = 'shopBrandDetails';
  static const String brandCategory = 'brandCategory';
  static const String brandProductLines = 'brandProductLines';
  static const String billToShipToChange = 'billToShipToChange';
  static const String billToShipToSelection = 'billToShipToSelection';
  static const String savedOrders = 'savedOrders';
  static const String savedOrderDetails = 'savedOrderDetails';
  static const String pickUpLocation = 'pickUpLocation';
  static const String shopCategory = 'shopCategory';
  static const String shopSubCategory = 'shopSubCategory';
  static const String product = 'product';
  static const String addCreditCard = 'addCreditCard';
  static const String addShippingAddress = 'addShippingAddress';
  static const String savedPayments = 'savedPayments';
  static const String orderApproval = 'orderApproval';
  static const String orderApprovalDetails = 'orderApprovalDetails';
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
  static const String vmi = '/${RoutePaths.account}/${RouteNames.vmi}';
  static const String productDetails =
      '/${RouteNames.productDetails}/:productId';
  static const String topLevelProductDetails =
      '/${RouteNames.topLevelProductDetails}/:productId';
  static const String checkout = '/${RouteNames.checkout}';
  static const String vmiCheckout = '/${RouteNames.vmiCheckout}';
  static const String checkoutSuccess = '/${RouteNames.checkoutSuccess}';
  static const String shopProdlist =
      '/${RouteNames.shop}/${RouteNames.productList}';
  static const String shopProdDetails = '$shopProdlist/:id';
  static const String settings = '${RoutePaths.account}/${RouteNames.settings}';
  static const String biometricLogin = '/${RouteNames.biometricLogin}';
  static const String orderHistory =
      '/${RoutePaths.account}/${RouteNames.orderHistory}';
  static const String vmiOrderHistory =
      '/${RoutePaths.vmi}/${RouteNames.vmiOrderHistory}';
  static const String quickOrder = '/${RouteNames.quickOrder}';
  static const String createOrder = '/${RouteNames.createOrder}';
  static const String countOrder = '/${RouteNames.countOrder}';
  static const String countInventory = '/${RouteNames.countInventory}';
  static const String barcodeSearch = '/${RouteNames.barcodeSearch}';
  static const String wishlists =
      '${RoutePaths.account}/${RouteNames.wishlists}';
  static const String locationSearch = '/${RouteNames.locationSearch}';
  static const String wishlistsDetails = '$wishlists/:id';
  static const String vmiLocationNote = '/${RouteNames.vmiLocationNote}';
  static const String wishListInfo = '/${RouteNames.wishListInfo}';
  static const String wishListCreate = '/${RouteNames.wishListCreate}';
  static const String addToWishList = '/${RouteNames.addToWishList}';
  static const String forgotPassword = '/${RouteNames.forgotPassword}';
  static const String orderDetails = '${RoutePaths.orderHistory}/:orderNumber';

  static const String shopBrand = '/${RouteNames.shopBrand}';
  static const String shopBrandDetails = '/${RouteNames.shopBrandDetails}';
  static const String brandCategory = '/${RouteNames.brandCategory}';
  static const String brandProductLines = '/${RouteNames.brandProductLines}';
  static const String billToShipToChange = '/${RouteNames.billToShipToChange}';
  static const String billToShipToSelection =
      '/${RouteNames.billToShipToSelection}';
  static const String savedOrders =
      '${RoutePaths.account}/${RouteNames.savedOrders}';
  static const String savedOrderDetails = '${RoutePaths.savedOrders}/:cartId';
  static const String shopCategory = '/${RouteNames.shopCategory}';
  static const String shopSubCategory =
      '/${RouteNames.shopSubCategory}/:categoryId/:categoryTitle/:categoryPath';
  static const String product = '/${RouteNames.product}';
  static const String addCreditCard = '/${RouteNames.addCreditCard}';
  static const String addShippingAddress = '/${RouteNames.addShippingAddress}';
  static const String savedPayments =
      '${RoutePaths.account}/${RouteNames.savedPayments}';
  static const String orderApproval =
      '${RoutePaths.account}/${RouteNames.orderApproval}';
  static const String orderApprovalDetails =
      '${RoutePaths.orderApproval}/:cartId';
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
  vmi(name: RouteNames.vmi, fullPath: RoutePaths.vmi),
  productList(name: RouteNames.productList, fullPath: RoutePaths.shopProdlist),
  productDetails(
      name: RouteNames.productDetails, fullPath: RoutePaths.productDetails),
  topLevelProductDetails(
      name: RouteNames.topLevelProductDetails,
      fullPath: RoutePaths.topLevelProductDetails),
  checkout(name: RouteNames.checkout, fullPath: RoutePaths.checkout),
  vmiCheckout(name: RouteNames.vmiCheckout, fullPath: RoutePaths.vmiCheckout),
  checkoutSuccess(
      name: RouteNames.checkoutSuccess, fullPath: RoutePaths.checkoutSuccess),
  settings(name: RouteNames.settings, fullPath: RoutePaths.settings),
  biometricLogin(
      name: RouteNames.biometricLogin, fullPath: RoutePaths.biometricLogin),
  orderHistory(
      name: RouteNames.orderHistory, fullPath: RoutePaths.orderHistory),
  quickOrder(name: RouteNames.quickOrder, fullPath: RoutePaths.quickOrder),
  createOrder(name: RouteNames.createOrder, fullPath: RoutePaths.createOrder),
  countOrder(name: RouteNames.countOrder, fullPath: RoutePaths.countOrder),
  countInventory(
      name: RouteNames.countInventory, fullPath: RoutePaths.countInventory),
  barcodeSearch(
      name: RouteNames.barcodeSearch, fullPath: RoutePaths.barcodeSearch),
  wishlist(name: RouteNames.wishlists, fullPath: RoutePaths.wishlists),
  wishlistsDetails(
      name: RouteNames.wishlistsDetails, fullPath: RoutePaths.wishlistsDetails),
  wishListInfo(
      name: RouteNames.wishListInfo, fullPath: RoutePaths.wishListInfo),
  wishListCreate(
      name: RouteNames.wishListCreate, fullPath: RoutePaths.wishListCreate),
  addToWishList(
      name: RouteNames.addToWishList, fullPath: RoutePaths.addToWishList),
  forgotPassword(
      name: RouteNames.forgotPassword, fullPath: RoutePaths.forgotPassword),
  orderDetails(
      name: RouteNames.orderDetails, fullPath: RoutePaths.orderDetails),

  vmiOrderDetails(
      name: RouteNames.vmiOrderDetails, fullPath: RoutePaths.orderDetails),
  locationSearch(
      name: RouteNames.locationSearch, fullPath: RoutePaths.locationSearch),
  vmilocaitonote(
      name: RouteNames.vmiLocationNote, fullPath: RoutePaths.vmiLocationNote),
  vmiOrderHistory(
      name: RouteNames.vmiOrderHistory, fullPath: RoutePaths.vmiOrderHistory),
  billToShipToChange(
      name: RouteNames.billToShipToChange,
      fullPath: RoutePaths.billToShipToChange),
  billToShipToSelection(
      name: RouteNames.billToShipToSelection,
      fullPath: RoutePaths.billToShipToSelection),
  shopCategory(
      name: RouteNames.shopCategory, fullPath: RoutePaths.shopCategory),
  shopSubCategory(
      name: RouteNames.shopSubCategory, fullPath: RoutePaths.shopSubCategory),
  product(name: RouteNames.product, fullPath: RoutePaths.product),
  addCreditCard(
      name: RouteNames.addCreditCard, fullPath: RoutePaths.addCreditCard),
  addShippingAddress(
      name: RouteNames.addShippingAddress,
      fullPath: RoutePaths.addShippingAddress),
  savedOrders(name: RouteNames.savedOrders, fullPath: RoutePaths.savedOrders),
  savedOrderDetails(
      name: RouteNames.savedOrderDetails,
      fullPath: RoutePaths.savedOrderDetails),
  vmiLocationNote(
      name: RouteNames.vmiLocationNote, fullPath: RoutePaths.vmiLocationNote),
  shopBrand(name: RouteNames.shopBrand, fullPath: RoutePaths.shopBrand),
  shopBrandDetails(
      name: RouteNames.shopBrandDetails, fullPath: RoutePaths.shopBrandDetails),
  brandCategory(
      name: RouteNames.brandCategory, fullPath: RoutePaths.brandCategory),
  brandProductLines(
      name: RouteNames.brandProductLines,
      fullPath: RoutePaths.brandProductLines),
  savedPayments(
      name: RouteNames.savedPayments, fullPath: RoutePaths.savedPayments),
  orderApproval(
      name: RouteNames.orderApproval, fullPath: RoutePaths.orderApproval),
  orderApprovalDetails(
      name: RouteNames.orderApprovalDetails,
      fullPath: RoutePaths.orderApprovalDetails);

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
