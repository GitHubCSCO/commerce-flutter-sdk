import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/search_history_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCacheService extends Mock implements ICacheService {}

void main() {
  late SearchHistoryService searchHistoryService;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCacheService mockCacheService;

  setUp(() {
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCacheService = MockCacheService();
    when(() => mockCommerceAPIServiceProvider.getCacheService())
        .thenReturn(mockCacheService);

    searchHistoryService = SearchHistoryService(
        commerceAPIServiceProvider: mockCommerceAPIServiceProvider);
  });

  group('SearchHistoryService', () {
    test('initializes with default history count value', () {
      expect(searchHistoryService.searchQueryHistoryCount, 5);
    });

    test('setting history count with valid values works', () {
      searchHistoryService.searchQueryHistoryCount = 7;
      expect(searchHistoryService.searchQueryHistoryCount, 7);

      searchHistoryService.searchQueryHistoryCount = 0;
      expect(searchHistoryService.searchQueryHistoryCount, 0);

      searchHistoryService.searchQueryHistoryCount = 10;
      expect(searchHistoryService.searchQueryHistoryCount, 10);
    });

    test('setting history count with invalid values has no effect', () {
      searchHistoryService.searchQueryHistoryCount = 5;

      searchHistoryService.searchQueryHistoryCount = -1;
      expect(searchHistoryService.searchQueryHistoryCount, 5);

      searchHistoryService.searchQueryHistoryCount = 11;
      expect(searchHistoryService.searchQueryHistoryCount, 5);
    });

    group('loadSearchQueryHistory', () {
      test('loads and limits history to searchQueryHistoryCount', () async {
        // Setup
        final mockHistory = [
          'query1',
          'query2',
          'query3',
          'query4',
          'query5',
          'query6',
          'query7'
        ];
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenAnswer((_) async => mockHistory);

        searchHistoryService.searchQueryHistoryCount = 3;

        // Execute
        final result = await searchHistoryService.loadSearchQueryHistory();

        // Verify
        expect(result, ['query1', 'query2', 'query3']);
        verify(() => mockCacheService
            .loadPersistedData<List<String>>("search_query_history")).called(1);
      });

      test('returns empty list when cache service throws an exception',
          () async {
        // Setup
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenThrow(Exception('Cache error'));

        // Execute
        final result = await searchHistoryService.loadSearchQueryHistory();

        // Verify
        expect(result, []);
      });
    });

    group('persistSearchQuery', () {
      test('persists new query at the beginning of history list', () async {
        // Setup
        final existingHistory = ['query1', 'query2', 'query3'];
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenAnswer((_) async => existingHistory);
        when(() => mockCacheService.persistData<List<String>>(
            "search_query_history", any())).thenAnswer((_) async => true);

        // Execute
        await searchHistoryService.persistSearchQuery('new query');

        // Verify
        verify(() => mockCacheService.persistData<List<String>>(
            "search_query_history",
            ['new query', 'query1', 'query2', 'query3'])).called(1);
      });

      test('removes duplicate queries', () async {
        // Setup
        final existingHistory = ['query1', 'query2', 'query3'];
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenAnswer((_) async => existingHistory);
        when(() => mockCacheService.persistData<List<String>>(
            "search_query_history", any())).thenAnswer((_) async => true);

        // Execute
        await searchHistoryService
            .persistSearchQuery('QUERY2'); // Case insensitive check

        // Verify
        verify(() => mockCacheService.persistData<List<String>>(
            "search_query_history", ['QUERY2', 'query1', 'query3'])).called(1);
      });

      test('limits history list to searchQueryHistoryCount', () async {
        // Setup
        final existingHistory = [
          'query1',
          'query2',
          'query3',
          'query4',
          'query5'
        ];
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenAnswer((_) async => existingHistory);
        when(() => mockCacheService.persistData<List<String>>(
            "search_query_history", any())).thenAnswer((_) async => true);

        searchHistoryService.searchQueryHistoryCount = 3;

        // Execute
        await searchHistoryService.persistSearchQuery('new query');

        // Verify
        verify(() => mockCacheService.persistData<List<String>>(
                "search_query_history", ['new query', 'query1', 'query2']))
            .called(1);
      });

      test('handles exception when loading history', () async {
        // Setup
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenThrow(Exception('Cache error'));
        when(() => mockCacheService.persistData<List<String>>(
            "search_query_history", any())).thenAnswer((_) async => true);

        // Execute
        await searchHistoryService.persistSearchQuery('new query');

        // Verify - should still persist the new query
        verify(() => mockCacheService.persistData<List<String>>(
            "search_query_history", ['new query'])).called(1);
      });

      test('trims search query', () async {
        // Setup
        final existingHistory = ['query1', 'query2', 'query3'];
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenAnswer((_) async => existingHistory);
        when(() => mockCacheService.persistData<List<String>>(
            "search_query_history", any())).thenAnswer((_) async => true);

        // Execute
        await searchHistoryService.persistSearchQuery('  new query  ');

        // Verify
        verify(() => mockCacheService.persistData<List<String>>(
            "search_query_history",
            ['new query', 'query1', 'query2', 'query3'])).called(1);
      });

      test('handles null search query', () async {
        // Setup
        final existingHistory = ['query1', 'query2', 'query3'];
        when(() => mockCacheService.loadPersistedData<List<String>>(
            "search_query_history")).thenAnswer((_) async => existingHistory);
        when(() => mockCacheService.persistData<List<String>>(
            "search_query_history", any())).thenAnswer((_) async => true);

        // Execute
        await searchHistoryService.persistSearchQuery(null);

        // Verify
        verify(() => mockCacheService.persistData<List<String>>(
                "search_query_history", ['', 'query1', 'query2', 'query3']))
            .called(1);
      });
    });
  });
}
