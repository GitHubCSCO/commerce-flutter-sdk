part of 'count_inventory_cubit.dart';

abstract class CountInventoryState {}

class CountInventoryInitial extends CountInventoryState {}

class CountInventoryAlert extends CountInventoryState {

  final String message;

  CountInventoryAlert(this.message);

}

class CountInventorySuccess extends CountInventoryState {

  final int qty;

  CountInventorySuccess(this.qty);

}

