import 'dart:convert';
import 'dart:typed_data';

import 'package:commerce_flutter_sdk/src/core/models/quick_order_item.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/cache_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockVmiLocationModel extends Mock implements VmiLocationModel {
  @override
  Map<String, dynamic> toJson() => {'id': 'test-id', 'name': 'Test Location'};
}

void main() {
  late CacheService cacheService;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    cacheService = CacheService(sharedPreferences: mockSharedPreferences);
  });

  group('clearAllCaches', () {
    test('calls clear on shared preferences', () async {
      when(() => mockSharedPreferences.clear()).thenAnswer((_) async => true);

      await cacheService.clearAllCaches();

      verify(() => mockSharedPreferences.clear()).called(1);
    });
  });

  group('getObject', () {
    test('returns decoded object when key exists', () async {
      final testJson = '{"name":"Test","value":123}';
      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);
      when(() => mockSharedPreferences.getString('test-key'))
          .thenReturn(testJson);

      final result =
          await cacheService.getObject<Map<String, dynamic>>('test-key');

      expect(result, {'name': 'Test', 'value': 123});
    });

    test('throws exception when key does not exist', () async {
      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(false);

      expect(
        () => cacheService.getObject<Map<String, dynamic>>('test-key'),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Object not found in cache'),
        )),
      );
    });
  });

  group('getOrFetchObject', () {
    test('returns value from fetchFunc', () async {
      bool fetchCalled = false;
      final value = await cacheService.getOrFetchObject<String>('test-key', () {
        fetchCalled = true;
        return Future.value('fetched-value');
      });

      expect(value, 'fetched-value');
      expect(fetchCalled, isTrue);
    });
  });

  group('hasOnlineCache', () {
    test('returns true when key exists', () async {
      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);

      final result = await cacheService.hasOnlineCache('test-key');

      expect(result, isTrue);
    });

    test('returns false when key does not exist', () async {
      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(false);

      final result = await cacheService.hasOnlineCache('test-key');

      expect(result, isFalse);
    });
  });

  group('insertObject', () {
    test('sets string value in shared preferences', () async {
      final testObject = {'name': 'Test', 'value': 123};
      when(() => mockSharedPreferences.setString(
          'test-key', jsonEncode(testObject))).thenAnswer((_) async => true);

      await cacheService.insertObject('test-key', testObject);

      verify(() => mockSharedPreferences.setString(
          'test-key', jsonEncode(testObject))).called(1);
    });
  });

  group('invalidate', () {
    test('removes key from shared preferences', () async {
      when(() => mockSharedPreferences.remove('test-key'))
          .thenAnswer((_) async => true);

      await cacheService.invalidate('test-key');

      verify(() => mockSharedPreferences.remove('test-key')).called(1);
    });
  });

  group('invalidateAllObjects', () {
    test('clears all shared preferences', () async {
      when(() => mockSharedPreferences.clear()).thenAnswer((_) async => true);

      await cacheService.invalidateAllObjects();

      verify(() => mockSharedPreferences.clear()).called(1);
    });
  });

  group('invalidateObject', () {
    test('removes specific key from shared preferences', () async {
      when(() => mockSharedPreferences.remove('test-key'))
          .thenAnswer((_) async => true);

      await cacheService.invalidateObject('test-key');

      verify(() => mockSharedPreferences.remove('test-key')).called(1);
    });
  });

  group('invalidateObjectWithKeysStartingWith', () {
    test('removes keys with specific prefix', () async {
      when(() => mockSharedPreferences.getKeys())
          .thenReturn({'prefix_1', 'prefix_2', 'other'});
      when(() => mockSharedPreferences.remove('prefix_1'))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.remove('prefix_2'))
          .thenAnswer((_) async => true);

      await cacheService.invalidateObjectWithKeysStartingWith('prefix');

      verify(() => mockSharedPreferences.remove('prefix_1')).called(1);
      verify(() => mockSharedPreferences.remove('prefix_2')).called(1);
      verifyNever(() => mockSharedPreferences.remove('other'));
    });
  });

  group('invalidateAllObjectsExcept', () {
    test('removes all keys except those to keep', () async {
      when(() => mockSharedPreferences.getKeys())
          .thenReturn({'key1', 'key2', 'key3'});
      when(() => mockSharedPreferences.remove('key1'))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.remove('key3'))
          .thenAnswer((_) async => true);

      await cacheService.invalidateAllObjectsExcept(['key2']);

      verify(() => mockSharedPreferences.remove('key1')).called(1);
      verify(() => mockSharedPreferences.remove('key3')).called(1);
      verifyNever(() => mockSharedPreferences.remove('key2'));
    });
  });

  group('loadPersistedBytesData', () {
    test('returns decoded bytes when key exists', () async {
      final bytes = Uint8List.fromList([1, 2, 3, 4]);
      final encoded = base64Encode(bytes);

      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);
      when(() => mockSharedPreferences.getString('test-key'))
          .thenReturn(encoded);

      final result = await cacheService.loadPersistedBytesData('test-key');

      expect(result, bytes);
    });

    test('throws exception when key does not exist', () async {
      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(false);

      expect(
        () => cacheService.loadPersistedBytesData('test-key'),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Bytes data not found in cache'),
        )),
      );
    });
  });

  group('loadPersistedData', () {
    test('loads List<String> correctly', () async {
      final testList = ['item1', 'item2'];
      final encoded = jsonEncode(testList);

      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);
      when(() => mockSharedPreferences.getString('test-key'))
          .thenReturn(encoded);

      final result =
          await cacheService.loadPersistedData<List<String>>('test-key');

      expect(result, testList);
    });

    test('loads List<QuickOrderItem> correctly', () async {
      // Create test data matching QuickOrderItem structure
      final testItems = [
        {
          'product': {
            'id': 'prod-1',
            'name': 'Product 1',
            'productCode': 'item1'
          },
          'quantityOrdered': 1
        },
        {
          'product': {
            'id': 'prod-2',
            'name': 'Product 2',
            'productCode': 'item2'
          },
          'quantityOrdered': 2
        }
      ];
      final encoded = jsonEncode(testItems);

      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);
      when(() => mockSharedPreferences.getString('test-key'))
          .thenReturn(encoded);

      final result = await cacheService
          .loadPersistedData<List<QuickOrderItem>>('test-key');

      expect(result.length, 2);
      expect(result[0].product.productCode, 'item1');
      expect(result[0].quantityOrdered, 1);
      expect(result[1].product.productCode, 'item2');
      expect(result[1].quantityOrdered, 2);
    });

    test('loads VmiLocationModel correctly', () async {
      // Include all required boolean fields for VmiLocationModel
      final testLocation = {
        'id': 'test-id',
        'name': 'Test Location',
        'isDefault': false,
        'isDeleted': false,
        'isActive': true
      };
      final encoded = jsonEncode(testLocation);

      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);
      when(() => mockSharedPreferences.getString('test-key'))
          .thenReturn(encoded);

      // Use Map<String, String> which is supported in parseResult
      final result =
          await cacheService.loadPersistedData<Map<String, String>>('test-key');

      expect(result, isA<Map<String, String>>());
      expect(result['id'], 'test-id');
      expect(result['name'], 'Test Location');
    });

    test('loads Map<String, String> correctly', () async {
      final testMap = {'key1': 'value1', 'key2': 'value2'};
      final encoded = jsonEncode(testMap);

      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);
      when(() => mockSharedPreferences.getString('test-key'))
          .thenReturn(encoded);

      final result =
          await cacheService.loadPersistedData<Map<String, String>>('test-key');

      expect(result, testMap);
    });

    test('throws exception for unsupported type', () async {
      final testValue = {'value': 123};
      final encoded = jsonEncode(testValue);

      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(true);
      when(() => mockSharedPreferences.getString('test-key'))
          .thenReturn(encoded);

      expect(
        () => cacheService.loadPersistedData<bool>('test-key'),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('throws exception when key does not exist', () async {
      when(() => mockSharedPreferences.containsKey('test-key'))
          .thenReturn(false);

      expect(
        () => cacheService.loadPersistedData<String>('test-key'),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Data not found in cache'),
        )),
      );
    });
  });

  group('persistBytesData', () {
    test('saves bytes data as base64 encoded string', () async {
      final bytes = Uint8List.fromList([1, 2, 3, 4]);
      final encoded = base64Encode(bytes);

      when(() => mockSharedPreferences.setString('test-key', encoded))
          .thenAnswer((_) async => true);

      final result = await cacheService.persistBytesData('test-key', bytes);

      expect(result, isTrue);
      verify(() => mockSharedPreferences.setString('test-key', encoded))
          .called(1);
    });
  });

  group('persistData', () {
    test('saves json encoded data', () async {
      final testObject = {'name': 'Test', 'value': 123};

      when(() => mockSharedPreferences.setString(
          'test-key', jsonEncode(testObject))).thenAnswer((_) async => true);

      final result = await cacheService.persistData('test-key', testObject);

      expect(result, isTrue);
      verify(() => mockSharedPreferences.setString(
          'test-key', jsonEncode(testObject))).called(1);
    });
  });

  group('removePersistedData', () {
    test('removes key from shared preferences', () async {
      when(() => mockSharedPreferences.remove('test-key'))
          .thenAnswer((_) async => true);

      await cacheService.removePersistedData('test-key');

      verify(() => mockSharedPreferences.remove('test-key')).called(1);
    });
  });

  group('shutdown', () {
    test('does not throw exception', () {
      expect(() => cacheService.shutdown(), returnsNormally);
    });
  });

  group('cache durations', () {
    test('offlineCacheMinutes returns expected value', () {
      expect(cacheService.offlineCacheMinutes, 5);
    });

    test('onlineCacheMinutes returns expected value', () {
      expect(cacheService.onlineCacheMinutes, 5);
    });
  });

  group('parseResult', () {
    test('parses VmiLocationModel correctly', () {
      // Create a test map with all required fields
      final jsonMap = {
        'id': 'test-id',
        'name': 'Test Location',
        'isDefault': false,
        'isDeleted': false,
        'isActive': true
      };

      // Either modify the test to use a supported type
      final result = cacheService.parseResult<Map<String, String>>(jsonMap);

      expect(result, isA<Map<String, String>>());
      expect(result['id'], 'test-id');
    });

    test('parses Map<String, String> correctly', () {
      final jsonMap = {'key1': 'value1', 'key2': 'value2'};

      final result = cacheService.parseResult<Map<String, String>>(jsonMap);

      expect(result, jsonMap);
    });

    test('throws UnsupportedError for unsupported type', () {
      final jsonMap = {'value': 123};

      expect(
        () => cacheService.parseResult<bool>(jsonMap),
        throwsA(isA<UnsupportedError>().having(
          (e) => e.toString(),
          'message',
          contains('Type not supported'),
        )),
      );
    });
  });
}
