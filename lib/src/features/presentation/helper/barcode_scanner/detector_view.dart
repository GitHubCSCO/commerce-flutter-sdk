import 'package:camera/camera.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/barcode_scanner/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class DetectorView extends StatefulWidget {
  DetectorView({
    Key? key,
    required this.onImage,
    this.customPaint,
    this.text,
    required this.barcodeFullView,
    this.initialCameraLensDirection = CameraLensDirection.back,
    this.onCameraFeedReady,
    this.onCameraLensDirectionChanged,
  }) : super(key: key);

  final CustomPaint? customPaint;
  final String? text;
  final bool barcodeFullView;
  final Function({
    required InputImage inputImage,
    required Size canvasSize,
    required double aspectRatio,
  })? onImage;
  final Function()? onCameraFeedReady;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<DetectorView> createState() => _DetectorViewState();
}

class _DetectorViewState extends State<DetectorView> {
  @override
  Widget build(BuildContext context) {
    return CameraView(
      customPaint: widget.customPaint,
      onImage: widget.onImage,
      barcodeFullView: widget.barcodeFullView,
      onCameraFeedReady: widget.onCameraFeedReady,
      initialCameraLensDirection: widget.initialCameraLensDirection,
      onCameraLensDirectionChanged: widget.onCameraLensDirectionChanged,
      resolutionPreset: ResolutionPreset.high,
    );
  }
}
