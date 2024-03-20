import 'package:commerce_flutter_app/core/config/prod_config_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialHiveDatabase();
  initCommerceSDK();
  await initInjectionContainer();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<LogoutCubit>()),
        BlocProvider(create: (context) => sl<DomainCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

void initialHiveDatabase() async {
  await Hive.initFlutter();
}

void initCommerceSDK() {
  ClientConfig.hostUrl = null;
  ClientConfig.clientId = ProdConfigConstants.clientId;
  ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      routerConfig: sl<GoRouter>(),
      theme: lightTheme,
    );
  }
}
