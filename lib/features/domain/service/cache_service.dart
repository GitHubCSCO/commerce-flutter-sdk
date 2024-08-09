import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService implements ICacheService {
  @override
  void clearAllCaches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Future<T> getObject<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return Future.value(jsonDecode(prefs.getString(key)!) as T);
    } else {
      throw Exception('Object not found in cache');
    }
  }

  @override
  Future<T> getOrFetchObject<T>(String key, Future<T> Function() fetchFunc,
      {DateTime? absoluteExpiration}) async {
    final value = await fetchFunc();
    return value;
  }

  @override
  Future<bool> hasOnlineCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.containsKey(key));
  }

  @override
  Future<void> insertObject<T>(String key, T value,
      {DateTime? absoluteExpiration}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
    return Future.value();
  }

  @override
  Future<void> invalidate(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return Future.value();
  }

  @override
  Future<void> invalidateAllObjects<T>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return Future.value();
  }

  @override
  Future<void> invalidateObject<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return Future.value();
  }

  @override
  Future<void> invalidateObjectWithKeysStartingWith<T>(String keyPrefix) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(keyPrefix));
    for (var key in keys) {
      prefs.remove(key);
    }
    return Future.value();
  }

  @override
  Future<Uint8List> loadPersistedBytesData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return Future.value(base64Decode(prefs.getString(key)!));
    } else {
      throw Exception('Bytes data not found in cache');
    }
  }

  @override
  Future<T> loadPersistedData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      if (T == List<String>) {
        List<dynamic> dynamicList = jsonDecode(prefs.getString(key)!);
        List<String> stringList =
            dynamicList.map((item) => item as String).toList();
        return stringList as T;
      } else {
        String rawValue = prefs.getString(key)!;
        Map<String, dynamic> jsonMap = jsonDecode(rawValue);
        return parseResult<T>(jsonMap);
      }
    } else {
      throw Exception('Data not found in cache');
    }
  }

  @override
  int get offlineCacheMinutes => 5; // arbitrary value

  @override
  int get onlineCacheMinutes => 5; // arbitrary value

  @override
  Future<bool> persistBytesData(String key, Uint8List value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, base64Encode(value));
    return Future.value(true);
  }

  @override
  Future<bool> persistData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
    return Future.value(true);
  }

  @override
  Future<void> removePersistedData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return Future.value();
  }

  @override
  void shutdown() {
    // No specific implementation required for shutdown in this example
  }

  T parseResult<T>(Map<String, dynamic> jsonMap) {
    final typeMap = <Type, Function>{
      VmiLocationModel: (json) => VmiLocationModel.fromJson(jsonMap),
      Map<String, String>: (json) => jsonMap.map((key, value) {
            return MapEntry(key, value?.toString() ?? '');
          }),
    };

    final creator = typeMap[T];

    if (creator != null) {
      return creator(jsonMap) as T;
    }

    throw UnsupportedError('Type not supported');
  }
}
