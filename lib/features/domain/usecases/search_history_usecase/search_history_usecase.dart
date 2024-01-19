import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchHistoryUseCase {
  final ICacheService _cacheService;

  SearchHistoryUseCase(this._cacheService);

  Future<List<String>> getSearchHistory() async {
    final List<String> list = await _cacheService.loadPersistedData<List<String>>("search_history");
    list.isEmpty ? list.add(LocalizationConstants.SearchNoHistoryAvailable) : null;
    return list;
  }
}