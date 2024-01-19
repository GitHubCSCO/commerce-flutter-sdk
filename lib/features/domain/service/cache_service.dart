import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CacheService extends ICacheService {

  static const String _boxName = 'app_data';

  @override
  // TODO: implement offlineCacheMinutes
  int get offlineCacheMinutes => 5;

  @override
  // TODO: implement onlineCacheMinutes
  int get onlineCacheMinutes => 5;

  @override
  void shutdown() {
    // TODO: implement shutdown
  }

  @override
  Future<bool> persistData<T>(String key, T value) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.put(key, value);
      return true;
    } catch (e) {
      print('Error persisting data: $e');
      return false;
    }
  }

  @override
  Future<bool> persistBytesData(String key, Uint8List value) {
    // TODO: implement persistBytesData
    throw UnimplementedError();
  }

  @override
  Future<T> loadPersistedData<T>(String key) async {
    try {
      final box = await Hive.openBox(_boxName);
      return box.get(key);
    } catch (e) {
      print('Error loading persisted data: $e');
      return null as T;
    }
  }

  @override
  Future<Uint8List> loadPersistedBytesData(String key) {
    // TODO: implement loadPersistedBytesData
    throw UnimplementedError();
  }

  @override
  Future<void> removePersistedData(String key) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.delete(key);
    } catch (e) {
      print('Error removing persisted data: $e');
    }
  }

  @override
  Future<bool> hasOnlineCache(String key) {
    // TODO: implement hasOnlineCache
    throw UnimplementedError();
  }

  @override
  void clearAllCaches() async {
    try {
      await Hive.deleteBoxFromDisk(_boxName);
    } catch (e) {
      print('Error clearing all data: $e');
    }
  }

  @override
  Future<T> getOrFetchObject<T>(String key, Future<T> Function() fetchFunc, {DateTime? absoluteExpiration}) {
    // TODO: implement getOrFetchObject
    throw UnimplementedError();
  }

  @override
  Future<void> invalidate(String key) {
    // TODO: implement invalidate
    throw UnimplementedError();
  }

  @override
  Future<void> invalidateAllObjects<T>() {
    // TODO: implement invalidateAllObjects
    throw UnimplementedError();
  }

  @override
  Future<void> invalidateObject<T>(String key) {
    // TODO: implement invalidateObject
    throw UnimplementedError();
  }

  @override
  Future<void> invalidateObjectWithKeysStartingWith<T>(String keyPrefix) {
    // TODO: implement invalidateObjectWithKeysStartingWith
    throw UnimplementedError();
  }

  @override
  Future<void> insertObject<T>(String key, T value, {DateTime? absoluteExpiration}) {
    // TODO: implement insertObject
    throw UnimplementedError();
  }

  @override
  Future<T> getObject<T>(String key) {
    // TODO: implement getObject
    throw UnimplementedError();
  }
  
}