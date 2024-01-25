import 'package:commerce_flutter_app/core/config/app_router.dart';
import 'package:commerce_flutter_app/core/config/prod_config_constants.dart';
import 'package:commerce_flutter_app/core/config/test_config_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialHiveDatabase();
  initCommerceSDK();
  initInjectionContainer();
  runApp(
    BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: const MyApp(),
    ),
  );
}

void initialHiveDatabase() async {
  await Hive.initFlutter();
}

void initCommerceSDK() {
  ClientConfig.hostUrl = TestConfigConstants.url;
  ClientConfig.clientId = TestConfigConstants.clientId;
  ClientConfig.clientSecret = TestConfigConstants.clientSecret;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      routerConfig: Approuter().router,
    );
  }
}

class NavBarScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavBarScreen({
    super.key,
    required this.navigationShell,
  });

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
        ),
        body: navigationShell);
  }
}
