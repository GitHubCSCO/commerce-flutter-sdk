import 'package:commerce_flutter_app/src/pages/storefront_login/storefront_login_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter globalRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StorefrontLoginPage(),
    )
  ],
);
