import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/pagination_entity.dart';

class GetOrderCollectionResultEntity extends Equatable {
  final PaginationEntity? pagination;

  final List<OrderEntity>? orders;

  /// Gets or sets a value indicating whether [show erp order number].
  final bool? showErpOrderNumber;

  const GetOrderCollectionResultEntity({
    required this.pagination,
    required this.orders,
    required this.showErpOrderNumber,
  });

  @override
  List<Object?> get props => [
        pagination,
        orders,
        showErpOrderNumber,
      ];

  GetOrderCollectionResultEntity copyWith({
    PaginationEntity? pagination,
    List<OrderEntity>? orders,
    bool? showErpOrderNumber,
  }) {
    return GetOrderCollectionResultEntity(
      pagination: pagination ?? this.pagination,
      orders: orders ?? this.orders,
      showErpOrderNumber: showErpOrderNumber ?? this.showErpOrderNumber,
    );
  }
}
