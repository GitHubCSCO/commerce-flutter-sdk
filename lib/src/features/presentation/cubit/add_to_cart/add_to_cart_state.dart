abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final String addToCartMsg;
  AddToCartSuccess({required this.addToCartMsg});
}

class AddToCartInvalidPrice extends AddToCartState {
  final String errorResponse;
  AddToCartInvalidPrice({required this.errorResponse});
}

class AddToCartFailure extends AddToCartState {
  final String errorResponse;
  AddToCartFailure({required this.errorResponse});
}

class AddToCartEnable extends AddToCartState {
  final bool canAddToCart;
  AddToCartEnable({required this.canAddToCart});
}

class AddToCartButtonLoading extends AddToCartState {}
