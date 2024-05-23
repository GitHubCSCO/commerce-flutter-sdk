import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/settings/order_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderUsecase _orderUsecase;
  OrderDetailsCubit({required OrderUsecase orderUsercase})
      : _orderUsecase = orderUsercase,
        super(
          const OrderDetailsState(
            order: OrderEntity(),
            isReorderViewVisible: false,
            orderStatus: OrderStatus.initial,
            orderSettings: OrderSettingsEntity(),
          ),
        );

  Future<void> loadOrderDetails(String orderNumber) async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));

    final futureResults = await Future.wait([
      _orderUsecase.loadOrder(orderNumber),
      _orderUsecase.loadOrderSettings(),
    ]);

    final order = futureResults[0] as OrderEntity?;
    final orderSettings = futureResults[1] as OrderSettingsEntity?;

    if (order == null || orderSettings == null) {
      emit(state.copyWith(orderStatus: OrderStatus.failure));
    } else {
      emit(
        state.copyWith(
          order: order,
          orderSettings: orderSettings,
          orderStatus: OrderStatus.success,
        ),
      );
    }
  }
}
