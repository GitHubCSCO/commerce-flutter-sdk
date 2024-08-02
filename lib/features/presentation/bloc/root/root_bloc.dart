import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc() : super(RootInitial()) {
    on<RootInitialEvent>((event, emit) {
      emit(RootInitial());
    });
    on<RootHidePricingInventoryEvent>((event, emit) {
      emit(RootPricingInventoryReload());
    });
    on<RootConfigChangeEvent>((event, emit) {
      emit(RootConfigReload());
    });
  }
}
