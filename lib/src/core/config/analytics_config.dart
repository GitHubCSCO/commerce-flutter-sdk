import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class AnalyticsConfig {
  final IAppConfigurationService appConfigurationService;
  late String? _appCenterSecret;
  AnalyticsConfig({
    required this.appConfigurationService,
  }) {
    _init();
  }

  _init() {
    loadFirebaseOptions() {
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

  }

  String? get appCenterSecret => _appCenterSecret;
}
