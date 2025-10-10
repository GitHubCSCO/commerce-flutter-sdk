// lib/src/initializers/analytics_initializer.dart
import 'dart:async';
import 'dart:ui';
import 'package:commerce_flutter_sdk/src/core/extensions/firebase_options_extension.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AnalyticsInitializer {
  Future<void> init() async {
    final cfg = GetIt.I<AnalyticsConfig>();

    if (cfg.appCenterSecret?.isNullOrEmpty == false) {
      await AppCenter.start(secret: cfg.appCenterSecret!);
    }

    if (cfg.firebaseOptions?.isValid() == true) {
      // On Android, Firebase is already initialized by the Google Services plugin
      // On iOS, we need to initialize manually since there's no plugin
      // This is a workaround for that
      try {
        await Firebase.initializeApp(options: cfg.firebaseOptions);
      } on FirebaseException catch (fe) {
        if (fe.code != 'duplicate-app') {
          rethrow;
        }
      }
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        // Fire and forget - don't await in the error handler to avoid blocking
        unawaited(FirebaseCrashlytics.instance
            .recordError(error, stack, fatal: true));
        return true;
      };
    }

    // Handle Flutter framework errors:
    FlutterError.onError = (errorDetails) async {
      // Ignore benign NetworkImageLoadException
      if (errorDetails.exception is NetworkImageLoadException) {
        FlutterError.presentError(errorDetails);
      } else {
        if (cfg.firebaseOptions?.isValid() == true) {
          await FirebaseCrashlytics.instance
              .recordFlutterFatalError(errorDetails);
        }
        if (cfg.appCenterSecret?.isNullOrEmpty == false) {
          await AppCenterCrashes.trackException(
            message: errorDetails.exception.toString(),
            type: errorDetails.exception.runtimeType,
            stackTrace: errorDetails.stack,
          );
        }
      }
    };
  }
}
