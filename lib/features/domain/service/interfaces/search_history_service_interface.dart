abstract class ISearchHistoryService {
  
  int get searchQueryHistoryCount;
  set searchQueryHistoryCount(int count);

  Future<void> persistSearchQuery(String searchQuery);

  Future<List<String>> loadSearchQueryHistory();
}