import 'package:commerce_flutter_app/src/pages/storefront_welcome/storefront_welcome_page.dart';
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
          routes: [
            GoRoute(
              path: 'storefront_welcome',
              builder: (context, state) => const StorefrontWelcomePage(),
            ),
          ],
        )
      ],
    ),
  ],
);
