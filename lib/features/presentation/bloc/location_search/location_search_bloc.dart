import 'package:commerce_flutter_app/features/domain/usecases/location_search_usecase/location_search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LoactionSearchState> {
  final LocationSearchUseCase _locationSearchUseCase;

  String searchQuery = "";
  bool isSearchProductActive = false;

  LocationSearchBloc({required LocationSearchUseCase locationSearchUseCase})
      : _locationSearchUseCase = locationSearchUseCase,
        super(LocationSearchInitialState()) {
    on<LocationSearchFocusEvent>(_onLocationSearchFocusEvent);
  }

  Future<void> _onLocationSearchFocusEvent(
      LocationSearchFocusEvent event, Emitter<LoactionSearchState> emit) async {
    emit(LocationSearchFocusState());
  }
}
