import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_information/wish_list_information_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListInformationScreen extends StatelessWidget {
  const WishListInformationScreen({
    super.key,
    required this.wishList,
    this.onWishListUpdated,
  });

  final WishListEntity wishList;
  final void Function()? onWishListUpdated;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<WishListInformationCubit>()..initialize(wishList: wishList),
      child: WishListInformationPage(
        wishList: wishList,
      ),
    );
  }
}

class WishListInformationPage extends StatelessWidget {
  final WishListEntity wishList;
  final void Function()? onWishListUpdated;

  const WishListInformationPage({
    super.key,
    required this.wishList,
    this.onWishListUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalizationConstants.listInformation),
      ),
    );
  }
}
