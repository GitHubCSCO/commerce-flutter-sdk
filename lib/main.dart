import 'package:commerce_flutter_sdk/commerce_config.dart';
import 'package:commerce_flutter_sdk/src/initializers/commerce_flutter_sdk_initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CommerceFlutterSDK.initialize(
    config: CommerceConfig(
      isRunningAsPackage: false,
      overrideServices: (sl) async {},
    ),
  );
}
