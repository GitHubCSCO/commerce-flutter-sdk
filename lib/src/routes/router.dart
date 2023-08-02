import 'package:commerce_flutter_app/src/pages/storefront/storefront_page.dart';
import 'package:go_router/go_router.dart';

import 'package:commerce_flutter_app/src/pages/storefront_login/storefront_login_page.dart';
import 'package:commerce_flutter_app/src/pages/connect_store/connect_store_page.dart';

final GoRouter globalRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StorefrontLoginPage(),
      routes: [
        GoRoute(
          path: 'connect_store',
          builder: (context, state) => const ConnectStorePage(),
        )
      ],
    ),
    GoRoute(
      path: '/storefront',
      builder: (context, state) => const StorefrontPage(),
    ),
  ],
);
