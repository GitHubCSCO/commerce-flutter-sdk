import 'package:commerce_flutter_app/core/constants/cache_service_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class SearchHistoryUseCase extends BaseUseCase {
  SearchHistoryUseCase() : super();

  Future<List<String>> getSearchHistory() async {
    try {
      final List<String>? list = await commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData<List<String>>(CacheServiceConstants.searchHistory);
      if (list != null) {
        list.isEmpty
            ? list
                .add(LocalizationConstants.searchNoHistoryAvailable.localized())
            : null;
      }

      return list ?? [];
    } catch (e) {
      return [LocalizationConstants.searchNoHistoryAvailable.localized()];
    }
  }

  Future<void> addSearchHistory(String query) async {
    List<String>? list = [];

    try {
      list = await commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData<List<String>>(CacheServiceConstants.searchHistory);
    } finally {
      list?.add(query);

      await commerceAPIServiceProvider
          .getCacheService()
          .persistData<List<String>>(
              CacheServiceConstants.searchHistory, list ?? []);
    }
  }
}
