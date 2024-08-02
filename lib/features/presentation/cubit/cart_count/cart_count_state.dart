import 'package:equatable/equatable.dart';

abstract class CountState extends Equatable {
  final int cartItemCount;

  const CountState({required this.cartItemCount});
}

class CountInitialState extends CountState {
  const CountInitialState({required super.cartItemCount});

  @override
  List<Object?> get props => [];
}

class CartCountState extends CountState {
  final DateTime timestamp;

  const CartCountState({required super.cartItemCount, required this.timestamp});

  @override
  List<Object?> get props => [timestamp];
}

class CartTabReloadState extends CountState {
  final DateTime timestamp;

  const CartTabReloadState(
      {required this.timestamp, required super.cartItemCount});

  @override
  List<Object?> get props => [timestamp];
}
