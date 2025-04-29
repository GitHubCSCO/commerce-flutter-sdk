import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService implements ILocalStorageService {
  LocalStorageService();

  SharedPreferences? preferences;

  Future<void> _ensureInitialized() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  @override
  Future<String?> load(String key) async {
    await _ensureInitialized();
    return preferences?.getString(key);
  }

  @override
  Future<void> save(String key, String value) async {
    await _ensureInitialized();
    await preferences?.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _ensureInitialized();
    await preferences?.remove(key);
  }
}
