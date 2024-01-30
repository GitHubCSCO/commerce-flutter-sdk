import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(loginUsecase: sl<LoginUsecase>()),
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
        title: const Text(LocalizationConstants.signIn),
        centerTitle: false,
        actions: [
          PlainButton(
            onPressed: () {
              context.pop();
            },
            child: const Text(LocalizationConstants.cancel),
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            color: AppStyle.neutral75,
            height: 20,
          ),
        ),
      ),
      body: Padding(
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
                onTapOutside: (context) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 16.0),
              Input(
                label: LocalizationConstants.password,
                hintText: LocalizationConstants.enterPassword,
                obscureText: true,
                controller: _passwordController,
                onTapOutside: (context) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    context.read<AuthCubit>().loadAuthenticationState();

                    if (state.showBiometricOptionView) {
                      // Display biometric option view
                      return;
                    }

                    context.pop();
                  } else if (state is LoginFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: state.title != null ? Text(state.title!) : null,
                        content:
                            state.message != null ? Text(state.message!) : null,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(state.buttonText ?? ''),
                          ),
                        ],
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const CircularProgressIndicator(); // Display a loading indicator
                  } else {
                    return PrimaryButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        BlocProvider.of<LoginCubit>(context).onLoginSubmit(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      },
                      child: const Text(LocalizationConstants.signIn),
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const SecondaryButton(child: Text(LocalizationConstants.faceID)),
              const SizedBox(height: 16.0),
              const PlainButton(
                  child: Text(LocalizationConstants.forgotPassword)),
            ],
          ),
        ),
      ),
    );
  }
}
