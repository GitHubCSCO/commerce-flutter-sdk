import 'dart:io';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_controller/biometric_controller_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_options/biometric_options_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/settings_domain/settings_domain_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SettingsDomainCubit>()..fetchDomain(),
        ),
        BlocProvider(
          create: (context) => sl<BiometricControllerCubit>()
            ..checkBiometricEnabledForCurrentUser(),
        ),
        BlocProvider(
          create: (context) =>
              sl<BiometricOptionsCubit>()..loadBiometricOptions(),
        ),
      ],
      child: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppStyle.neutral00,
        title: Text(LocalizationConstants.settings.localized()),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          children: [
            const _SettingsListWidget(),
            const SizedBox(height: 16),
            BlocBuilder<SettingsDomainCubit, SettingsDomainState>(
              builder: (context, state) {
                if (state is SettingsDomainLoaded) {
                  return const _SettingsDomainSelectorWidget();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsDomainSelectorWidget extends StatelessWidget {
  const _SettingsDomainSelectorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.neutral00,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.currentDomain.localized()),
          const SizedBox(height: 8),
          BlocBuilder<SettingsDomainCubit, SettingsDomainState>(
            builder: (context, state) {
              if (state is SettingsDomainLoaded) {
                return Text(
                  state.domain,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return const Text('...');
              }
            },
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            leadingIcon: SvgPicture.asset(
              AssetConstants.iconChangeDomain,
              semanticsLabel: 'Change domain icon',
              fit: BoxFit.fitWidth,
            ),
            text: LocalizationConstants.changeDomain.localized(),
            onPressed: () =>
                AppRoute.domainSelection.navigateBackStack(context),
          )
        ],
      ),
    );
  }
}

class _SettingsListWidget extends StatelessWidget {
  const _SettingsListWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppStyle.neutral00,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => settingsItems[index],
        separatorBuilder: (context, index) => const Divider(
          height: 0,
          thickness: 1,
        ),
        itemCount: settingsItems.length,
      ),
    );
  }
}

final settingsItems = [
  const _BiometricListTile(),
  _SettingsListItemWidget(
    onTap: (BuildContext context) => showClearCacheDialog(context),
    title: LocalizationConstants.clearCache.localized(),
  ),
  _SettingsListItemWidget(
    title: LocalizationConstants.languages.localized(),
    onTap: (BuildContext context) => AppRoute.language.navigate(context),
    showTrailing: true,
  ),
  // TODO - Enable this later when we implement admin login
  // _SettingsListItemWidget(
  //   title: LocalizationConstants.adminLogin.localized(),
  //   onTap: (BuildContext context) =>
  //       CustomSnackBar.showComingSoonSnackBar(context),
  // ),
];

void showClearCacheDialog(BuildContext context) {
  displayDialogWidget(
    context: context,
    title: LocalizationConstants.clearCache.localized(),
    actions: [
      DialogPlainButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(LocalizationConstants.cancel.localized()),
      ),
      DialogPlainButton(
        onPressed: () async {
          await context.read<SettingsDomainCubit>().clearCache();
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.oK.localized()),
      ),
    ],
  );
}

class _SettingsListItemWidget extends StatelessWidget {
  final void Function(BuildContext context) onTap;
  final String title;
  final bool showTrailing;
  final Widget? trailingWidget;

  const _SettingsListItemWidget({
    required this.onTap,
    required this.title,
    this.showTrailing = false,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  showTrailing
                      ? trailingWidget ??
                          Container(
                            alignment: Alignment.center,
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(7),
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.grey,
                              size: 20,
                            ),
                          )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BiometricListTile extends StatelessWidget {
  const _BiometricListTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => state.status == AuthStatus.authenticated
          ? BlocBuilder<BiometricOptionsCubit, BiometricOptionsState>(
              builder: (context, state) {
                DeviceAuthenticationOption biometricOption =
                    state is BiometricOptionsLoaded
                        ? state.option
                        : DeviceAuthenticationOption.none;

                final biometricDisplay = Platform.isAndroid
                    ? LocalizationConstants.fingerprint.localized()
                    : biometricOption == DeviceAuthenticationOption.faceID
                        ? LocalizationConstants.faceID.localized()
                        : LocalizationConstants.touchID.localized();

                if (biometricOption == DeviceAuthenticationOption.none) {
                  return Container();
                }

                return BlocConsumer<BiometricControllerCubit,
                    BiometricControllerState>(
                  listenWhen: (previous, current) {
                    return previous != current &&
                        previous is! BiometricControllerLoading;
                  },
                  listener: (context, state) {
                    if (state is BiometricControllerChangeSuccessEnabled) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('$biometricDisplay enabled'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }

                    if (state is BiometricControllerChangeSuccessDisabled) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('$biometricDisplay disabled'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }

                    if (state is BiometricControllerChangeLoading) {
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          content: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 30),
                                Text('Please wait...'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is BiometricControllerChangeFailure) {
                      Navigator.of(context, rootNavigator: true).pop();
                      displayDialogWidget(
                        context: context,
                        title: LocalizationConstants.error.localized(),
                        message: 'Failed to enable $biometricDisplay',
                        actions: [
                          DialogPlainButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(LocalizationConstants.oK.localized()),
                          ),
                        ],
                      );
                    }
                  },
                  builder: (context, state) {
                    void submitPassword(String password) {
                      context
                          .read<BiometricControllerCubit>()
                          .enableBiometricWhileLoggedIn(password);
                    }

                    void showPasswordPrompt() {
                      showDialog(
                        context: context,
                        builder: (context) => _PassowordDialog(
                          biometricDisplay: biometricDisplay,
                          submitPassword: submitPassword,
                        ),
                      );
                    }

                    void onChange(bool value) {
                      if (value) {
                        showPasswordPrompt();
                      } else {
                        context
                            .read<BiometricControllerCubit>()
                            .disableBiometricAuthentication();
                      }
                    }

                    return _SettingsListItemWidget(
                      onTap: (context) {},
                      title: 'Enable $biometricDisplay',
                      showTrailing: true,
                      trailingWidget: Switch(
                        value:
                            state is BiometricControllerChangeSuccessEnabled ||
                                state is BiometricControllerEnabled,
                        onChanged: onChange,
                      ),
                    );
                  },
                );
              },
            )
          : Container(),
    );
  }
}

class _PassowordDialog extends StatefulWidget {
  const _PassowordDialog({
    required this.biometricDisplay,
    required this.submitPassword,
  });

  final String biometricDisplay;
  final void Function(String) submitPassword;

  @override
  State<_PassowordDialog> createState() => __PassowordDialogState();
}

class __PassowordDialogState extends State<_PassowordDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter your password to enable ${widget.biometricDisplay}'),
      content: TextField(
        obscureText: true,
        onSubmitted: (password) => context.closeKeyboard(),
        controller: _passwordController,
        decoration: const InputDecoration(
          hintText: 'Password',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        TextButton(
          onPressed: () {
            widget.submitPassword(_passwordController.text);
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.enable.localized()),
        )
      ],
    );
  }
}
