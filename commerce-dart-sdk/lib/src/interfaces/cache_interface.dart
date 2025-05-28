import 'dart:typed_data';

abstract class ICacheService {
  /// number of minutes to cache data while online.
  int get onlineCacheMinutes;

  /// number of minutes to cache data while offline.
  int get offlineCacheMinutes;

  /// Ensure that everything is closed and written and happy
  void shutdown();

  /// Store an object into the Local Storage.
  ///
  /// [T] is the type of object to store.
  ///
  /// [key] is the key to store the object under.
  ///
  /// [value] is the object to store.
  ///
  /// Returns a [Future] that indicates whether the action was successful or not.
  Future<bool> persistData<T>(String key, T value);

  /// Store raw bytes into the Local Storage.
  ///
  /// [key] is the database key for which the value is to correspond.
  ///
  /// [value] is the object.
  ///
  /// Returns a [Future] that indicates whether the action was successful or not.
  Future<bool> persistBytesData(String key, Uint8List value);

  /// Retrieve an object from the Local Storage.
  ///
  /// [T] is the type of the object.
  ///
  /// [key] is the database key for which the object corresponds.
  ///
  /// Returns the object.
  Future<T> loadPersistedData<T>(String key);

  /// Retrieve raw bytes data from the Local Storage.
  ///
  /// [key] is the database key for which the data corresponds.
  ///
  /// Returns the data.
  Future<Uint8List> loadPersistedBytesData(String key);

  /// Remove all data associated with the given database key.
  ///
  /// [key] is the database key for which the data corresponds.
  Future<void> removePersistedData(String key);

  Future<bool> hasOnlineCache(String key);

  Future<void> clearAllCaches();

  Future<T> getOrFetchObject<T>(
    String key,
    Future<T> Function() fetchFunc, {
    DateTime? absoluteExpiration,
  });

  Future<void> invalidate(String key);

  Future<void> invalidateObjectWithKeysStartingWith<T>(String keyPrefix);

  Future<void> invalidateObject<T>(String key);

  Future<void> invalidateAllObjects<T>();

  Future<void> invalidateAllObjectsExcept(List<String> keysToKeep);

  Future<void> insertObject<T>(
    String key,
    T value, {
    DateTime? absoluteExpiration,
  });

  Future<T> getObject<T>(String key);
}
