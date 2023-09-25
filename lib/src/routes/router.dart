import 'package:commerce_flutter_app/src/pages/storefront/storefront_page.dart';
import 'package:commerce_flutter_app/src/pages/user_login/user_login_page.dart';
import 'package:go_router/go_router.dart';

import 'package:commerce_flutter_app/src/pages/storefront_login/storefront_login_page.dart';
import 'package:commerce_flutter_app/src/pages/connect_store/connect_store_page.dart';
import 'package:commerce_flutter_app/src/pages/storefront/destinations/account_settings/account_settings.dart';

final GoRouter globalRouter = GoRouter(
  debugLogDiagnostics: true,
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
      routes: [
        GoRoute(
          path: 'account_settings',
          builder: (context, state) => const AccountSettingsPage(),
          routes: [
            GoRoute(
              path: 'languages',
              builder: (context, state) => const LanguagesPages(),
            )
          ],
        ),
        GoRoute(
          path: 'user_login',
          builder: (context, state) => const UserLoginPage(),
        ),
      ],
    ),
  ],
);
