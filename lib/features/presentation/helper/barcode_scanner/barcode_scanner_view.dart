// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io' show Platform;
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/detector_view.dart';
import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/painters/coordinates_translator.dart';

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
  bool _isBusy = false;
  bool isDialogShowing = false;
  CustomPaint? _customPaint;
  RectanglePainter? rectanglePainter;
  String? _text;
  bool canProcess = false;
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
    canProcess = false;
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
            canProcess = state.canProcess;
          });
        } else if (state is ScannerResetState) {
          setState(() {
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
              title: 'Barcode Scanner',
              customPaint: _customPaint,
              text: _text,
              barcodeFullView: widget.barcodeFullView,
              onImage: _processImage,
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
                    if (canProcess) {
                      rectanglePainter?.reset();
                    }
                    canProcess = !canProcess;
                  });
                },
                backgroundColor: canProcess
                    ? OptiAppColors.buttonDarkRedBackgroudColor
                    : OptiAppColors.primaryColor,
                text: canProcess
                    ? LocalizationConstants.cancel.localized()
                    : LocalizationConstants.tapToScan.localized(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _processImage({
    required InputImage inputImage,
    required Size canvasSize,
    required double aspectRatio,
  }) async {
    if (!canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    final barcodes = await _barcodeScanner.processImage(inputImage);
    final size = rotateSize(
        inputImage.metadata!.size, inputImage.metadata?.rotation.rawValue ?? 0);

    final updatedCanvasSize =
        Size(canvasSize.width, canvasSize.width / aspectRatio);

    var barCodesWithIn = <Barcode>[];
    for (var barcode in barcodes) {
      final left =
          translateX(barcode.boundingBox.left, updatedCanvasSize, size, 0);
      final top =
          translateY(barcode.boundingBox.top, updatedCanvasSize, size, 0);
      final right =
          translateX(barcode.boundingBox.right, updatedCanvasSize, size, 0);
      final bottom =
          translateY(barcode.boundingBox.bottom, updatedCanvasSize, size, 0);
      var transformedBoundingBox = Rect.fromLTRB(left, top, right, bottom);

      if (isRectInside(rectanglePainter?.rect, transformedBoundingBox)) {
        barCodesWithIn.add(barcode);
      } else {
        rectanglePainter?.reset();
      }
    }

    await Future.delayed(const Duration(milliseconds: 100));

    if (barCodesWithIn.isNotEmpty) {
      if (barCodesWithIn.length == 1) {
        if (mounted) {
          await widget.callback(
            context,
            resultText: barCodesWithIn[0].rawValue!,
            format: barCodesWithIn[0].format,
          );
        }
        _busyUpdate();
      } else if (!isDialogShowing) {
        isDialogShowing = true;
        if (mounted) {
          displayDialogWidget(
              context: context,
              title:
                  LocalizationConstants.multipleBarcodeWarningTitle.localized(),
              message: LocalizationConstants.multipleBarcodeWarningMessage
                  .localized(),
              actions: [
                DialogPlainButton(
                  onPressed: () {
                    _busyUpdate();
                    isDialogShowing = false;
                    Navigator.of(context).pop();
                  },
                  child: Text(LocalizationConstants.oK.localized()),
                ),
              ]);
        }
      }
    } else {
      _busyUpdate();
    }
  }

  void _busyUpdate() {
    _isBusy = false;
    if (mounted) {
      setState(() {});
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
  late AnimationController _controller;
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
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );

    _colorAnimation = ColorTween(
      begin: startColor,
      end: endColor,
    ).animate(_controller);

    // Start the animation after a delay
    Future.delayed(const Duration(microseconds: 1000), () {
      _controller.forward();
    });

    // Add listener to rebuild on each frame
    _controller.addListener(() {
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
    _controller.dispose();
  }

  @override
  bool shouldRepaint(covariant RectanglePainter oldDelegate) {
    return oldDelegate._rectColor != _rectColor || oldDelegate.rect != rect;
  }
}
