part of 'cart_page_bloc.dart';

abstract class CartPageEvent {}

class CartPageLoadEvent extends CartPageEvent {
  bool trackScreen;

  CartPageLoadEvent({this.trackScreen = false});
}

class CartPagePickUpLocationChangeEvent extends CartPageEvent {
  final Warehouse wareHouse;

  CartPagePickUpLocationChangeEvent(this.wareHouse);
}

class CartPageCheckoutEvent extends CartPageEvent {}
