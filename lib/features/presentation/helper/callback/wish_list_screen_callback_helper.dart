class WishListScreenCallbackHelper {
  final void Function()? onWishListRenamed;
  final void Function()? onWishListDeleted;

  const WishListScreenCallbackHelper({
    this.onWishListRenamed,
    this.onWishListDeleted,
  });
}
