import 'dart:io';

import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_auth/biometric_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BiometricLoginScreen extends StatelessWidget {
  const BiometricLoginScreen({super.key, required this.biometricOption});
  final DeviceAuthenticationOption biometricOption;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BiometricAuthCubit>(),
      child: BiometricLoginPage(
        biometricOption: biometricOption,
      ),
    );
  }
}

class BiometricLoginPage extends StatelessWidget {
  const BiometricLoginPage({super.key, required this.biometricOption});

  final DeviceAuthenticationOption biometricOption;

  @override
  Widget build(BuildContext context) {
    String? title;
    String? biometricOptionName;
    String? biometricOptionInfo;
    String? biometricNameWithSuffix;
    String? iconPath;
    String subtitle;
    String enableButtonTitle;

    if (biometricOption != DeviceAuthenticationOption.none) {
      if (Platform.isAndroid) {
        title = 'Setup Fingerprint ID for\nfast & secure sign in';
        biometricOptionInfo = 'your fingerprint';
        biometricOptionName = 'Fingerprint';
        biometricNameWithSuffix = 'Fingerprint';
        iconPath = AssetConstants.touchID;
      } else {
        if (biometricOption == DeviceAuthenticationOption.touchID) {
          title = 'Setup Touch ID for fast & secure sign in';
          biometricOptionInfo = 'your fingerprint';
          biometricOptionName = 'Touch';
          biometricNameWithSuffix = 'Touch ID';
          iconPath = AssetConstants.touchID;
        } else {
          title = 'Setup Face ID for fast & secure sign in';
          biometricOptionInfo = 'Face ID';
          biometricOptionName = 'Face';
          biometricNameWithSuffix = 'Face ID';
          iconPath = AssetConstants.faceID;
        }
      }
    }

    subtitle =
        'Use $biometricOptionInfo to sign in\ninstead of typing in your login credentials';
    enableButtonTitle = 'Yes, Use $biometricOptionName ID';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: false,
        actions: [
          PlainButton(
            onPressed: () {
              AppRoute.account.navigate(context);
            },
            child: Text(
              LocalizationConstants.cancel,
              style: OptiTextStyles.subtitle.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            color: AppStyle.neutral75,
            height: 20,
          ),
        ),
        title: Text(
          'Setup $biometricNameWithSuffix',
          style: OptiTextStyles.titleLarge,
        ),
      ),
      body: BlocConsumer<BiometricAuthCubit, BiometricAuthState>(
        listener: (context, state) {
          if (state is BiometricAuthSuccess) {
            title = 'Success';
            subtitle =
                'Net time you sign in, you can ${(biometricOptionName == 'Fingerprint' || biometricOptionName == 'Touch') ? 'use your fingerprint' : 'sign in\nwith Face ID'}';
          }
        },
        builder: (context, state) {
          return Container(
            height: double.infinity,
            color: AppStyle.neutral00,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 60),
                  _BiometricIcon(
                      iconPath: iconPath ?? '',
                      enabled: state is BiometricAuthSuccess ? true : false),
                  const SizedBox(height: 30),
                  Text(
                    title ?? '',
                    style: OptiTextStyles.header3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    subtitle,
                    style: OptiTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 200),
                  state is BiometricAuthSuccess
                      ? PrimaryButton(
                          text: LocalizationConstants.continueText,
                          onPressed: () async {
                            AppRoute.account.navigate(context);
                          },
                        )
                      : PrimaryButton(
                          text: enableButtonTitle,
                          onPressed: () async {
                            await context
                                .read<BiometricAuthCubit>()
                                .authenticateWithBiometrics();
                          },
                        ),
                  const SizedBox(height: 5),
                  state is BiometricAuthSuccess
                      ? const SizedBox.shrink()
                      : PlainButton(
                          child: const Text('No Thanks'),
                          onPressed: () {
                            AppRoute.account.navigate(context);
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BiometricIcon extends StatelessWidget {
  const _BiometricIcon({required this.iconPath, required this.enabled});

  final String iconPath;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath.replaceAll('{0}', enabled ? 'enabled' : 'disabled'),
      width: 80,
      height: 80,
    );
  }
}
