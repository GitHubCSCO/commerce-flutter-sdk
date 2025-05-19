import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

bool isLandscape(CameraController controller) {
  return <DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ].contains(getApplicableOrientation(controller));
}

int getQuarterTurns(CameraController controller) {
  final turns = <DeviceOrientation, int>{
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeRight: 1,
    DeviceOrientation.portraitDown: 2,
    DeviceOrientation.landscapeLeft: 3,
  };
  return turns[getApplicableOrientation(controller)]!;
}

DeviceOrientation getApplicableOrientation(CameraController controller) {
  return controller.value.isRecordingVideo
      ? controller.value.recordingOrientation!
      : (controller.value.previewPauseOrientation ??
          controller.value.lockedCaptureOrientation ??
          controller.value.deviceOrientation);
}
