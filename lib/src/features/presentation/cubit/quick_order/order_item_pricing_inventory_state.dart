part of 'order_item_pricing_inventory_cubit.dart';

abstract class OrderItemPricingInventoryState {}

class OrderItemPricingInventoryInitial extends OrderItemPricingInventoryState {}

class OrderItemPricingInventoryLoading extends OrderItemPricingInventoryState {}

class OrderItemPricingInventoryLoaded extends OrderItemPricingInventoryState {}

class OrderItemPricingInventoryFailed extends OrderItemPricingInventoryState {}

class OrderItemSubTotalChange extends OrderItemPricingInventoryState {}
