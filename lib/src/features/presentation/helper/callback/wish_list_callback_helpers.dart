import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_handler/wish_list_handler_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListCreateScreenCallbackHelper {
  final WishListAddToCartCollection? addToCartCollection;

  WishListCreateScreenCallbackHelper({
    this.addToCartCollection,
  });

  factory WishListCreateScreenCallbackHelper.fromJson(
      Map<String, dynamic> json) {
    return WishListCreateScreenCallbackHelper(
      addToCartCollection: json['addToCartCollection'] != null
          ? WishListAddToCartCollection.fromJson(json['addToCartCollection'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (addToCartCollection != null) {
      data['addToCartCollection'] = addToCartCollection!.toJson();
    }
    return data;
  }
}

class WishListAddToListCallbackHelper {
  final WishListAddToCartCollection addToCartCollection;

  const WishListAddToListCallbackHelper({
    required this.addToCartCollection,
  });

  factory WishListAddToListCallbackHelper.fromJson(Map<String, dynamic> json) {
    return WishListAddToListCallbackHelper(
      addToCartCollection: WishListAddToCartCollection.fromJson(
        json['addToCartCollection'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['addToCartCollection'] = addToCartCollection.toJson();
    return data;
  }
}

class WishListCallbackHelper {
  static Future<void> addItemsToWishList(
    BuildContext context, {
    required WishListAddToCartCollection addToCartCollection,
    void Function()? onAddedToCart,
  }) async {
    final hasUpdated = await context.pushNamed(
      AppRoute.addToWishList.name,
      extra: WishListAddToListCallbackHelper(
        addToCartCollection: addToCartCollection,
      ),
    );

    if (hasUpdated == true) {
      if (context.mounted) {
        context.read<WishListHandlerCubit>().shouldRefreshWishList();
      }
      if (onAddedToCart != null) {
        onAddedToCart();
      }
    }
  }
}
