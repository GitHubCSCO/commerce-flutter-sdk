import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';

class WishListInfoScreenCallbackHelper {
  final WishListEntity wishList;
  final void Function()? onWishListUpdated;

  const WishListInfoScreenCallbackHelper({
    required this.wishList,
    this.onWishListUpdated,
  });
}