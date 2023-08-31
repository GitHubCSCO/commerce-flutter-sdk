import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commerce_flutter_app/src/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(const CircularProgressIndicator());

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return runApp(
    ProviderScope(
      overrides: [
        productInterfaceProvider.overrideWithValue(ProductService()),
        localStorageInterfaceProvider
            .overrideWithValue(LocalStorageService(prefs)),
      ],
      child: const CommerceApp(),
    ),
  );
}
