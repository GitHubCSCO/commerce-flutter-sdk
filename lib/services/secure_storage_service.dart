import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SecureStorageService implements ISecureStorageService {
  SecureStorageService()
      : storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  final FlutterSecureStorage storage;

  @override
  Future<bool> clearAll() async {
    try {
      await storage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> load(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<bool> remove(String key) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> save(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
