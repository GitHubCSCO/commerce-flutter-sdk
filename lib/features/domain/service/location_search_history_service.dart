import 'package:commerce_flutter_sdk/features/domain/service/interfaces/location_search_history_service.dart';
import 'package:commerce_flutter_sdk/features/domain/service/search_history_service.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LocationSearchHistoryService extends SearchHistoryService
    implements ILocationSearchHistoryService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;

  static const String _locationSearchQueryHistoryCacheKey =
      "location_search_query_history";

  int _searchQueryHistoryCount = 0;

  @override
  int get searchQueryHistoryCount => _searchQueryHistoryCount;

  @override
  set searchQueryHistoryCount(int value) => _searchQueryHistoryCount = value;

  LocationSearchHistoryService({required super.commerceAPIServiceProvider})
      : _commerceAPIServiceProvider = commerceAPIServiceProvider;

  @override
  Future<void> clearHistory() async {
    await _commerceAPIServiceProvider
        .getCacheService()
        .persistData(_locationSearchQueryHistoryCacheKey, []);
  }
}
