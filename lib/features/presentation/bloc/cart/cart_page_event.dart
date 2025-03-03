part of 'cart_page_bloc.dart';

abstract class CartPageEvent {}

class CartPageLoadEvent extends CartPageEvent {}

class CartPagePickUpLocationChangeEvent extends CartPageEvent {
  final Warehouse wareHouse;

  CartPagePickUpLocationChangeEvent(this.wareHouse);
}

class CartPageCheckoutEvent extends CartPageEvent {}
