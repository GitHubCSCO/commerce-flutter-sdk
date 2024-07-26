import 'dart:convert';

import 'package:commerce_flutter_app/core/config/analytics_config.dart';
import 'package:commerce_flutter_app/core/extensions/firebase_options_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigUsecase extends BaseUseCase {
  RemoteConfigUsecase() : super();

  Future<void> _syncRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    // Using zero duration to force fetching from remote server.
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
  }

  Future<List<Map<String, String>>> fetchDebugCredential(String domain) async {
    if (sl<AnalyticsConfig>().firebaseOptions?.isValid() == true) {
      await _syncRemoteConfig();
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      final String jsonString = remoteConfig.getString('debug_credentials');

      if (jsonString.isEmpty) {
        return List.empty();
      }

      final Map<String, dynamic> decodedJson = jsonDecode(jsonString);

      var decodeMap = decodedJson.map((key, value) {
        return MapEntry(key, Map<String, String>.from(value));
      });

      List<Map<String, String>> result = [];

      decodeMap.forEach((key, value) {
        if (value['url'] == domain) {
          result.add(value);
        }
      });

      return result;
    } else {
      return List.empty();
    }
  }

  Future<Map<String, String>> fetchDebugDomains() async {
    if (sl<AnalyticsConfig>().firebaseOptions?.isValid() == true) {
      await _syncRemoteConfig();
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      final String jsonString = remoteConfig.getString('debug_credentials');
      if (jsonString.isEmpty) {
        return {};
      }

      final Map<String, dynamic> decodedJson = jsonDecode(jsonString);

      Map<String, String> resultMap = {};

      decodedJson.forEach((key, value) {
        if (value is Map<String, dynamic> && value.containsKey('url')) {
          resultMap[key] = value['url'];
        }
      });

      return resultMap;
    } else {
      return {};
    }
  }
}
