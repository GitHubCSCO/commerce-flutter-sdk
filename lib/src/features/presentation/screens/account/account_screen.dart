import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/core/utils/platform_utils.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/account/account_page_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/load_website_url/load_website_url_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/account_header/account_header_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
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

class AccountScreen extends BaseStatelessWidget {
  const AccountScreen({super.key});

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameAccount,
      );

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
        BlocProvider<AccountPageBloc>(
            create: (context) =>
                sl<AccountPageBloc>()..add(AccountPageLoadEvent())),
      ],
      child: const AccountPage(),
    );
  }
}

class AccountPage extends StatelessWidget with BaseDynamicContentScreen {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoadWebsiteUrlBloc, LoadWebsiteUrlState>(
          listener: (context, state) async {
            if (state is LoadWebsiteUrlLoadedState &&
                state.isloadInAppBrowser) {
              final isWebViewEnabled =
                  await PlatformUtils.isSystemWebViewEnabled(
                      state.authorizedURL);
              if (isWebViewEnabled) {
                await context.pushNamed(
                  AppRoute.inAppBrowser.name,
                  extra: state.authorizedURL,
                );
              } else {
                // Show prompt to the user
                displayDialogWidget(
                  context: context,
                  title: LocalizationConstants.externalBrowserOpenWarningTitle
                      .localized(),
                  message: LocalizationConstants.externalBrowserOpenWarningMsg
                      .localized(),
                  actions: [
                    DialogPlainButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        launchUrlString(state.authorizedURL);
                      },
                      child: Text(LocalizationConstants.oK.localized()),
                    ),
                  ],
                );
              }
            } else if (state is LoadWebsiteUrlFailureState) {
              CustomSnackBar.showSnackBarMessage(
                context,
                state.error,
              );
            }
          },
        ),
        BlocListener<RootBloc, RootState>(
          listener: (context, state) async {
            if (state is RootConfigReload) {
              _reloadAccountPage(context);
            }
          },
        ),
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
          await _reloadAccountPageWithAuthStatus(context);
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
                            LocalizationConstants.account.localized(),
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
                      if (context
                              .read<AccountPageBloc>()
                              .getPrivacyPolicyUrl()
                              .isNullOrEmpty ==
                          false)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              context.read<RootBloc>().add(
                                    RootAnalyticsEvent(
                                      AnalyticsEvent(
                                        AnalyticsConstants
                                            .eventViewPrivacyPolicy,
                                        AnalyticsConstants.screenNameAccount,
                                      ),
                                    ),
                                  );
                              launchUrlString(context
                                  .read<AccountPageBloc>()
                                  .getPrivacyPolicyUrl()!);
                            },
                            child: Text(
                              LocalizationConstants.privacyPolicy.localized(),
                              style: OptiTextStyles.subtitleHighlight,
                            ),
                          ),
                        ),
                      if (context
                              .read<AccountPageBloc>()
                              .getTermsOfUseUrl()
                              .isNullOrEmpty ==
                          false)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              context.read<RootBloc>().add(
                                    RootAnalyticsEvent(
                                      AnalyticsEvent(
                                        AnalyticsConstants.eventViewTermsOfUse,
                                        AnalyticsConstants.screenNameAccount,
                                      ),
                                    ),
                                  );
                              launchUrlString(context
                                  .read<AccountPageBloc>()
                                  .getTermsOfUseUrl()!);
                            },
                            child: Text(
                              LocalizationConstants.termsOfUse.localized(),
                              style: OptiTextStyles.subtitleHighlight,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 4.0),
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
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(
                      child: OptiErrorWidget(
                          onRetry: () {
                            _reloadAccountPage(context);
                          },
                          errorText: LocalizationConstants.errorLoadingAccount
                              .localized()),
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
          if (state.isSignInRequired) {
            AppRoute.landing.navigateBackStack(
              context,
              extra: state.domain != null,
            );
          }
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
                    backgroundColor: OptiAppColors.primaryColor,
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
          context.watch<AccountPageBloc>().loggedOutBannerSiteMessage,
          style: OptiTextStyles.body,
        ),
        const SizedBox(height: AppStyle.defaultVerticalPadding),
        PrimaryButton(
          text: LocalizationConstants.signIn.localized(),
          onPressed: () {
            AppRoute.login.navigateBackStack(context);
          },
        ),
      ],
    );
  }
}
