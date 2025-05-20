// coverage:ignore-file
import 'dart:typed_data';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FakeCacheService implements ICacheService {
  Map<String, dynamic> cache = {};

  @override
  Future<void> clearAllCaches() async {
    cache.clear();
  }

  @override
  Future<T> getObject<T>(String key) {
    if (cache.containsKey(key)) {
      return Future.value(cache[key] as T);
    } else {
      throw Exception('Object not found in cache');
    }
  }

  @override
  Future<T> getOrFetchObject<T>(String key, Future<T> Function() fetchFunc,
      {DateTime? absoluteExpiration}) async {
    if (cache.containsKey(key)) {
      return cache[key] as T;
    } else {
      final value = await fetchFunc();
      cache[key] = value;
      return value;
    }
  }

  @override
  Future<bool> hasOnlineCache(String key) {
    return Future.value(cache.containsKey(key));
  }

  @override
  Future<void> insertObject<T>(String key, T value,
      {DateTime? absoluteExpiration}) {
    cache[key] = value;
    return Future.value();
  }

  @override
  Future<void> invalidate(String key) {
    cache.remove(key);
    return Future.value();
  }

  @override
  Future<void> invalidateAllObjects<T>() {
    cache.clear();
    return Future.value();
  }

  @override
  Future<void> invalidateObject<T>(String key) {
    cache.remove(key);
    return Future.value();
  }

  @override
  Future<void> invalidateObjectWithKeysStartingWith<T>(String keyPrefix) {
    cache.removeWhere((key, value) => key.startsWith(keyPrefix));
    return Future.value();
  }

  @override
  Future<void> invalidateAllObjectsExcept(List<String> keysToKeep) {
    final allKeys = cache.keys;
    for (var key in allKeys) {
      if (!keysToKeep.contains(key)) {
        cache.remove(key);
      }
    }
    return Future.value();
  }

  @override
  Future<Uint8List> loadPersistedBytesData(String key) {
    if (cache.containsKey(key)) {
      return Future.value(cache[key] as Uint8List);
    } else {
      throw Exception('Bytes data not found in cache');
    }
  }

  @override
  Future<T> loadPersistedData<T>(String key) {
    if (cache.containsKey(key)) {
      return Future.value(cache[key] as T);
    } else {
      throw Exception('Data not found in cache');
    }
  }

  @override
  int get offlineCacheMinutes => 5; // arbitrary value

  @override
  int get onlineCacheMinutes => 5; // arbitrary value

  @override
  Future<bool> persistBytesData(String key, Uint8List value) {
    cache[key] = value;
    return Future.value(true);
  }

  @override
  Future<bool> persistData<T>(String key, T value) {
    cache[key] = value;
    return Future.value(true);
  }

  @override
  Future<void> removePersistedData(String key) {
    cache.remove(key);
    return Future.value();
  }

  @override
  void shutdown() {
    // TODO: implement shutdown
  }
}
