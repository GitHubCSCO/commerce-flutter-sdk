import 'dart:async';
import 'dart:io';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/biometric_info_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/account_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/remote_config/remote_config_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/biometric_auth/biometric_auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/biometric_options/biometric_options_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/login/login_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/settings_domain/settings_domain_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginScreen extends BaseStatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = sl<LoginCubit>();
            unawaited(cubit.initialize());
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = sl<SettingsDomainCubit>();
            unawaited(cubit.fetchDomain());
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => sl<RemoteConfigCubit>(),
        ),
        BlocProvider(
          create: (context) {
            final cubit = sl<BiometricOptionsCubit>();
            unawaited(cubit.loadBiometricOptions());
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => sl<BiometricAuthCubit>(),
        ),
      ],
      child: const LoginPage(),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameSignIn,
      );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _showPassword = false;
  var tapCount = 0;
  var _isSignInEnabled = false;

  void _updateSignInButtonOnTextChange() {
    setState(() {
      _isSignInEnabled = _usernameController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _usernameController.removeListener(_updateSignInButtonOnTextChange);
    _passwordController.removeListener(_updateSignInButtonOnTextChange);
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_updateSignInButtonOnTextChange);
    _passwordController.addListener(_updateSignInButtonOnTextChange);
  }

  void _fillCredentials(String? username, String? password) {
    setState(() {
      _usernameController.text = username ?? "";
      _passwordController.text = password ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppStyle.neutral00,
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: Text(
                  LocalizationConstants.signIn.localized(),
                  style: OptiTextStyles.titleLarge,
                ),
                centerTitle: false,
                actions: [
                  PlainButton(
                    onPressed: () {
                      context.pop();
                    },
                    text: LocalizationConstants.cancel.localized(),
                  ),
                ],
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(5),
                  child: Container(
                    color: AppStyle.neutral75,
                    height: 5,
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            tapCount++;
                            if (tapCount == 10) {
                              await context
                                  .read<RemoteConfigCubit>()
                                  .fetchDevMode();
                            }
                          },
                          child: Image.asset(
                            AssetConstants.logo,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocListener<SettingsDomainCubit, SettingsDomainState>(
                          listener: (context, state) async {
                            if (state is SettingsDomainLoaded) {
                              final remoteConfigCubit =
                                  context.read<RemoteConfigCubit>();
                              await remoteConfigCubit
                                  .fetchDebugCredential(state.domain);
                            }
                          },
                          child:
                              BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                            builder: (context, state) {
                              if (state is RemoteConfigDebugCredentialsLoaded) {
                                if (state.creds?.isNotEmpty == true) {
                                  return DropdownButton<Map<String, String>>(
                                    hint: const Text('Select an item'),
                                    items: state.creds?.map((item) {
                                      return DropdownMenuItem<
                                          Map<String, String>>(
                                        value: item,
                                        child: Text(item['username'] ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _fillCredentials(newValue?['username'],
                                            newValue?['password']);
                                      });
                                    },
                                  );
                                }
                              }
                              return Container();
                            },
                          ),
                        ),
                        Input(
                          label: LocalizationConstants.username.localized(),
                          hintText:
                              LocalizationConstants.enterUsername.localized(),
                          controller: _usernameController,
                          onTapOutside: (p0) => context.closeKeyboard(),
                          onEditingComplete: () => context.nextFocus(),
                        ),
                        const SizedBox(height: 16.0),
                        Input(
                          label: LocalizationConstants.password.localized(),
                          hintText:
                              LocalizationConstants.enterPassword.localized(),
                          obscureText: !_showPassword,
                          controller: _passwordController,
                          onTapOutside: (p0) => context.closeKeyboard(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: _showPassword
                                ? SvgAssetImage(
                                    assetName: AssetConstants.iconEyeOff,
                                  )
                                : SvgAssetImage(
                                    assetName: AssetConstants.iconEye,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) async {
                            if (state is LoginSuccessState) {
                              if (context.read<LoginCubit>().showSpinner) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                context.read<LoginCubit>().showSpinner = false;
                              }

                              context
                                  .read<AuthCubit>()
                                  .loadAuthenticationState()
                                  .ignore();

                              if (state.loginStatus ==
                                  LoginStatus.loginSuccessBiometric) {
                                final biometricOptionsState =
                                    context.read<BiometricOptionsCubit>().state;
                                final options = biometricOptionsState
                                        is BiometricOptionsLoaded
                                    ? biometricOptionsState.option
                                    : DeviceAuthenticationOption.none;

                                if (options !=
                                    DeviceAuthenticationOption.none) {
                                  final _ = await context.pushNamed(
                                    AppRoute.biometricLogin.name,
                                    extra: BiometricInfoEntity(
                                      biometricOption: options,
                                      password: _passwordController.text,
                                    ),
                                  );

                                  if (context.mounted) {
                                    context.read<LoginCubit>().showSpinner =
                                        true;
                                    showPleaseWait(context);
                                    context
                                        .read<LoginCubit>()
                                        .handleBillToShipTo()
                                        .ignore();
                                  }

                                  return;
                                }
                                return;
                              } else if (state.loginStatus ==
                                  LoginStatus.loginSuccessBillToShipTo) {
                                if (context.read<LoginCubit>().showSpinner) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  context.read<LoginCubit>().showSpinner =
                                      false;
                                }

                                final isCancel = await context.pushNamed<bool>(
                                  AppRoute.billToShipToChange.name,
                                );

                                if (!context.mounted) {
                                  return;
                                }

                                if (isCancel == null || isCancel) {
                                  await context
                                      .read<LoginCubit>()
                                      .onCancelLogin();
                                  if (context.mounted) {
                                    context
                                        .read<AuthCubit>()
                                        .loadAuthenticationState()
                                        .ignore();
                                  }
                                }
                              }
                              if (context.mounted) {
                                context.pop(true);
                              }
                            } else if (state is LoginFailureState) {
                              if (context.read<LoginCubit>().showSpinner) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                context.read<LoginCubit>().showSpinner = false;
                              }

                              displayDialogWidget(
                                context: context,
                                title: state.title,
                                message: state.message,
                                actions: [
                                  DialogPlainButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(state.buttonText ?? ''),
                                  ),
                                ],
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return const CircularProgressIndicator(); // Display a loading indicator
                            } else {
                              return PrimaryButton(
                                isEnabled: _isSignInEnabled,
                                onPressed: () async {
                                  context.closeKeyboard();
                                  BlocProvider.of<LoginCubit>(context)
                                      .onLoginSubmit(
                                        _usernameController.text,
                                        _passwordController.text,
                                      )
                                      .ignore();
                                },
                                text: LocalizationConstants.signIn.localized(),
                              );
                            }
                          },
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return state is LoginLoadingState
                                ? const SizedBox.shrink()
                                : const SizedBox(height: 16.0);
                          },
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return state is LoginLoadingState
                                ? const SizedBox.shrink()
                                : BlocBuilder<BiometricOptionsCubit,
                                    BiometricOptionsState>(
                                    builder: (context, state) {
                                      if (state is BiometricOptionsLoading ||
                                          state is BiometricOptionsUnknown ||
                                          (state is BiometricOptionsLoaded &&
                                              state.option ==
                                                  DeviceAuthenticationOption
                                                      .none)) {
                                        return const SizedBox.shrink();
                                      }

                                      final biometricOption =
                                          state is BiometricOptionsLoaded
                                              ? state.option
                                              : DeviceAuthenticationOption.none;

                                      final biometricDisplayOption = Platform
                                              .isAndroid
                                          ? LocalizationConstants.fingerprint
                                              .localized()
                                          : biometricOption ==
                                                  DeviceAuthenticationOption
                                                      .faceID
                                              ? LocalizationConstants.faceID
                                                  .localized()
                                              : LocalizationConstants.touchID
                                                  .localized();

                                      var biometricDisplayOptionForEvent =
                                          Platform.isAndroid
                                              ? LocalizationConstants
                                                  .fingerprint.keyword
                                              : biometricOption ==
                                                      DeviceAuthenticationOption
                                                          .faceID
                                                  ? LocalizationConstants
                                                      .faceID.keyword
                                                  : LocalizationConstants
                                                      .touchID.keyword;

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SecondaryButton(
                                            onPressed: () async {
                                              await context
                                                  .read<LoginCubit>()
                                                  .onBiometricLoginSubmit(
                                                      biometricOption,
                                                      biometricDisplayOptionForEvent);
                                            },
                                            text: 'Use $biometricDisplayOption',
                                          ),
                                          const SizedBox(height: 16.0),
                                        ],
                                      );
                                    },
                                  );
                          },
                        ),
                        PlainButton(
                          onPressed: () => AppRoute.forgotPassword
                              .navigateBackStack(context,
                                  extra: AccountType.standard),
                          style: OptiTextStyles.subtitle.copyWith(
                            color: OptiAppColors.primaryColor,
                          ),
                          text:
                              LocalizationConstants.forgotPassword.localized(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (context.watch<LoginCubit>().isInfoMessageAvailable) ...{
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginInfoLoadingState) {
                    return LoadingAnimationWidget.progressiveDots(
                      color: OptiAppColors.iconPrimary,
                      size: 30,
                    );
                  }

                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: context
                          .watch<LoginCubit>()
                          .informationText
                          .split(' ')
                          .map(
                        (word) {
                          if (word.contains('{0}')) {
                            return TextSpan(
                              text:
                                  '${LocalizationConstants.privacyPolicy.localized()} ',
                              style: OptiTextStyles.body.copyWith(
                                color: OptiAppColors.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  context.read<RootBloc>().add(
                                        RootAnalyticsEvent(
                                          AnalyticsEvent(
                                            AnalyticsConstants
                                                .eventViewPrivacyPolicy,
                                            AnalyticsConstants.screenNameSignIn,
                                          ),
                                        ),
                                      );

                                  launchUrlString(
                                    context
                                            .read<LoginCubit>()
                                            .privacyPolicyUrl ??
                                        '',
                                  ).ignore();
                                },
                            );
                          } else if (word.contains('{1}')) {
                            return TextSpan(
                              text:
                                  '${LocalizationConstants.termsOfUse.localized()} ',
                              style: OptiTextStyles.body.copyWith(
                                color: OptiAppColors.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  context.read<RootBloc>().add(
                                        RootAnalyticsEvent(
                                          AnalyticsEvent(
                                            AnalyticsConstants
                                                .eventViewTermsOfUse,
                                            AnalyticsConstants.screenNameSignIn,
                                          ),
                                        ),
                                      );

                                  launchUrlString(
                                    context.read<LoginCubit>().termsOfUseUrl ??
                                        '',
                                  ).ignore();
                                },
                            );
                          } else {
                            return TextSpan(
                              text: '$word ',
                              style: OptiTextStyles.body,
                            );
                          }
                        },
                      ).toList(),
                    ),
                  );
                },
              ),
            )
          }
        ],
      ),
    );
  }
}
