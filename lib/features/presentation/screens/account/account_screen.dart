import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/account_header/account_header_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountPageBloc>(
      create: (context) => sl<AccountPageBloc>()..add(AccountPageLoadEvent()),
      child: const AccountPage(),
    );
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
              appBar: context.read<AuthCubit>().state.status ==
                      AuthStatus.authenticated
                  ? null
                  : AppBar(
                      backgroundColor: AppStyle.neutral00,
                      title: const Text(LocalizationConstants.account),
                      centerTitle: false,
                      automaticallyImplyLeading: false,
                    ),
              body: ListView(
                children: [
                  const _AccountHeader(),
                  const SizedBox(height: AppStyle.defaultVerticalPadding),
                  ...buildContentWidgets(state.pageWidgets),
                ],
              ),
            );
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

class _AccountHeader extends StatelessWidget {
  const _AccountHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.neutral00,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyle.defaultHorizontalPadding,
          vertical: AppStyle.defaultVerticalPadding,
        ),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            context.read<AccountPageBloc>().add(AccountPageLoadEvent());
          },
          builder: (context, state) {
            return state.status == AuthStatus.authenticated
                ? const _AccountLoggedInHeader()
                : const _AccountLoggedOutHeader();
          },
        ),
      ),
    );
  }
}

class _AccountLoggedInHeader extends StatelessWidget {
  const _AccountLoggedInHeader();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.read<AuthCubit>().loadAuthenticationState();
        }
      },
      child: BlocProvider(
        create: (context) => sl<AccountHeaderCubit>()..loadAccountHeader(),
        child: BlocBuilder<AccountHeaderCubit, AccountHeaderState>(
          builder: (context, state) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  state is AccountHeaderLoaded ? state.firstName[0] : '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                (state is AccountHeaderLoaded ? state.firstName : '') +
                    (state is AccountHeaderLoaded ? state.lastName : ''),
              ),
              subtitle: Text(state is AccountHeaderLoaded ? state.email : ''),
            );
          },
        ),
      ),
    );
  }
}

class _AccountLoggedOutHeader extends StatelessWidget {
  const _AccountLoggedOutHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          SiteMessageConstants
              .defalutMobileAppAccountUnauthenticatedDescription,
        ),
        const SizedBox(height: AppStyle.defaultVerticalPadding),
        PrimaryButton(
          text: LocalizationConstants.signIn,
          onPressed: () {
            AppRoute.login.navigateBackStack(context);
          },
        ),
      ],
    );
  }
}
