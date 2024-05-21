import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/previous_orders_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/order_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/previous_orders_usecase/previous_orders_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/previous_orders_cubit/previous_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PreviousOrdersCubit extends Cubit<PreviousOrdersState> {
  final PreviousOrdersUseCse _previousOrdersUseCse;

  PreviousOrdersCubit({required PreviousOrdersUseCse previousOrdersUseCse})
      : _previousOrdersUseCse = previousOrdersUseCse,
        super(PreviousOrdersInitialState());

  Future<void> loadPreviousOrders() async {
    var response = await _previousOrdersUseCse.getPreviousOrders();
    if (response is Success) {
      List<Order> orders = (response as Success).value as List<Order>;
      List<OrderEntity>? orderEntities = orders.map((order) => OrderEntityMapper.toEntity(order))
          .toList();
      emit(PreviousOrdersLoadedState(
          previousOrdersDataEntity:
              PreviousOrdersDataEntity(orders: orderEntities)));
    } else {
      emit(PreviousOrdersFailureState());
    }
  }
}
