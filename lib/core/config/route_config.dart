// ignore_for_file: unused_local_variable

import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/navigation_node.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/route_generator.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/domain_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_screen.dart';
import 'package:commerce_flutter_app/main.dart';
import 'package:go_router/go_router.dart';

GoRouter getRouter() {
  return GoRouter(
    initialLocation: AppRoute.welcome.path,
    routes: [generateRoutes(_getNavigationRoot())],
  );
}

NavigationNode _getNavigationRoot() {
  final root = createNode(
    name: AppRoute.welcome.name,
    path: AppRoute.welcome.path,
    builder: (context, state) => const WelcomeScreen(),
  );

  final domainSelection = createNode(
    name: AppRoute.domainSelection.name,
    path: AppRoute.domainSelection.path,
    builder: (context, state) => const DomainSelectionScreen(),
    parent: root,
  );

  final login = createNode(
    name: AppRoute.login.name,
    path: AppRoute.login.path,
    builder: (context, state) => const LoginScreen(),
    parent: root,
  );

  final navbarRoot = createNavbarRoot(
    statefulShellBuilder: (context, state, navigationShell) => NavBarScreen(
      navigationShell: navigationShell,
    ),
    parent: root,
  );

  final shop = createNode(
    name: AppRoute.shop.name,
    path: AppRoute.shop.path,
    builder: (context, state) => const ShopScreen(),
    parent: navbarRoot,
  );

  final search = createNode(
    name: AppRoute.search.name,
    path: AppRoute.search.path,
    builder: (context, state) => const SearchScreen(),
    parent: navbarRoot,
  );

  final account = createNode(
    name: AppRoute.account.name,
    path: AppRoute.account.path,
    builder: (context, state) => const AccountScreen(),
    parent: navbarRoot,
  );

  final cart = createNode(
    name: AppRoute.cart.name,
    path: AppRoute.cart.path,
    builder: (context, state) => const CartScreen(),
    parent: navbarRoot,
  );

  return root;
}
