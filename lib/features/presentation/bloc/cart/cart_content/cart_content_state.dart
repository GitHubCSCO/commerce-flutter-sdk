import 'package:equatable/equatable.dart';

abstract class CartContentState extends Equatable {
  const CartContentState();
}

class CartContentLoadingState extends CartContentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CartContentDefaultState extends CartContentState {
  @override
  List<Object?> get props => [];
}

class CartContentQuantityChangedState extends CartContentState {
  final int quantity;

  CartContentQuantityChangedState(this.quantity);

  @override
  List<Object?> get props => [quantity];
}

class CartContentClearAllSuccessState extends CartContentState {
  CartContentClearAllSuccessState();

  @override
  List<Object?> get props => [];
}

class CartContentClearAllFailureState extends CartContentState {
  final String message;

  CartContentClearAllFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class CartContentItemRemovedSuccessState extends CartContentState {
  CartContentItemRemovedSuccessState();

  @override
  List<Object?> get props => [];
}

class CartContentItemRemovedFailureState extends CartContentState {
  final String message;

  CartContentItemRemovedFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
