import 'package:commerce_flutter_app/core/config/test_config_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
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
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(
                        const LoginSubmitEvent(
                          username: TestConfigConstants.userName,
                          password: TestConfigConstants.password,
                        ),
                      );
                      // Perform login logic here
                    },
                    child: const Text('Login'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
