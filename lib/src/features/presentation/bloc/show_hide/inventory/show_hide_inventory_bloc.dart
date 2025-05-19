import 'package:commerce_flutter_sdk/src/features/domain/usecases/show_hide_pricing_inventory_usecase/show_hide_pricing_inventory_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_hide_inventory_event.dart';
part 'show_hide_inventory_state.dart';

class ShowHideInventoryBloc
    extends Bloc<ShowHideInventoryEvent, ShowHideInventoryState> {
  final ShowHidePricingInventoryUseCase _showHidePricingInventoryUseCase;

  ShowHideInventoryBloc(
      {required ShowHidePricingInventoryUseCase
          showHidePricingInventoryUseCase})
      : _showHidePricingInventoryUseCase = showHidePricingInventoryUseCase,
        super(const ShowHideInventoryInitial(false)) {
    on<ShowHideInventoryToggled>((event, emit) {
      _showHidePricingInventoryUseCase.setHideInventoryEnable(event.value);
      emit(ShowHideInventoryChanged(event.value));
    });
  }
}
