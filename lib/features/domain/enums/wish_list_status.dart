enum WishListStatus {
  initial,
  loading,
  moreLoading,
  success,
  failure,
  realTimeAttributesLoading,
  errorModification,
  moreLoadingFailure,

  listUpdateSuccess,
  listUpdateFailure,
  listRenameLoading,

  listDeleteSuccess,
  listDeleteFailure,
  listDeleteLoading,

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
