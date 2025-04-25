// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io' show Platform;
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/barcode_scanner/detector_view.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/barcode_scanner/painters/coordinates_translator.dart';

class BarcodeScannerView extends StatefulWidget {
  final Function(BuildContext, {String resultText, BarcodeFormat format})
      callback;
  final bool barcodeFullView;

  const BarcodeScannerView({
    super.key,
    required this.callback,
    required this.barcodeFullView,
  });

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView>
    with TickerProviderStateMixin {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcessFrame = false;
  bool _isDialogShowing = false;
  bool _canScan = false;
  CustomPaint? _customPaint;
  RectanglePainter? rectanglePainter;

  var _cameraLensDirection = CameraLensDirection.back;

  double bottomViewHeight = 80.0;

  @override
  void initState() {
    rectanglePainter = RectanglePainter(vsync: this);
    _customPaint = CustomPaint(painter: rectanglePainter);
    super.initState();
  }

  @override
  void dispose() {
    _canScan = false;
    rectanglePainter?.dispose();
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarcodeScanBloc, BarcodeScanState>(
      listener: (context, state) {
        if (state is ScannerScanState) {
          setState(() {
            _canScan = state.canProcess;
            if (_canScan) {
              _canProcessFrame = true;
            }
            rectanglePainter?.reset();
          });
        } else if (state is ScannerProductFoundState) {
          setState(() {
            rectanglePainter?.animate(
                startColor: Colors.green, endColor: Colors.white);
          });
        } else if (state is ScannerProductNotFoundState) {
          setState(() {
            rectanglePainter?.setColor(Colors.red);
          });
        }
      },
      child: Column(
        children: [
          Expanded(
            child: DetectorView(
              customPaint: _customPaint,
              barcodeFullView: widget.barcodeFullView,
              onImage: _canScan && _canProcessFrame && !_isDialogShowing
                  ? _processImage
                  : null,
              initialCameraLensDirection: _cameraLensDirection,
              onCameraLensDirectionChanged: (value) =>
                  _cameraLensDirection = value,
            ),
          ),
          Visibility(
            visible: widget.barcodeFullView,
            child: Container(
              height: bottomViewHeight,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: PrimaryButton(
                onPressed: () {
                  setState(() {
                    _canScan = !_canScan;
                    if (_canScan) {
                      _canProcessFrame = true;
                    }
                    rectanglePainter?.reset();
                  });
                },
                backgroundColor: _canScan
                    ? OptiAppColors.buttonDarkRedBackgroudColor
                    : OptiAppColors.primaryColor,
                text: _canScan
                    ? LocalizationConstants.cancel.localized()
                    : LocalizationConstants.tapToScan.localized(),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _processImage({
    required InputImage inputImage,
    required Size canvasSize,
    required double aspectRatio,
  }) {
    if (!_isDialogShowing) {
      _barcodeScanner.processImage(inputImage).then((barcodes) {
        if (barcodes.isNotEmpty && _canProcessFrame) {
          setState(() {
            //Found barcode, we should pause scanning until we see whether they are inside the rect or not
            _canProcessFrame = false;
          });
          final size = rotateSize(inputImage.metadata!.size,
              inputImage.metadata?.rotation.rawValue ?? 0);

          final updatedCanvasSize =
              Size(canvasSize.width, canvasSize.width / aspectRatio);

          var barCodesWithIn = <Barcode>[];
          for (var barcode in barcodes) {
            final left = translateX(
                barcode.boundingBox.left, updatedCanvasSize, size, 0);
            final top =
                translateY(barcode.boundingBox.top, updatedCanvasSize, size, 0);
            final right = translateX(
                barcode.boundingBox.right, updatedCanvasSize, size, 0);
            final bottom = translateY(
                barcode.boundingBox.bottom, updatedCanvasSize, size, 0);
            var transformedBoundingBox =
                Rect.fromLTRB(left, top, right, bottom);

            if (isRectInside(rectanglePainter?.rect, transformedBoundingBox)) {
              barCodesWithIn.add(barcode);
            } else {
              rectanglePainter?.reset();
            }
          }

          if (barCodesWithIn.isNotEmpty && mounted) {
            if (barCodesWithIn.length == 1) {
              widget.callback(
                context,
                resultText: barCodesWithIn[0].rawValue!,
                format: barCodesWithIn[0].format,
              );
            } else {
              setState(() {
                _isDialogShowing = true;
              });
              displayDialogWidget(
                  context: context,
                  title: LocalizationConstants.multipleBarcodeWarningTitle
                      .localized(),
                  message: LocalizationConstants.multipleBarcodeWarningMessage
                      .localized(),
                  actions: [
                    DialogPlainButton(
                      onPressed: () {
                        if (widget.barcodeFullView) {
                          setState(() {
                            _canScan = false;
                            _canProcessFrame = true;
                            _isDialogShowing = false;
                          });
                        } else {
                          //This callback is to reset canProcess in quick order
                          widget.callback(
                            context,
                          );
                          setState(() {
                            _isDialogShowing = false;
                          });
                        }

                        Navigator.of(context).pop();
                      },
                      child: Text(LocalizationConstants.oK.localized()),
                    ),
                  ]);
            }
          } else {
            setState(() {
              //Could not find any barcode, we should keep scanning
              _canProcessFrame = true;
            });
          }
        }
      });
    }
  }

  bool isRectInside(Rect? outerRect, Rect? innerRect) {
    if (outerRect == null || innerRect == null) {
      return false;
    }
    return outerRect.contains(innerRect.topLeft) &&
        outerRect.contains(innerRect.topRight) &&
        outerRect.contains(innerRect.bottomLeft) &&
        outerRect.contains(innerRect.bottomRight);
  }

  Size rotateSize(Size size, int rawRotation) {
    final rotation = (Platform.isIOS) ? 0 : rawRotation;
    // Convert rotation to radians
    var rotationRad = rotation * pi / 180;
    // Calculate rotated width and height
    var rotatedWidth = (size.width * cos(rotationRad)).abs() +
        (size.height * sin(rotationRad)).abs();
    var rotatedHeight = (size.width * sin(rotationRad)).abs() +
        (size.height * cos(rotationRad)).abs();
    return Size(rotatedWidth, rotatedHeight);
  }
}

class RectanglePainter extends CustomPainter {
  Rect? rect;
  Color _rectColor = Colors.white;
  AnimationController? _controller;
  late Animation<Color?> _colorAnimation;
  TickerProvider vsync;

  RectanglePainter({
    required this.vsync,
  });

  void animate({
    Color startColor = Colors.green,
    Color endColor = Colors.white,
  }) {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: vsync,
    );

    _colorAnimation = ColorTween(
      begin: startColor,
      end: endColor,
    ).animate(_controller!);

    // Start the animation after a delay
    Future.delayed(const Duration(milliseconds: 5), () {
      _controller?.forward();
    });

    // Add listener to rebuild on each frame
    _controller?.addListener(() {
      _rectColor = _colorAnimation.value ?? Colors.white;
    });
  }

  void setColor(Color color) {
    _rectColor = color;
  }

  void reset() {
    _rectColor = Colors.white;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _rectColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final rectWidth = size.width * CoreConstants.drawRectWidthFactor;
    const rectHeight =
        CoreConstants.barcodeRectangleSize * CoreConstants.drawRectHeightFactor;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final left = centerX - (rectWidth / 2);
    final top = centerY - (rectHeight / 2);

    rect = Rect.fromLTWH(
      left,
      top,
      rectWidth,
      rectHeight,
    );

    canvas.drawRect(rect!, paint);
  }

  void dispose() {
    _controller?.dispose();
  }

  @override
  bool shouldRepaint(covariant RectanglePainter oldDelegate) {
    return oldDelegate._rectColor != _rectColor || oldDelegate.rect != rect;
  }
}
