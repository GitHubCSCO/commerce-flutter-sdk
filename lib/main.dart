import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commerce_flutter_app/src/providers/providers.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        productInterfaceProvider.overrideWithValue(ProductService()),
      ],
      child: const CommerceApp(),
    ),
  );
}
