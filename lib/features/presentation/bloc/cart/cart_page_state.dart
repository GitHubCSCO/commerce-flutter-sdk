part of 'cart_page_bloc.dart';

abstract class CartPageState {}

class CartPageInitialState extends CartPageState {}

class CartPageLoadingState extends CartPageState {}

class CartPageLoadedState extends CartPageState {

  final Cart cart;
  final Warehouse warehouse;

  CartPageLoadedState({required this.cart, required this.warehouse});

}

class CartPageFailureState extends CartPageState {

  final String error;

  CartPageFailureState({required this.error});

}
