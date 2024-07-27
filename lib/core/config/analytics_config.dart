import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
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
            apiKey: appConfigurationService.firebaseAndroidApiKey ?? "",
            appId: appConfigurationService.firebaseAndroidAppId ?? "",
            messagingSenderId:
                appConfigurationService.firebaseAndroidMessagingSenderId ?? "",
            projectId: appConfigurationService.firebaseAndroidProjectId ?? "",
            storageBucket:
                appConfigurationService.firebaseAndroidStorageBucket ?? "",
          );
        case TargetPlatform.iOS:
          return FirebaseOptions(
            apiKey: appConfigurationService.firebaseIOSApiKey ?? "",
            appId: appConfigurationService.firebaseIOSAppId ?? "",
            messagingSenderId:
                appConfigurationService.firebaseIOSMessagingSenderId ?? "",
            projectId: appConfigurationService.firebaseIOSProjectId ?? "",
            storageBucket:
                appConfigurationService.firebaseIOSStorageBucket ?? "",
            iosBundleId: appConfigurationService.firebaseIOSBundleId ?? "",
          );
        default:
          return const FirebaseOptions(
              apiKey: "", appId: "", messagingSenderId: "", projectId: "");
      }
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        _appCenterSecret = appConfigurationService.appCenterSecretAndroid ?? "";
        break;
      case TargetPlatform.iOS:
        _appCenterSecret = appConfigurationService.appCenterSecretiOS ?? "";
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
