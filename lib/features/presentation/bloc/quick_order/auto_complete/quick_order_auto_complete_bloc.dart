import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quick_order_auto_complete_event.dart';
part 'quick_order_auto_complete_state.dart';

class QuickOrderAutoCompleteBloc extends Bloc<QuickOrderAutoCompleteEvent, QuickOrderAutoCompleteState> {

  final SearchUseCase _searchUseCase;

  String searchQuery = "";
  bool isSearchProductActive = false;

  QuickOrderAutoCompleteBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(QuickOrderAutoCompleteInitialState()) {
    on<QuickOrderFocusEvent>(_onSearchFocusEvent);
    on<QuickOrderTypingEvent>(_onSearchTypingEvent);
    on<QuickOrderUnFocusEvent>(_onSearchUnFocusEvent);
  }

  Future<void> _onSearchFocusEvent(QuickOrderFocusEvent event, Emitter<QuickOrderAutoCompleteState> emit) async {
    if (searchQuery.isEmpty) {
      emit(QuickOrderAutoCompleteInitialState());
    } else {
      emit(QuickOrderAutoCompleteLoadingState());
      final result = await _searchUseCase.loadAutocompleteResults(searchQuery);
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
      final result = await _searchUseCase.loadAutocompleteResults(searchQuery);
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
      // emit(SearchCmsInitialState());
    }
  }

}
