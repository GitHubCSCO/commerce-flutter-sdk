import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(
              const LogoutSubmitEvent(),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
