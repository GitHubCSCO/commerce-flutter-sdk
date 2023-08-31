abstract class ILocalStorageService {
  String? load(String key);
  Future<void> save(String key, String value);
}
