import 'package:commerce_flutter_sdk/src/core/constants/cache_service_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';

class SearchHistoryUseCase extends BaseUseCase {
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
      await commerceAPIServiceProvider
          .getCacheService()
          .persistData<List<String>>(
              CacheServiceConstants.searchHistory, list ?? []);
    }
  }
}
