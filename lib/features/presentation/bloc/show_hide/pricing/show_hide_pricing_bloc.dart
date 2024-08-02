import 'package:commerce_flutter_app/features/domain/usecases/show_hide_pricing_inventory_usecase/show_hide_pricing_inventory_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_hide_pricing_event.dart';
part 'show_hide_pricing_state.dart';

class ShowHidePricingBloc
    extends Bloc<ShowHidePricingEvent, ShowHidePricingState> {
  final ShowHidePricingInventoryUseCase _showHidePricingInventoryUseCase;

  ShowHidePricingBloc(
      {required ShowHidePricingInventoryUseCase
          showHidePricingInventoryUseCase})
      : _showHidePricingInventoryUseCase = showHidePricingInventoryUseCase,
        super(const ShowHidePricingInitial(false)) {
    on<ShowHidePricingToggled>((event, emit) {
      _showHidePricingInventoryUseCase.setHidePricingEnable(event.value);
      emit(ShowHidePricingChanged(event.value));
    });
  }
}
