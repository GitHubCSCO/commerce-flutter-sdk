part of 'order_return_cubit.dart';

abstract class OrderReturnState {}

class OrderReturnInitial extends OrderReturnState {}

class OrderReturnLoaded extends OrderReturnState {}

class OrderReturnSuccess extends OrderReturnState {}

class OrderReturnFailure extends OrderReturnState {}

class OrderReturnEnable extends OrderReturnState {
  final bool isEnabled;

  OrderReturnEnable(this.isEnabled);
}
