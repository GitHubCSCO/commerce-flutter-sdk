import 'dart:io';

import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_auth/biometric_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

    if (biometricOption != DeviceAuthenticationOption.none) {
      if (Platform.isAndroid) {
        title = 'Setup Fingerprint ID for\nfast & secure sign in';
        biometricOptionInfo = 'your fingerprint';
        biometricOptionName = 'Fingerprint';
        biometricNameWithSuffix = 'Fingerprint';
      } else {
        title =
            'Setup ${biometricOption == DeviceAuthenticationOption.touchID ? 'Touch' : 'Face'} ID for fast &\nsecure sign in';
        biometricOptionInfo =
            biometricOption == DeviceAuthenticationOption.touchID
                ? 'your fingerprint'
                : 'Face ID';
        biometricOptionName =
            biometricOption == DeviceAuthenticationOption.touchID
                ? 'Touch'
                : 'Face';
        biometricNameWithSuffix =
            biometricOption == DeviceAuthenticationOption.touchID
                ? 'Touch ID'
                : 'Face ID';
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: false,
        actions: [
          PlainButton(
            onPressed: () {
              context.pop();
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
      body: Container(
        height: double.infinity,
        color: AppStyle.neutral00,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Biometric Login'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Authenticate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
