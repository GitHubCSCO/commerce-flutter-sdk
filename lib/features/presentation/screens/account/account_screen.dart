import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/load_website_url/load_website_url_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/refresh/pull_to_refresh_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/account_header/account_header_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> _reloadAccountPageWithAuthStatus(BuildContext context) async {
  final currentState = context.read<AuthCubit>().state;
  await context.read<AuthCubit>().loadAuthenticationState();
  if (context.mounted) {
    final nextState = context.read<AuthCubit>().state;

    if (authCubitChangeTrigger(currentState, nextState)) {
      // redundant reload, already checked in listenWhen
      return;
    }

    _reloadAccountPage(context);
  }
}

void _reloadAccountPage(BuildContext context) {
  context.read<AccountPageBloc>().add(AccountPageLoadEvent());
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PullToRefreshBloc>(
          create: (context) => sl<PullToRefreshBloc>()),
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider<LoadWebsiteUrlBloc>(create: (context) => sl<LoadWebsiteUrlBloc>()),
      BlocProvider<AccountPageBloc>(
          create: (context) =>
              sl<AccountPageBloc>()..add(AccountPageLoadEvent())),
    ], child: const AccountPage());
  }
}

class AccountPage extends BaseDynamicContentScreen {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PullToRefreshBloc, PullToRefreshState>(
          listener: (context, state) async {
            if (state is PullToRefreshLoadState) {
              await _reloadAccountPageWithAuthStatus(context);
            }
          },
        ),
        BlocListener<LoadWebsiteUrlBloc, LoadWebsiteUrlState>(
            listener: (context, state) {
          switch (state) {
            case LoadWebsiteUrlLoadedState():
              launchUrlString(state.authorizedURL);
            case LoadWebsiteUrlFailureState():
              CustomSnackBar.showSnackBarMessage(
                context,
                "Failed load url",
              );
          }
        }),
        BlocListener<AccountPageBloc, AccountPageState>(
            listener: (context, state) {
          switch (state) {
            case AccountPageLoadingState():
              context.read<CmsCubit>().loading();
            case AccountPageLoadedState():
              context.read<CmsCubit>().buildCMSWidgets(state.pageWidgets);
            case AccountPageFailureState():
              context.read<CmsCubit>().failedLoading();
          }
        }),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              authCubitChangeTrigger(previous, current),
          listener: (context, state) {
            _reloadAccountPage(context);
          },
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<PullToRefreshBloc>(context)
              .add(PullToRefreshInitialEvent());
        },
        child: BlocBuilder<CmsCubit, CmsState>(
          builder: (context, state) {
            switch (state) {
              case CmsInitialState():
              case CmsLoadingState():
                return const Center(child: CircularProgressIndicator());
              case CmsLoadedState():
                return Scaffold(
                  backgroundColor: OptiAppColors.backgroundGray,
                  appBar: context.watch<AuthCubit>().state.status ==
                          AuthStatus.authenticated
                      ? null
                      : AppBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          title: Text(
                            LocalizationConstants.account,
                            style: OptiTextStyles.titleLarge,
                          ),
                          centerTitle: false,
                          automaticallyImplyLeading: false,
                        ),
                  body: ListView(
                    children: [
                      const _AccountHeader(),
                      const SizedBox(height: AppStyle.defaultVerticalPadding),
                      ...buildContentWidgets(state.widgetEntities),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                            context
                                .read<AccountPageBloc>()
                                .getAppVersionAndBuildNumber(),
                            style: OptiTextStyles.subtitleFade),
                      ),
                    ],
                  ),
                );
              default:
                return const CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(
                      child: Center(
                        child: Text(LocalizationConstants.errorLoadingAccount),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
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
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return BlocListener<DomainCubit, DomainState>(
              listener: (context, state) async {
                if (state is DomainLoaded) {
                  await _reloadAccountPageWithAuthStatus(context);
                }
              },
              child: state.status == AuthStatus.authenticated
                  ? const _AccountLoggedInHeader()
                  : const _AccountLoggedOutHeader(),
            );
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
        child: Builder(
          builder: (context) {
            return BlocBuilder<AccountHeaderCubit, AccountHeaderState>(
              builder: (context, state) {
                final String nameLabel;
                if (state is AccountHeaderLoaded) {
                  final combinedName = state.firstName + state.lastName;
                  nameLabel =
                      combinedName.isNotEmpty ? combinedName : state.userName;
                } else {
                  nameLabel = '';
                }

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      nameLabel.isEmpty ? '' : nameLabel[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    nameLabel,
                    style: OptiTextStyles.header2,
                  ),
                  subtitle: Text(
                    state is AccountHeaderLoaded ? state.email : '',
                    style: OptiTextStyles.body,
                  ),
                );
              },
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
          style: OptiTextStyles.body,
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
