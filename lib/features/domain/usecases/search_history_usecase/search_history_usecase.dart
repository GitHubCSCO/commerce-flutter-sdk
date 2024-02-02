import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class SearchHistoryUseCase extends BaseUseCase {
  SearchHistoryUseCase() : super();

  Future<List<String>> getSearchHistory() async {
    try {
      final List<String> list = await commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData<List<String>>("search_history");

      list.isEmpty
          ? list.add(LocalizationConstants.searchNoHistoryAvailable)
          : null;

      return list;
    } catch (e) {
      return [LocalizationConstants.searchNoHistoryAvailable];
    }
  }
}
