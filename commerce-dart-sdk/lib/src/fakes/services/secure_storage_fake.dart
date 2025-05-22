// coverage:ignore-file
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FakeSecureStorageService implements ISecureStorageService {
  final Map<String, String?> _store = {};

  @override
  Future<String?> load(String key) async => _store[key];

  @override
  Future<bool> remove(String key) async {
    _store.remove(key);
    return true;
  }

  @override
  Future<bool> save(String key, String value) async {
    _store[key] = value;
    return true;
  }

  @override
  Future<bool> clearAll() async {
    _store.clear();
    return Future.value(true);
  }
}
