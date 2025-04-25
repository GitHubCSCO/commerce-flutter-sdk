import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/domain_redirect_status.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/domain_redirect/domain_redirect_cubit.dart';
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
    return BlocConsumer<DomainRedirectCubit, DomainRedirectState>(
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) async {
        if (state.status == DomainRedirectStatus.redirect) {
          context.read<RootBloc>().add(RootInitialEvent());

          if (state.isSignInRequired) {
            final authenticated =
                await context.read<AuthCubit>().loadAuthenticationState();

            if (context.mounted) {
              if (authenticated) {
                AppRoute.shop.navigate(context);
                return;
              }

              AppRoute.landing.navigateBackStack(
                context,
                extra: state.domain != null,
              );
            }
          } else {
            AppRoute.shop.navigate(context);
          }
        } else if (state.status == DomainRedirectStatus.doNotRedirect) {
          AppRoute.welcome.navigate(context);
        }
      },
    );
  }
}
