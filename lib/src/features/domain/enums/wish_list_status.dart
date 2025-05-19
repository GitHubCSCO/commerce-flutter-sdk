enum WishListStatus {
  initial,
  loading,
  moreLoading,
  success,
  failure,
  realTimeAttributesLoading,
  errorModification,
  moreLoadingFailure,

  allowMultipleListsLoading,
  allowMultipleListsSuccess,
  allowMultipleListsFailure,

  listCreateLoading,
  listCreateSuccess,
  listCreateFailure,
  listCreateEmptyNameFailure,

  listCopyLoading,
  listCopySuccess,
  listCopyFailure,

  listLeaveLoading,
  listLeaveSuccess,
  listLeaveFailure,

  listFavoriteUpdateLoading,
  listFavoriteUpdateSuccessAdded,
  listFavoriteUpdateSuccessRemoved,
  listFavoriteUpdateFailure,

  listUpdateSuccess,
  listUpdateFailure,
  listRenameLoading,

  listDeleteSuccess,
  listDeleteFailure,
  listDeleteLoading,

  listAddToCartSuccess,
  listAddToCartPartialSuccess,
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
