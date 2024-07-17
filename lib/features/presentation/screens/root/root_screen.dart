import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_redirect_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain_redirect/domain_redirect_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DomainRedirectCubit>()..redirect(),
      child: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DomainRedirectCubit, DomainRedirectStatus>(
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {
        if (state == DomainRedirectStatus.redirect) {
          context.read<RootBloc>().add(RootInitialEvent());
          AppRoute.shop.navigate(context);
        } else if (state == DomainRedirectStatus.doNotRedirect) {
          AppRoute.welcome.navigate(context);
        }
      },
    );
  }
}
