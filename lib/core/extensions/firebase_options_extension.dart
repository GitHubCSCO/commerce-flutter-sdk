import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

extension FirebaseOptionsExtensions on FirebaseOptions {
  bool isValid() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return apiKey.isNotEmpty &&
            appId.isNotEmpty &&
            messagingSenderId.isNotEmpty &&
            projectId.isNotEmpty;
      case TargetPlatform.iOS:
        return apiKey.isNotEmpty &&
            appId.isNotEmpty &&
            messagingSenderId.isNotEmpty &&
            projectId.isNotEmpty &&
            iosBundleId?.isNotEmpty == true;
      default:
        return false;
    }
  }
}
