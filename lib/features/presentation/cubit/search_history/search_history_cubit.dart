import 'package:commerce_flutter_app/features/domain/usecases/search_history_usecase/search_history_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_history_state.dart';

class SearchHistoryCubit extends Cubit<SearchHistoryState> {
  final SearchHistoryUseCase _searchHistoryUseCase;

  SearchHistoryCubit({required SearchHistoryUseCase searchHistoryUseCase})
      : _searchHistoryUseCase = searchHistoryUseCase,
        super(SearchHistoryInitialState());

  Future<void> getSearchHistory() async {
    var result = await _searchHistoryUseCase.getSearchHistory();
    emit(SearchHistoryLoadedState(historyList: result));
  }

}
