import 'package:camera/camera.dart';
import 'package:commerce_flutter_sdk/core/utils/camera_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A widget showing a live camera preview.
class ScannerCameraPreview extends StatelessWidget {
  /// Creates a preview widget for the given camera controller.
  const ScannerCameraPreview(this.controller, {super.key, this.child});

  /// The controller for the camera that the preview is shown for.
  final CameraController controller;

  /// A widget to overlay on top of the camera preview
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? ValueListenableBuilder<CameraValue>(
            valueListenable: controller,
            builder: (BuildContext context, Object? value, Widget? child) {
              var aspectRatio = isLandscape(controller)
                  ? controller.value.aspectRatio
                  : (1 / controller.value.aspectRatio);
              return AspectRatio(
                aspectRatio: aspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _wrapInRotatedBox(child: controller.buildPreview()),
                    child ?? Container(),
                  ],
                ),
              );
            },
            child: child,
          )
        : Container();
  }

  Widget _wrapInRotatedBox({required Widget child}) {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return child;
    }

    return RotatedBox(
      quarterTurns: getQuarterTurns(controller),
      child: child,
    );
  }
}
