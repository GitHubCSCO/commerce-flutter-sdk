import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RootPage();
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DomainCubit, DomainState>(
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {
        if (state is DomainHasValue) {
          AppRoute.shop.navigate(context);
        } else if (state is DomainOperationFailed) {
          AppRoute.welcome.navigate(context);
        }
      },
    );
  }
}
