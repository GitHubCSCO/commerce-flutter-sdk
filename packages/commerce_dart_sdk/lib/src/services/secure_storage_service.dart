import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService implements ISecureStorageService {
  SecureStorageService(this.preferences);

  final SharedPreferences preferences;

  @override
  String? load(String key) {
    return preferences.getString(key);
  }

  @override
  Future<void> save(String key, String value) async {
    await preferences.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await preferences.remove(key);
  }
}
