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
  ///  • 'packages/commerce_flutter_sdk/assets/...'(core) if embedded *and* wrapper did not declare it
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
    return 'packages/commerce_flutter_sdk/$assetPath';
  }
}

/// A utility class which provides the appropriate path to asset files
/// This ensures the correct path to assets is used whether assets are from a core package or wrapper package
class CoreAssetProvider {
  final String _wrapperAssetPath;
  final String _coreAssetPath;

  CoreAssetProvider({String? wrapperAssetPath})
      : _wrapperAssetPath = wrapperAssetPath ?? '',
        _coreAssetPath = 'packages/commerce_flutter_sdk';

  /// Returns the appropriate asset path based on whether a wrapper asset exists
  ///
  /// Returns:
  ///  • 'wrapperPath' if wrapper package declares asset
  ///  • 'packages/commerce_flutter_sdk/assets/...'(core) if embedded *and* wrapper did not declare it
  ///  • 'assets/...'(core) if not embedded. In this case, the asset needs to be declared in pubspec.yaml.
  String getAssetPath(String assetPath) {
    if (_wrapperAssetPath.isNotEmpty) {
      return _wrapperAssetPath;
    }
    if (_coreAssetPath.isNotEmpty) {
      return '$_coreAssetPath/$assetPath';
    }
    return assetPath;
  }

  String get coreAssetPath => 'packages/commerce_flutter_sdk/$assetPath';

  static const String assetPath = 'assets';
}
