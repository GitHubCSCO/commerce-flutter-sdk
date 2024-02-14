import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_query_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_query_event.dart';
part 'search_query_state.dart';

class SearchQueryBloc extends Bloc<SearchQueryEvent, SearchQueryState> {

  final SearchQueryUseCase _searchQueryUseCase;

  String searchQuery = "";
  bool isSearchProductActive = false;

  SearchQueryBloc({required SearchQueryUseCase searchQueryUseCase})
      : _searchQueryUseCase = searchQueryUseCase,
        super(SearchQueryCmsInitialState()) {
    // on<SearchQueryAutoCompleteLoadEvent>(_onSearchQueryAutoCompleteLoadEvent);
    on<SearchQueryFocusEvent>(_onSearchQueryFocusEvent);
    on<SearchQueryTypingEvent>(_onSearchQueryTypingEvent);
    on<SearchQueryUnFocusEvent>(_onSearchQueryUnFocusEvent);
    on<SearchQuerySearchEvent>(_onSearchQuerySearchEvent);
    on<SearchQueryCloseEvent>(_onSearchQueryCloseEvent);
  }

  Future<void> _onSearchQueryAutoCompleteLoadEvent(
      SearchQueryAutoCompleteLoadEvent event, Emitter<SearchQueryState> emit) async {
    var result = await _searchQueryUseCase.loadAutocompleteResults(event.query);
    switch (result) {
      case Success(value: final data):
        emit(SearchQueryAutoCompleteLoadedState(result: data));
      case Failure(errorResponse: final errorResponse):
        emit(SearchQueryAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
      case null:
        // TODO: Handle this case.
    }
  }

  Future<void> _onSearchQueryFocusEvent(SearchQueryFocusEvent event, Emitter<SearchQueryState> emit) async {
    if (searchQuery.isEmpty) {
      emit(SearchQueryAutoCompleteInitialState());
    } else {
      emit(SearchQueryLoadingState());
      final result = await _searchQueryUseCase.loadAutocompleteResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchQueryAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchQueryAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchQueryTypingEvent(SearchQueryTypingEvent event, Emitter<SearchQueryState> emit) async {
    searchQuery = event.searchQuery;
    if (searchQuery.isEmpty) {
      emit(SearchQueryAutoCompleteInitialState());
    } else {
      emit(SearchQueryLoadingState());
      final result = await _searchQueryUseCase.loadAutocompleteResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchQueryAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchQueryAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchQueryUnFocusEvent(SearchQueryUnFocusEvent event, Emitter<SearchQueryState> emit) async {
    if (searchQuery.isEmpty) {
      emit(SearchQueryCmsInitialState());
    }
  }

  Future<void> _onSearchQuerySearchEvent(SearchQuerySearchEvent event, Emitter<SearchQueryState> emit) async {
    if (searchQuery.isNotEmpty) {
      emit(SearchQueryLoadingState());
      final result = await _searchQueryUseCase.loadSearchProductsResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchQueryProductsLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchQueryProductsFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchQueryCloseEvent(SearchQueryCloseEvent event, Emitter<SearchQueryState> emit) async {
    searchQuery = "";
    emit(SearchQueryCmsInitialState());
  }

}
