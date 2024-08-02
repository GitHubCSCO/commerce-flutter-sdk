import 'dart:io' show Platform;
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/detector_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeScannerView extends StatefulWidget {
  final Function(BuildContext, String) callback;
  final bool barcodeFullView;

  BarcodeScannerView(
      {required this.callback, required this.barcodeFullView, super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _isBusy = false;
  bool isDialogShowing = false;
  CustomPaint? _customPaint;
  String? _text;
  bool canProcess = false;
  var _cameraLensDirection = CameraLensDirection.back;

  double sideMargin = 20.0;
  double bottomViewHeight = 80.0;
  double scanAreaHeight = 200.0;

  @override
  void dispose() {
    canProcess = false;
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

  Future<void> _processImage(InputImage inputImage) async {
    if (!canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);

    Size screenSize = MediaQuery.of(context).size;

    final size = rotateSize(
        inputImage.metadata!.size, inputImage.metadata?.rotation.rawValue ?? 0);
    double areaHeight = calculateNewHeight(
        screenSize.height - bottomViewHeight, size.height, scanAreaHeight);

    final left = sideMargin;
    final right = size.width - left;
    double top;
    double bottom;

    if (widget.barcodeFullView) {
      top = (size.height + areaHeight) / 2 - areaHeight;
      bottom = (size.height + areaHeight) / 2;
    } else {
      top = 0.00;
      bottom = top + areaHeight;
    }

    Rect mainRect = Rect.fromLTRB(left, top, right, bottom);
    final barCodesWithIn = barcodesWithinMainRect(mainRect, barcodes);

    await Future.delayed(const Duration(milliseconds: 100));

    if (barCodesWithIn.isNotEmpty) {
      if (barCodesWithIn.length == 1) {
        await widget.callback(context, barCodesWithIn[0].rawValue!);
        _busyUpdate();
      } else if (!isDialogShowing) {
        isDialogShowing = true;
        displayDialogWidget(
            context: context,
            title:
                LocalizationConstants.multipleBarcodeWarningTitle.localized(),
            message:
                LocalizationConstants.multipleBarcodeWarningMessage.localized(),
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

  List<Barcode> barcodesWithinMainRect(Rect scanArea, List<Barcode> barcodes) {
    List<Barcode> barcodesWithin = [];

    for (var barcode in barcodes) {
      if (scanArea.contains(
              Offset(barcode.boundingBox.left, barcode.boundingBox.top)) &&
          scanArea.contains(
              Offset(barcode.boundingBox.right, barcode.boundingBox.bottom))) {
        barcodesWithin.add(barcode);
      }
    }

    return barcodesWithin;
  }

  Size rotateSize(Size size, int rawRotation) {
    final rotation = (Platform.isIOS) ? 0 : rawRotation;

    // Convert rotation to radians
    double rotationRad = rotation * pi / 180;

    // Calculate rotated width and height
    double rotatedWidth = (size.width * cos(rotationRad)).abs() +
        (size.height * sin(rotationRad)).abs();
    double rotatedHeight = (size.width * sin(rotationRad)).abs() +
        (size.height * cos(rotationRad)).abs();

    return Size(rotatedWidth, rotatedHeight);
  }

  double calculateNewHeight(
      double screenHeight, double cameraHeight, double areaHeight) {
    double ratio = cameraHeight / screenHeight;
    double newHeight = areaHeight * ratio;
    return newHeight;
  }
}
