import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountPageBloc>(
        create: (context) => sl<AccountPageBloc>()..add(AccountPageLoadEvent()),
        child: const AccountPage());
  }
}

class AccountPage extends BaseDynamicContentScreen {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountPageBloc, AccountPageState>(
      builder: (context, state) {
        switch (state) {
          case AccountPageInitialState():
          case AccountPageLoadingState():
            return const Center(child: CircularProgressIndicator());
          case AccountPageLoadedState():
            return Scaffold(
                body: ListView(
              children: [
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    context.read<AccountPageBloc>().add(AccountPageLoadEvent());
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: state.status == AuthStatus.authenticated
                          ? BlocListener<LogoutCubit, LogoutState>(
                              listener: (context, state) {
                                if (state is LogoutSuccess) {
                                  context
                                      .read<AuthCubit>()
                                      .loadAuthenticationState();
                                }
                              },
                              child: PrimaryButton(
                                child:
                                    const Text(LocalizationConstants.signOut),
                                onPressed: () {
                                  context.read<LogoutCubit>().logout();
                                },
                              ),
                            )
                          : PrimaryButton(
                              child: const Text(LocalizationConstants.signIn),
                              onPressed: () {
                                context.push(AppRoute.login.path);
                              },
                            ),
                    );
                  },
                ),
                ...buildContentWidgets(state.pageWidgets),
              ],
            ));
          case AccountPageFailureState():
            return const Center(
                child: Text(LocalizationConstants.errorLoadingAccount));
          default:
            return const Center(
                child: Text(LocalizationConstants.errorLoadingAccount));
        }
      },
    );
  }
}
