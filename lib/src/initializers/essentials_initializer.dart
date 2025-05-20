import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class EssentialsInitializer {
  EssentialsInitializer();

  Future<void> init() async {
    var colorString = await sl<ILocalStorageService>()
        .load(CoreConstants.primaryColorCachingKey);
    if (colorString != null) {
      // Convert back to Color
      OptiAppColors.primaryColor = Color(int.parse(colorString, radix: 16));
    }
  }
}
