class WishListScreenCallbackHelper {
  final void Function()? onWishListUpdated;
  final void Function()? onWishListDeleted;

  const WishListScreenCallbackHelper({
    this.onWishListUpdated,
    this.onWishListDeleted,
  });
}
