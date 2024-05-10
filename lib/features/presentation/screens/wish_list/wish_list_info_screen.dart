import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_information/wish_list_information_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListInformationScreen extends StatelessWidget {
  const WishListInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishListInformationCubit(),
      child: const WishListInformationPage(),
    );
  }
}

class WishListInformationPage extends StatelessWidget {
  const WishListInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
