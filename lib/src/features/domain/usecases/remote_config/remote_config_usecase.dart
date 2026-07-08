import 'dart:convert';

import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/firebase_options_extension.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';

class RemoteConfigUsecase extends BaseUseCase {
  RemoteConfigUsecase() : super();

  Future<void> _syncRemoteConfig() async {
  }

  Future<List<Map<String, String>>> fetchDebugCredential(String domain) async {
      return List.empty();
  }

  Future<bool> fetchDevMode() async {
      return false;
  }

  Future<Map<String, String>> fetchDebugDomains() async {
      return {};
  }
}
