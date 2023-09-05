import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLoginPage extends ConsumerStatefulWidget {
  const UserLoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends ConsumerState<UserLoginPage> {
  late ILocalStorageService _localStorageInterface;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _localStorageInterface = ref.read(localStorageInterfaceProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Login')),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/optimizely-logo.png',
                width: 100,
                height: 100,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Username'),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        debugPrint('Sign in');
                      },
                      child: const Text('SIGN IN'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
