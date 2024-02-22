import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final SearchUseCase _searchUseCase;

  String searchQuery = "";
  bool isSearchProductActive = false;

  SearchBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(SearchCmsInitialState()) {
    // on<SearchAutoCompleteLoadEvent>(_onSearchAutoCompleteLoadEvent);
    on<SearchFocusEvent>(_onSearchFocusEvent);
    on<SearchTypingEvent>(_onSearchTypingEvent);
    on<SearchUnFocusEvent>(_onSearchUnFocusEvent);
    on<SearchSearchEvent>(_onSearchSearchEvent);
    on<SearchCloseEvent>(_onSearchCloseEvent);
  }

  Future<void> _onSearchAutoCompleteLoadEvent(
      SearchAutoCompleteLoadEvent event, Emitter<SearchState> emit) async {
    var result = await _searchUseCase.loadAutocompleteResults(event.query);
    switch (result) {
      case Success(value: final data):
        emit(SearchAutoCompleteLoadedState(result: data));
      case Failure(errorResponse: final errorResponse):
        emit(SearchAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
      case null:
        // TODO: Handle this case.
    }
  }

  Future<void> _onSearchFocusEvent(SearchFocusEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isEmpty) {
      emit(SearchAutoCompleteInitialState());
    } else {
      emit(SearchLoadingState());
      final result = await _searchUseCase.loadAutocompleteResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchTypingEvent(SearchTypingEvent event, Emitter<SearchState> emit) async {
    searchQuery = event.searchQuery;
    if (searchQuery.isEmpty) {
      emit(SearchAutoCompleteInitialState());
    } else {
      emit(SearchLoadingState());
      final result = await _searchUseCase.loadAutocompleteResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchUnFocusEvent(SearchUnFocusEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isEmpty) {
      emit(SearchCmsInitialState());
    }
  }

  Future<void> _onSearchSearchEvent(SearchSearchEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isNotEmpty) {
      emit(SearchLoadingState());
      final result = await _searchUseCase.loadSearchProductsResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchProductsLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchProductsFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchCloseEvent(SearchCloseEvent event, Emitter<SearchState> emit) async {
    searchQuery = "";
    emit(SearchCmsInitialState());
  }

}
