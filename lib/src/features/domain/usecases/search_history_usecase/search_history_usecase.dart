import 'package:commerce_flutter_sdk/src/core/constants/cache_service_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';

class SearchHistoryUseCase extends BaseUseCase {
  //TODO we  need to place this someplace else so anyone can modify without effecting the core codebase
  int searchQueryHistoryCount = 5;

  SearchHistoryUseCase() : super();

  Future<List<String>> getSearchHistory() async {
    try {
      final List<String>? list = await commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData<List<String>>(CacheServiceConstants.searchHistory);

      return list ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<void> addSearchHistory(String query) async {
    List<String>? list = [];

    try {
      list = await commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData<List<String>>(CacheServiceConstants.searchHistory);
    } catch (e) {
      list = [];
    } finally {
      list?.removeWhere((q) => q.toLowerCase() == query.toLowerCase());
      list?.insert(0, query);
      var max = list?.length.clamp(0, searchQueryHistoryCount) ?? 0;
      list = list?.sublist(0, max);
      await commerceAPIServiceProvider
          .getCacheService()
          .persistData<List<String>>(
              CacheServiceConstants.searchHistory, list ?? []);
    }
  }
}
