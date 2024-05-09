import 'package:flutter_bloc/flutter_bloc.dart';

part 'quick_order_event.dart';
part 'quick_order_state.dart';

class QuickOrderBloc extends Bloc<QuickOrderEvent, QuickOrderState> {
  QuickOrderBloc() : super(QuickOrderInitialState()) {
    on<QuickOrderStartSearchEvent>((event, emit) => _onStartSearchEvent(event, emit));
    on<QuickOrderEndSearchEvent>((event, emit) => _onEndSearchEvent(event, emit));
  }

  Future<void> _onStartSearchEvent(
      QuickOrderStartSearchEvent event, Emitter<QuickOrderState> emit) async {
    emit(AutoCompleteInitialState());
  }

  Future<void> _onEndSearchEvent(
      QuickOrderEndSearchEvent event, Emitter<QuickOrderState> emit) async {
    emit(QuickOrderInitialState());
  }

}
