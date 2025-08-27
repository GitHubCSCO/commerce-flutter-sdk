enum OrderStatus {
  initial,
  loading,
  moreLoading,
  success,
  failure,
  moreLoadingFailure,

  reorderLoading,
  reorderSuccess,
  reorderFailure,

  deleteCartSuccess,
  deleteCartLoading,
  deleteCartFailure,
  addToCartSuccess,
  addToCartLoading,
  addToCartFailure,

  lineItemAddToCartLoading,
  lineItemAddToCartQtyAdjusted,
  lineItemAddToCartComplete,

  cancelOrderSuccess,
  cancelOrderFailure,
}
