import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/usecases/root_usecase/root_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final RootUsecase _rootUsecase;
  RootBloc({
    required RootUsecase rootUsecase,
  })  : _rootUsecase = rootUsecase,
        super(RootInitial()) {
    on<RootInitialEvent>((event, emit) {
      emit(RootInitial());
    });
    on<RootHidePricingInventoryEvent>((event, emit) {
      emit(RootPricingInventoryReload());
    });
    on<RootConfigChangeEvent>((event, emit) {
      emit(RootConfigReload());
    });
    on<RootCartUpdateEvent>((event, emit) {
      emit(RootCartReload());
    });
    on<RootInitiateSearchEvent>((event, emit) {
      emit(RootInitiateSearch(event.query));
    });
    on<RootSearchProductEvent>((event, emit) {
      emit(RootSearchProduct(event.query));
    });
    on<RootAnalyticsEvent>((event, emit) {
      _rootUsecase.trackEvent(event.analyticsEvent).ignore();
    });
  }
}
