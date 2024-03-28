import 'package:equatable/equatable.dart';

class OrderStatusMappingEntity extends Equatable {
  final String? id;
  final String? erpOrderStatus;
  final String? displayName;
  final bool? isDefault;
  final bool? allowRma;
  final bool? allowCancellation;

  const OrderStatusMappingEntity({
    this.id,
    this.erpOrderStatus,
    this.displayName,
    this.isDefault,
    this.allowRma,
    this.allowCancellation,
  });

  @override
  List<Object?> get props => [
        id,
        erpOrderStatus,
        displayName,
        isDefault,
        allowRma,
        allowCancellation,
      ];

  OrderStatusMappingEntity copyWith({
    String? id,
    String? erpOrderStatus,
    String? displayName,
    bool? isDefault,
    bool? allowRma,
    bool? allowCancellation,
  }) {
    return OrderStatusMappingEntity(
      id: id ?? this.id,
      erpOrderStatus: erpOrderStatus ?? this.erpOrderStatus,
      displayName: displayName ?? this.displayName,
      isDefault: isDefault ?? this.isDefault,
      allowRma: allowRma ?? this.allowRma,
      allowCancellation: allowCancellation ?? this.allowCancellation,
    );
  }
}
