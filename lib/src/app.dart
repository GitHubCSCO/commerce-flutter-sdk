import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';

class CommerceApp extends StatelessWidget {
  const CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      buildWhen: (p, c) => c is RootInitial,
      builder: (context, state) {
        return MaterialApp.router(
          title: GetIt.I<IDeviceService>().applicationName ?? 'Commerce Mobile',
          routerConfig: GetIt.I<GoRouter>(),
          theme: getTheme(),
        );
      },
    );
  }
}
