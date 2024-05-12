import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListCreateScreenCallbackHelper {
  final void Function()? onWishListCreated;
  final WishListAddToCartCollection? addToCartCollection;

  WishListCreateScreenCallbackHelper({
    this.onWishListCreated,
    this.addToCartCollection,
  });
}
