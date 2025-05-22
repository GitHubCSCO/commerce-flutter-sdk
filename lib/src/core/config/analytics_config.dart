import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class AnalyticsConfig {
  final IAppConfigurationService appConfigurationService;
  late FirebaseOptions? _firebaseOptions;
  late String? _appCenterSecret;
  AnalyticsConfig({
    required this.appConfigurationService,
  }) {
    _init();
  }

  _init() {
    loadFirebaseOptions() {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return FirebaseOptions(
            apiKey:
                appConfigurationService.baseConfig?.firebaseAndroidApiKey ?? "",
            appId:
                appConfigurationService.baseConfig?.firebaseAndroidAppId ?? "",
            messagingSenderId: appConfigurationService
                    .baseConfig?.firebaseAndroidMessagingSenderId ??
                "",
            projectId:
                appConfigurationService.baseConfig?.firebaseAndroidProjectId ??
                    "",
            storageBucket: appConfigurationService
                    .baseConfig?.firebaseAndroidStorageBucket ??
                "",
          );
        case TargetPlatform.iOS:
          return FirebaseOptions(
            apiKey: appConfigurationService.baseConfig?.firebaseIOSApiKey ?? "",
            appId: appConfigurationService.baseConfig?.firebaseIOSAppId ?? "",
            messagingSenderId: appConfigurationService
                    .baseConfig?.firebaseIOSMessagingSenderId ??
                "",
            projectId:
                appConfigurationService.baseConfig?.firebaseIOSProjectId ?? "",
            storageBucket:
                appConfigurationService.baseConfig?.firebaseIOSStorageBucket ??
                    "",
            iosBundleId:
                appConfigurationService.baseConfig?.firebaseIOSBundleId ?? "",
          );
        default:
          return const FirebaseOptions(
              apiKey: "", appId: "", messagingSenderId: "", projectId: "");
      }
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        _appCenterSecret =
            appConfigurationService.baseConfig?.appCenterSecretAndroid ?? "";
        break;
      case TargetPlatform.iOS:
        _appCenterSecret =
            appConfigurationService.baseConfig?.appCenterSecretiOS ?? "";
        break;
      default:
        _appCenterSecret = "";
        break;
    }

    _firebaseOptions = loadFirebaseOptions();
  }

  FirebaseOptions? get firebaseOptions => _firebaseOptions;
  String? get appCenterSecret => _appCenterSecret;
}
