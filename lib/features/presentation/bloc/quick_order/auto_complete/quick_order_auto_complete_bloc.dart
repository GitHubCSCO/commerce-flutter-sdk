import 'package:commerce_flutter_app/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quick_order_auto_complete_event.dart';
part 'quick_order_auto_complete_state.dart';

class QuickOrderAutoCompleteBloc extends Bloc<QuickOrderAutoCompleteEvent, QuickOrderAutoCompleteState> {

  final SearchUseCase _searchUseCase;
  final ScanningMode _scanningMode;

  String searchQuery = "";
  bool isSearchProductActive = false;

  QuickOrderAutoCompleteBloc(
      {required SearchUseCase searchUseCase,
      required ScanningMode scanningMode})
      : _searchUseCase = searchUseCase,
        _scanningMode = scanningMode,
        super(QuickOrderInitialState()) {
    on<QuickOrderStartSearchEvent>((event, emit) => _onStartSearchEvent(event, emit));
    on<QuickOrderEndSearchEvent>((event, emit) => _onEndSearchEvent(event, emit));
    on<QuickOrderFocusEvent>(_onSearchFocusEvent);
    on<QuickOrderTypingEvent>(_onSearchTypingEvent);
    on<QuickOrderUnFocusEvent>(_onSearchUnFocusEvent);
  }

  Future<void> _onStartSearchEvent(
      QuickOrderStartSearchEvent event, Emitter<QuickOrderAutoCompleteState> emit) async {
    emit(QuickOrderAutoCompleteInitialState());
  }

  Future<void> _onEndSearchEvent(
      QuickOrderEndSearchEvent event, Emitter<QuickOrderAutoCompleteState> emit) async {
    emit(QuickOrderInitialState());
  }

  Future<void> _onSearchFocusEvent(QuickOrderFocusEvent event, Emitter<QuickOrderAutoCompleteState> emit) async {
    if (searchQuery.isEmpty) {
      emit(QuickOrderAutoCompleteInitialState());
    } else {
      emit(QuickOrderAutoCompleteLoadingState());
      final result = await loadAutoCompleteProducts();
      switch (result) {
        case Success(value: final data):
          emit(QuickOrderAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(QuickOrderAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchTypingEvent(QuickOrderTypingEvent event, Emitter<QuickOrderAutoCompleteState> emit) async {
    searchQuery = event.quickOrderQuery;
    if (searchQuery.isEmpty) {
      emit(QuickOrderAutoCompleteInitialState());
    } else {
      emit(QuickOrderAutoCompleteLoadingState());
      final result = await loadAutoCompleteProducts();
      switch (result) {
        case Success(value: final data):
          emit(QuickOrderAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(QuickOrderAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchUnFocusEvent(QuickOrderUnFocusEvent event, Emitter<QuickOrderAutoCompleteState> emit) async {
    if (searchQuery.isEmpty) {
      emit(QuickOrderInitialState());
    }
  }

  Future<Result<AutocompleteResult, ErrorResponse>?> loadAutoCompleteProducts() async {
    if (_scanningMode == ScanningMode.count) {
      return await _searchUseCase.loadVmiAutocompleteResults(searchQuery);
    } else if (_scanningMode == ScanningMode.create) {
      return await _searchUseCase.loadAutocompleteResults(searchQuery);
    } else {
      return await _searchUseCase.loadAutocompleteResults(searchQuery);
    }
  }

}
