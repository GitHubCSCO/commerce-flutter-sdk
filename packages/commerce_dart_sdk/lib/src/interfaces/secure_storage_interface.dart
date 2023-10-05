abstract class ISecureStorageService {
  String? load(String key);
  Future<void> save(String key, String value);
  Future<void> remove(String key);
}
