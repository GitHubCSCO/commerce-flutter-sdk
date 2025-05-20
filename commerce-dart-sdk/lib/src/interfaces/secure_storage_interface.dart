abstract class ISecureStorageService {
  Future<String?> load(String key);
  Future<bool> save(String key, String value);
  Future<bool> remove(String key);
  Future<bool> clearAll();
}
