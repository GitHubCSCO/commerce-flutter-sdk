import 'package:equatable/equatable.dart';

class CartCountState extends Equatable {
  final int cartItemCount;

  const CartCountState({required this.cartItemCount});

  @override
  List<Object?> get props => [cartItemCount];
}

class CartTabReloadState extends CartCountState {

  const CartTabReloadState({required super.cartItemCount});
}