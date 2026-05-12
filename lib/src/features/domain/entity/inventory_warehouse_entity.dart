import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';

class InventoryWarehouseEntity extends AvailabilityEntity {
  final String? id;
  final String? name;
  final String? description;
  final num? qtyAvailable;

  const InventoryWarehouseEntity({
    final int? messageType,
    final String? message,
    final bool? requiresRealTimeInventory,
    this.id,
    this.description,
    this.name,
    this.qtyAvailable,
  }) : super(
            message: message,
            messageType: messageType,
            requiresRealTimeInventory: requiresRealTimeInventory);

  @override
  List<Object?> get props => [
        ...super.props,
        id,
        name,
        description,
        qtyAvailable,
      ];

  @override
  InventoryWarehouseEntity copyWith({
    int? messageType,
    String? message,
    bool? requiresRealTimeInventory,
    String? id,
    String? name,
    String? description,
    num? qtyAvailable,
  }) {
    return InventoryWarehouseEntity(
      messageType: messageType ?? this.messageType,
      message: message ?? this.message,
      requiresRealTimeInventory:
          requiresRealTimeInventory ?? this.requiresRealTimeInventory,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      qtyAvailable: qtyAvailable ?? this.qtyAvailable,
    );
  }
}
