import '../screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:go_router/go_router.dart';

import 'constants/config.dart';
import 'screens/login_screen.dart';
import 'screens/products_screen.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) =>
              ProductDetailsScreen(id: state.pathParameters['id'] as String),
        ),
      ],
    ),
  ],
);

void main() {
  ClientConfig.clientId = ConfigConstants.clientId;
  ClientConfig.clientSecret = ConfigConstants.clientSecret;

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
