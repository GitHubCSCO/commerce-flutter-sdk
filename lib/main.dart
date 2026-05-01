import 'dart:async';

import 'package:commerce_flutter_sdk/commerce_config.dart';
import 'package:commerce_flutter_sdk/src/initializers/commerce_flutter_sdk_initializer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  // runZonedGuarded catches every uncaught async error in the entire app,
  // including ones thrown during initialization. Without it, an exception
  // before runApp() leaves the iOS launch storyboard visible forever — which
  // is exactly what produces the "blank white screen" symptom in TestFlight.
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await CommerceFlutterSDK.initialize(
        config: CommerceConfig(
          isRunningAsPackage: false,
          overrideServices: (sl) async {},
        ),
      );
    } catch (error, stack) {
      // If SDK init fails outright, still render *something* so the launch
      // screen is dismissed and we have a visible failure mode rather than
      // a permanent white screen.
      debugPrint('FATAL: CommerceFlutterSDK.initialize() failed: $error');
      debugPrint('$stack');
      runApp(_FatalErrorApp(error: error, stack: stack));
    }
  }, (error, stack) {
    // Catches anything that escaped the try/catch above (rare, but possible
    // for uncaught async errors fired off during init).
    debugPrint('FATAL (zoned): $error');
    debugPrint('$stack');
  });
}

/// Minimal fallback UI shown only when SDK initialization fails completely.
/// The point is to NEVER leave the user staring at the launch screen — even
/// a crash log is better than a blank window for triaging TestFlight issues.
class _FatalErrorApp extends StatelessWidget {
  const _FatalErrorApp({required this.error, required this.stack});

  final Object error;
  final StackTrace stack;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'The app failed to start.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Please share the details below with support:',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  SelectableText(
                    '$error\n\n$stack',
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
