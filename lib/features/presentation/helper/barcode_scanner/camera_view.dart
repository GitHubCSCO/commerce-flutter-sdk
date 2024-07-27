import 'dart:io';

import 'package:camera/camera.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class CameraView extends StatefulWidget {
  CameraView({Key? key,
    required this.customPaint,
    required this.onImage,
    required this.barcodeFullView,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.initialCameraLensDirection = CameraLensDirection.back,
    this.resolutionPreset})
      : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final bool barcodeFullView;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;
  final ResolutionPreset? resolutionPreset;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  bool cameraFlash = false;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarcodeScanBloc, BarcodeScanState>(
      listener: (context, state) {
        if (state is ScannerFlashOnOffState) {
          setState(() {
            cameraFlash = state.cameraFlash;
          });
          _controller?.setFlashMode(
              cameraFlash ? FlashMode.torch : FlashMode.off);
        }
      },
      child: Scaffold(body: _liveFeedBody()),
    );
  }

  Widget _liveFeedBody() {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(
            _controller!,
            child: widget.customPaint,
          ),
          _rectangleScanArea(),
          _switchFlashToggle(),
          _backButton(),
        ],
      ),
    );
  }

  Widget _backButton() =>
        Visibility(
          visible: widget.barcodeFullView,
          child: Positioned(
            top: 40,
            right: 24,
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    width: 64.0,
                    height: 64.0,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: FloatingActionButton(
                    heroTag: Object(),
                    shape: const CircleBorder(),
                    onPressed: () => Navigator.of(context).pop(),
                    backgroundColor: Colors.grey.shade100,
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );



  Widget _switchFlashToggle() =>
        Visibility(
          visible: widget.barcodeFullView,
          child: Positioned(
            top: 40,
            left: 24,
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: (){
                      setState(() => cameraFlash = !cameraFlash);
                      _controller?.setFlashMode(
                          cameraFlash ? FlashMode.torch : FlashMode.off);
                  },
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    width: 64.0,
                    height: 64.0,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: FloatingActionButton(
                    heroTag: Object(),
                    shape: const CircleBorder(),
                    onPressed: () {
                      setState(() => cameraFlash = !cameraFlash);
                      _controller?.setFlashMode(
                          cameraFlash ? FlashMode.torch : FlashMode.off);
                    },
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(
                      cameraFlash ? Icons.flash_on : Icons.flash_off,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

  Widget _rectangleScanArea() {
    double rectangleHeight = CoreConstants.barcodeRectangleSize;
    Size screenSize = MediaQuery
        .of(context)
        .size;

    final topMargin = (screenSize.height - 180 - 80) / 2;

    return Positioned(
      top: widget.barcodeFullView ? topMargin : 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: rectangleHeight,
        child: CustomPaint(
          painter: RectanglePainter(),
        ),
      ),
    );
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      widget.resolutionPreset ?? ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
      _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble() * 1, image.height.toDouble() * 1),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // final rect = Rect.fromLTWH(
    //   size.width *
    //       0.10, // Adjust these values as needed to position the rectangle
    //   size.height * 0.4,
    //   size.width * 0.80,
    //   size.height * 0.20,
    // );
    final rect = Rect.fromLTWH(
      size.width * 0.10,
      size.height * 0.15,
      size.width * 0.80,
      size.height * 0.70,
    );

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
