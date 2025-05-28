import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../service.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storefrontUrlController = TextEditingController();
  bool _isLoading = false;

  void _showFailedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Login failed')));
  }

  Future<bool> _login() async {
    setState(() {
      _isLoading = true;
    });

    final username = _userNameController.text;
    final password = _passwordController.text;
    final storefrontUrl = _storefrontUrlController.text;

    debugPrint('Username: $username');
    debugPrint('Password: $password');
    debugPrint('Storefront URL: $storefrontUrl');

    if (username.isEmpty || password.isEmpty || storefrontUrl.isEmpty) {
      setState(() {
        _isLoading = false;
      });

      return false;
    }

    clientService.host = storefrontUrl;
    ClientConfig.hostUrl = storefrontUrl;

    debugPrint('Client host: ${clientService.host}');
    final result = await authenticationService.logInAsync(username, password);

    bool returnVal = false;
    switch (result) {
      case Success(value: final value):
        {
          final isAuthenticated = value;
          if (isAuthenticated ?? false) {
            debugPrint('Login Sucessful');
            returnVal = true;
          } else {
            debugPrint('Login failed');
          }
        }
      case Failure():
        {
          debugPrint('Login failed');
        }
    }

    setState(() {
      _isLoading = false;
    });

    return returnVal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Configured Commerce Dart SDK Demo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                TextField(
                  controller: _storefrontUrlController,
                  decoration: const InputDecoration(
                    hintText: 'Enter storefront URL',
                    border: OutlineInputBorder(),
                    label: Text('Storefront URL'),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                TextField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(),
                    label: Text('Username'),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                    label: Text('Password'),
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _isLoading
                    ? const CircularProgressIndicator()
                    : FilledButton(
                        onPressed: () async {
                          bool isLoggedIn = await _login();
                          if (isLoggedIn) {
                            if (context.mounted) {
                              context.go('/products');
                            }
                          } else {
                            if (context.mounted) {
                              _showFailedSnackbar(context);
                            }
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text('LOGIN'),
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
