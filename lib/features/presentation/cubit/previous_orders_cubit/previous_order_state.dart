import 'package:commerce_flutter_app/features/domain/entity/previous_orders_data_entity.dart';

abstract class PreviousOrdersState {}

class PreviousOrdersInitialState extends PreviousOrdersState {}

class PreviousOrdersLoadingState extends PreviousOrdersState {}

class PreviousOrdersLoadedState extends PreviousOrdersState {
  final PreviousOrdersDataEntity previousOrdersDataEntity;

  PreviousOrdersLoadedState({
    required this.previousOrdersDataEntity,
  });
}

class PreviousOrdersFailureState extends PreviousOrdersState {}
