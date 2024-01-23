import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: const Text('Login'),
        centerTitle: false,
        // actions: [
        //   PlainButton(
        //     onPressed: () {
        //       AppRoute.login.navigateBackStack(context);
        //     },
        //     child: const Text('Cancel'),
        //   ),
        // ],
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
                'assets/images/optimizely-logo.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 50),
              Input(
                label: 'Username',
                hintText: 'Enter your username',
                controller: _usernameController,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 16.0),
              Input(
                label: 'Password',
                hintText: 'Enter password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    context.read<AuthCubit>().authenticated();
                    if (state.showBiometricOptionView) {
                      // Display biometric option view
                      return;
                    }

                    AppRoute.shop.navigate(context);
                  } else if (state is LoginFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(state.title ?? ''),
                        content: Text(state.message ?? ''),
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
                        BlocProvider.of<LoginCubit>(context).onLoginSubmit(
                          _usernameController.text,
                          _passwordController.text,
                        );
                        // Perform login logic here
                      },
                      child: const Text('Login'),
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const SecondaryButton(child: Text('Use Face ID')),
              const SizedBox(height: 16.0),
              const PlainButton(child: Text('Forgot password?')),
            ],
          ),
        ),
      ),
    );
  }
}
