import 'dart:io';

import 'package:flutter/services.dart';

class PlatformUtils {
  static Future<bool> isSystemWebViewEnabled(String url) async {
    // If the platform is iOS, always return true
    if (Platform.isIOS) {
      return true;
    }

    // For Android, check using the MethodChannel
    const platform = MethodChannel('utility_channel');
    try {
      final bool result = await platform.invokeMethod('isWebViewEnabled');
      return result;
    } on PlatformException {
      return false;
    }
  }
}
