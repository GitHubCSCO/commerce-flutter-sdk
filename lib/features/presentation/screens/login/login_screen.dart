import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        actions: [
          PlainButton(
            onPressed: () {
              AppRoute.account.navigate(context);
            },
            child: const Text('Cancel'),
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
              BlocConsumer<LoginBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    AppRoute.shop.navigate(context);
                  } else if (state is LoginFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login failed. Please try again.'),
                        backgroundColor: Colors.red,
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
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginSubmitEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ),
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
