import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  context.go('/a');
                }
              },
              builder: (context, state) {
                if (state is LoginInitialState) {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginSubmitEvent(
                          username: 'saif',
                          password: 'tester1',
                        ),
                      );
                      // Perform login logic here
                    },
                    child: Text('Login'),
                  );
                } else if (state is LoginLoadingState) {
                  return const CircularProgressIndicator(); // Display a loading indicator
                } else if (state is LoginFailureState) {
                  return Text('failure');
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
