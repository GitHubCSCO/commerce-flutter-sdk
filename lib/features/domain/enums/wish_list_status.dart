enum WishListStatus {
  initial,
  loading,
  moreLoading,
  success,
  failure,
  realTimeAttributesLoading,
  errorModification,
  moreLoadingFailure,

  listAddToCartSuccess,
  listAddToCartFailure,
  listAddToCartFailureTimeOut,
  listAddToCartFailureOutOfStock,
  listAddToCartLoading,

  listLineAddToCartSuccess,
  listLineAddToCartFailure,
  listLineAddToCartLoading,

  listLineDeleteSuccess,
  listLineDeleteFailure,
}
