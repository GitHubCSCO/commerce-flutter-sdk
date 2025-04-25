// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/features/domain/entity/order/order_entity.dart';
import 'package:equatable/equatable.dart';

class PreviousOrdersDataEntity extends Equatable {
  final List<OrderEntity> orders;
  PreviousOrdersDataEntity({
    required this.orders,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  PreviousOrdersDataEntity copyWith({
    List<OrderEntity>? orders,
  }) {
    return PreviousOrdersDataEntity(
      orders: orders ?? this.orders,
    );
  }
}
