import 'package:camera/camera.dart';
import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class DetectorView extends StatefulWidget {
  DetectorView({
    Key? key,
    required this.title,
    required this.onImage,
    this.customPaint,
    this.text,
    required this.cameraFlash,
    required this.barcodeFullView,
    this.initialCameraLensDirection = CameraLensDirection.back,
    this.onCameraFeedReady,
    this.onCameraLensDirectionChanged,
  }) : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final String? text;
  final bool cameraFlash;
  final bool barcodeFullView;
  final Function(InputImage inputImage) onImage;
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
      cameraFlash: widget.cameraFlash,
      barcodeFullView: widget.barcodeFullView,
      onCameraFeedReady: widget.onCameraFeedReady,
      initialCameraLensDirection: widget.initialCameraLensDirection,
      onCameraLensDirectionChanged: widget.onCameraLensDirectionChanged,
      resolutionPreset: ResolutionPreset.medium,
    );
  }
}
