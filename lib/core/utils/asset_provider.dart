import 'dart:convert';
import 'package:flutter/services.dart';

class AssetPathResolver {
  static bool _isRunningAsPackage = false;
  static Set<String> _manifestKeys = {};

  /// Call this from your wrapper app before runApp()
  /// to both mark “embedded” mode and load the manifest.
  static Future<void> setRunningAsPackage(bool value) async {
    _isRunningAsPackage = value;
    if (value) {
      // load the merged AssetManifest.json (wrapper + packages)
      final manifestJson = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestJson);
      _manifestKeys = manifestMap.keys.toSet();
    } else {
      _manifestKeys.clear();
    }
  }

  /// Resolves to:
  ///  • 'assets/...'(wrapper) if embedded *and* wrapper declared the asset
  ///  • 'packages/commerce_flutter_app/assets/...'(core) if embedded *and* wrapper did not declare it
  ///  • 'assets/...'(standalone) when not embedded
  static String resolve(String assetPath) {
    assert(_manifestKeys != null,
        'You must call setRunningAsPackage(...) before resolve()');
    if (!_isRunningAsPackage) {
      return assetPath;
    }
    // embedded: prefer wrapper’s asset if present
    if (_manifestKeys.contains(assetPath)) {
      return assetPath;
    }
    // otherwise fall back to core package bundle
    return 'packages/commerce_flutter_app/$assetPath';
  }
}
