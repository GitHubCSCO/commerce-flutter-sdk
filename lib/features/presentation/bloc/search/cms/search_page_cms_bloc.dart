import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_cms_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_page_cms_event.dart';
part 'search_page_cms_state.dart';

class SearchPageCmsBloc extends Bloc<SearchPageCmsEvent, SearchPageCmsState> {
  final SearchCmsUseCase _searchUseCase;

  SearchPageCmsBloc({required SearchCmsUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(SearchPageCmsInitialState()) {
    on<SearchPageCmsLoadEvent>(_onSearchPageLoadEvent);
  }

  Future<void> _onSearchPageLoadEvent(
      SearchPageCmsLoadEvent event, Emitter<SearchPageCmsState> emit) async {
    emit(SearchPageCmsLoadingState());
    var result = await _searchUseCase.loadData();
    switch (result) {
      case Success(value: final data):
        emit(SearchPageCmsLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        emit(SearchPageCmsFailureState(errorResponse.errorDescription ?? ''));
    }
  }

}
