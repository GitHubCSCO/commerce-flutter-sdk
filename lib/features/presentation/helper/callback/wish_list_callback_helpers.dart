import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_handler/wish_list_handler_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListCreateScreenCallbackHelper {
  final void Function()? onWishListCreated;
  final WishListAddToCartCollection? addToCartCollection;

  WishListCreateScreenCallbackHelper({
    this.onWishListCreated,
    this.addToCartCollection,
  });
}

class WishListAddToListCallbackHelper {
  final WishListAddToCartCollection addToCartCollection;
  final void Function()? onWishListUpdated;

  const WishListAddToListCallbackHelper({
    required this.addToCartCollection,
    this.onWishListUpdated,
  });
}

class WishListScreenCallbackHelper {
  final void Function()? onWishListUpdated;
  final void Function()? onWishListDeleted;

  const WishListScreenCallbackHelper({
    this.onWishListUpdated,
    this.onWishListDeleted,
  });
}

class WishListCallbackHelper {
  static void addItemsToWishList(
    BuildContext context, {
    required WishListAddToCartCollection addToCartCollection,
    void Function()? onAddedToCart,
  }) {
    AppRoute.addToWishList.navigateBackStack(
      context,
      extra: WishListAddToListCallbackHelper(
        addToCartCollection: addToCartCollection,
        onWishListUpdated: () {
          context.read<WishListHandlerCubit>().shouldRefreshWishList();
          if (onAddedToCart != null) {
            onAddedToCart();
          }
        },
      ),
    );
  }
}
