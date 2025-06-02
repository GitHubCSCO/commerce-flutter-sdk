abstract class ILocalStorageService {
  Future<String?> load(String key);
  Future<void> save(String key, String value);
  Future<void> remove(String key);
}
