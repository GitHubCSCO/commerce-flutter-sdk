import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final SearchUseCase _searchUseCase;

  SearchPageBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(SearchPageInitialState()) {
    on<SearchPageLoadEvent>(_onSearchPageLoadEvent);
  }

  Future<void> _onSearchPageLoadEvent(
      SearchPageLoadEvent event, Emitter<SearchPageState> emit) async {
    var result = await _searchUseCase.loadData();
    switch (result) {
      case Success(value: final data):
        emit(SearchPageLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        emit(SearchPageFailureState(errorResponse.errorDescription ?? ''));
    }
  }

}
