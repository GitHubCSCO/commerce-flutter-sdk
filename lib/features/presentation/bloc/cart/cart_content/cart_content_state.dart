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

class CartContentQuantityChangedSuccessState extends CartContentState {
  final String? message;

  const CartContentQuantityChangedSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class CartContentQuantityChangedFailureState extends CartContentState {
  final String message;
  const CartContentQuantityChangedFailureState({required this.message});

  @override
  List<Object?> get props => [];
}

class CartContentClearAllSuccessState extends CartContentState {
  const CartContentClearAllSuccessState();

  @override
  List<Object?> get props => [];
}

class CartContentClearAllFailureState extends CartContentState {
  final String message;

  const CartContentClearAllFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class CartContentItemRemovedSuccessState extends CartContentState {
  const CartContentItemRemovedSuccessState();

  @override
  List<Object?> get props => [];
}

class CartContentItemRemovedFailureState extends CartContentState {
  final String message;

  const CartContentItemRemovedFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
