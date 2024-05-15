import 'dart:io';

import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/biometric_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/account_type.dart';
import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_auth/biometric_auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/biometric_options/biometric_options_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              sl<BiometricOptionsCubit>()..loadBiometricOptions(),
        ),
        BlocProvider(
          create: (context) => sl<BiometricAuthCubit>(),
        ),
      ],
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          LocalizationConstants.signIn,
          style: OptiTextStyles.titleLarge,
        ),
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
      ),
      body: Container(
        height: double.infinity,
        color: AppStyle.neutral00,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  AssetConstants.logo,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 50),
                Input(
                  label: LocalizationConstants.username,
                  hintText: LocalizationConstants.enterUsername,
                  controller: _usernameController,
                  onTapOutside: (p0) => context.closeKeyboard(),
                  onEditingComplete: () => context.nextFocus(),
                ),
                const SizedBox(height: 16.0),
                Input(
                  label: LocalizationConstants.password,
                  hintText: LocalizationConstants.enterPassword,
                  obscureText: true,
                  controller: _passwordController,
                  onTapOutside: (p0) => context.closeKeyboard(),
                ),
                const SizedBox(height: 16.0),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      context.read<AuthCubit>().loadAuthenticationState();

                      if (state.showBiometricOptionView) {
                        final biometricOptionsState =
                            context.read<BiometricOptionsCubit>().state;
                        final options =
                            biometricOptionsState is BiometricOptionsLoaded
                                ? biometricOptionsState.option
                                : DeviceAuthenticationOption.none;

                        if (options != DeviceAuthenticationOption.none) {
                          AppRoute.biometricLogin.navigate(
                            context,
                            extra: BiometricInfoEntity(
                              biometricOption: options,
                              password: _passwordController.text,
                            ),
                          );

                          return;
                        }
                        return;
                      }

                      context.pop();
                    } else if (state is LoginFailureState) {
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
                        onPressed: () {
                          context.closeKeyboard();
                          BlocProvider.of<LoginCubit>(context).onLoginSubmit(
                            _usernameController.text,
                            _passwordController.text,
                          );
                        },
                        text: LocalizationConstants.signIn,
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
                                          DeviceAuthenticationOption.none)) {
                                return const SizedBox.shrink();
                              }

                              final biometricOption =
                                  state is BiometricOptionsLoaded
                                      ? state.option
                                      : DeviceAuthenticationOption.none;

                              final biometricDisplayOption = Platform.isAndroid
                                  ? LocalizationConstants.fingerprint
                                  : biometricOption ==
                                          DeviceAuthenticationOption.faceID
                                      ? LocalizationConstants.faceID
                                      : LocalizationConstants.touchID;

                              return SecondaryButton(
                                onPressed: () async {
                                  await context
                                      .read<LoginCubit>()
                                      .onBiometricLoginSubmit(biometricOption);
                                },
                                child: Text(
                                  'Use $biometricDisplayOption',
                                  style: OptiTextStyles.subtitle.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
                const SizedBox(height: 16.0),
                PlainButton(
                  onPressed: () => AppRoute.forgotPassword
                      .navigateBackStack(context, extra: AccountType.standard),
                  child: Text(
                    LocalizationConstants.forgotPassword,
                    style: OptiTextStyles.subtitle.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
