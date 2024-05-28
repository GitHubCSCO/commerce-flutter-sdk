import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/usecases/location_search_usecase/location_search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LoactionSearchState> {
  final LocationSearchUseCase _locationSearchUseCase;

  String searchQuery = "";
  bool isSearchProductActive = false;

  LocationSearchBloc({required LocationSearchUseCase locationSearchUseCase})
      : _locationSearchUseCase = locationSearchUseCase,
        super(LocationSearchInitialState()) {
    on<LocationSearchFocusEvent>(_onLocationSearchFocusEvent);
    on<LocationSearchLoadEvent>(_onLocationSearchLoadEvent);
    on<LocationSearchInitialEvent>(_onLocationSearchInitialEvent);
    on<LocationSeachHistoryLoadEvent>(_onLoadLocationSearchHistory);
  }

  Future<void> _onLocationSearchFocusEvent(
      LocationSearchFocusEvent event, Emitter<LoactionSearchState> emit) async {
    emit(LocationSearchFocusState());
  }

  Future<void> _onLocationSearchLoadEvent(
      LocationSearchLoadEvent event, Emitter<LoactionSearchState> emit) async {
    emit(LocationSearchLoadingState());
    var response =
        await _locationSearchUseCase.getSearchedLocation(event.searchQuery);
    await _locationSearchUseCase.persistSearchQuery(event.searchQuery);
    if (response == null) {
      emit(LocationSearchFailureState());
      return;
    } else {
      emit(LocationSearchLoadedState(
        pageType: "",
        searchedLocation: response,
      ));
    }
  }

  Future<void> _onLocationSearchInitialEvent(LocationSearchInitialEvent event,
      Emitter<LoactionSearchState> emit) async {
    emit(LocationSearchInitialState());
  }

  Future<void> _onLoadLocationSearchHistory(LocationSeachHistoryLoadEvent event,
      Emitter<LoactionSearchState> emit) async {
    var response = await _locationSearchUseCase.loadSearchQueryHistory();

    emit(LocationSearchHistoryLoadedState(searchHistory: response));
  }
}
