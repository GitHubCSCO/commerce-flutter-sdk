// lib/src/initializers/analytics_initializer.dart
import 'dart:async';
import 'dart:ui';
import 'package:commerce_flutter_sdk/src/core/extensions/firebase_options_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AnalyticsInitializer {
  // Static so injection_container.dart can call AnalyticsInitializer.init(cfg: cfg)
  // without needing to instantiate the class first.
  static Future<void> init({required AnalyticsConfig cfg}) async {
    if (cfg.appCenterSecret?.isNullOrEmpty == false) {
      await AppCenter.start(secret: cfg.appCenterSecret!);
    }

    

    // Capture the default handler so we can call it from our override.
    // This preserves the built-in Flutter error display in debug / profile
    // builds while still forwarding to Crashlytics / AppCenter in release.
    final FlutterExceptionHandler? defaultOnError = FlutterError.onError;

    // Handle Flutter framework errors:
    FlutterError.onError = (errorDetails) async {
      // Always invoke the default handler first so errors remain visible in
      // debug and TestFlight builds. Without this, the error console goes
      // silent and a blank screen is the only symptom.
      defaultOnError?.call(errorDetails);

      // Ignore benign NetworkImageLoadException – no need to report these.
      if (errorDetails.exception is NetworkImageLoadException) {
        return;
      }

      if (cfg.appCenterSecret?.isNullOrEmpty == false) {
        await AppCenterCrashes.trackException(
          message: errorDetails.exception.toString(),
          type: errorDetails.exception.runtimeType,
          stackTrace: errorDetails.stack,
        );
      }
    };
  }
}