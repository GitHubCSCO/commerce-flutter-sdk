import 'dart:async';
import 'dart:math';

import 'package:commerce_flutter_app/features/domain/service/interfaces/search_history_service_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchHistoryService implements ISearchHistoryService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;

  static const String _searchQueryHistoryCacheKey = "search_query_history";
  static const int _itemsCountDefaultValue = 5;
  static const int _itemsCountMaxValue = 10;

  int _searchQueryHistoryCount = _itemsCountDefaultValue;
  @override
  int get searchQueryHistoryCount => _searchQueryHistoryCount;
  @override
  set searchQueryHistoryCount(int value) {
    if (0 <= value && value <= _itemsCountMaxValue) {
      _searchQueryHistoryCount = value;
    }
  }

  SearchHistoryService(
      {required ICommerceAPIServiceProvider commerceAPIServiceProvider})
      : _commerceAPIServiceProvider = commerceAPIServiceProvider;

  @override
  Future<List<String>> loadSearchQueryHistory() async {
    try {
      var historyList = await _commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData(_searchQueryHistoryCacheKey);

      historyList ??= [];
      int listLength = historyList.length;
      historyList =
          historyList.sublist(0, min(listLength, _searchQueryHistoryCount));
      return historyList;
    } catch (e) {
      print('Failed to load search query history: $e');
      return [];
    }
  }

  @override
  Future<void> persistSearchQuery(String searchQuery) async {
    List<String> historyList = [];
    try {
      searchQuery = searchQuery?.trim() ?? '';
      historyList = await _commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData(_searchQueryHistoryCacheKey);
      historyList ??= [];
      historyList.removeWhere(
          (query) => query.toLowerCase() == searchQuery.toLowerCase());
      historyList.insert(0, searchQuery);
      int listLength = historyList.length;
      historyList =
          historyList.sublist(0, min(listLength, _searchQueryHistoryCount));
    } catch (e) {
      print('Failed to load search query history: $e');
      // If there's an exception, we initialize historyList with the new search query
      historyList = [searchQuery];
    } finally {
      // Persist data in the finally block, so it's always executed
      await _commerceAPIServiceProvider
          .getCacheService()
          .persistData(_searchQueryHistoryCacheKey, historyList);
    }
  }
}
