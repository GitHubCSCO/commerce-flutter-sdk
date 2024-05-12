enum WishListStatus {
  initial,
  loading,
  moreLoading,
  success,
  failure,
  realTimeAttributesLoading,
  errorModification,
  moreLoadingFailure,

  listCreateLoading,
  listCreateSuccess,
  listCreateFailure,

  listCopyLoading,
  listCopySuccess,
  listCopyFailure,

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

  listItemAddToListSuccess,
  listItemAddToListFailure,
  listItemAddToListLoading,

  listLineDeleteSuccess,
  listLineDeleteFailure,
}
