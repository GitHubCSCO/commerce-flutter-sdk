import 'package:commerce_flutter_sdk/features/domain/entity/availability_entity.dart';

class InventoryWarehouseEntity extends AvailabilityEntity {
  final String? name;
  final String? description;
  final num? qty;

  const InventoryWarehouseEntity({
    final int? messageType,
    final String? message,
    final bool? requiresRealTimeInventory,
    this.description,
    this.name,
    this.qty,
  }) : super(
            message: message,
            messageType: messageType,
            requiresRealTimeInventory: requiresRealTimeInventory);

  @override
  InventoryWarehouseEntity copyWith({
    int? messageType,
    String? message,
    bool? requiresRealTimeInventory,
    String? name,
    String? description,
    num? qty,
  }) {
    return InventoryWarehouseEntity(
      messageType: messageType ?? this.messageType,
      message: message ?? this.message,
      requiresRealTimeInventory:
          requiresRealTimeInventory ?? this.requiresRealTimeInventory,
      name: name ?? this.name,
      description: description ?? this.description,
      qty: qty ?? this.qty,
    );
  }
}
