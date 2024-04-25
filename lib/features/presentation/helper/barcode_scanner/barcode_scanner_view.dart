import 'dart:math';
import 'package:camera/camera.dart';
import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'detector_view.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DetectorView(
            title: 'Barcode Scanner',
            customPaint: _customPaint,
            text: _text,
            onImage: _processImage,
            initialCameraLensDirection: _cameraLensDirection,
            onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
          ),
        ),
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(
              horizontal: 32, vertical: 16),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: PrimaryButton(
            onPressed: () {
              setState(() {
                _canProcess = !_canProcess;
              });
            },
            backgroundColor: _canProcess ? OptiAppColors.buttonDarkRedBackgroudColor : AppStyle.primary500,
            text: _canProcess ? LocalizationConstants.cancel : LocalizationConstants.tapToScan,
          ),
        )
      ],
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);

    final size = rotateSize(inputImage.metadata!.size, inputImage.metadata?.rotation.rawValue ?? 0);
    const areaHeight = 300;
    const left = 20.00;
    final right = size.width - left;
    final top = (size.height + areaHeight) / 2 - areaHeight;
    final bottom = (size.height + areaHeight) / 2;

    Rect mainRect = Rect.fromLTRB(left, top, right, bottom);
    final barCodesWithIn = barcodesWithinMainRect(mainRect, barcodes);

    if (barCodesWithIn.isNotEmpty) {
      if (barCodesWithIn.length == 1) {
        Navigator.of(context).pop(barCodesWithIn[0].rawValue);
        return;
      } else {
        displayDialogWidget(
            context: context,
            title: LocalizationConstants.multipleBarcodeWarningTitle,
            message: LocalizationConstants.multipleBarcodeWarningMessage,
            actions: [
              DialogPlainButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(LocalizationConstants.oK),
              ),
            ]);
      }
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  List<Barcode> barcodesWithinMainRect(Rect scanArea, List<Barcode> barcodes) {
    List<Barcode> barcodesWithin = [];

    for (var barcode in barcodes) {
      if (scanArea.contains(Offset(barcode.boundingBox.left, barcode.boundingBox.top)) &&
          scanArea.contains(Offset(barcode.boundingBox.right, barcode.boundingBox.bottom))) {
        barcodesWithin.add(barcode);
      }
    }

    return barcodesWithin;
  }

  Size rotateSize(Size size, int rotation) {
    // Convert rotation to radians
    double rotationRad = rotation * pi / 180;

    // Calculate rotated width and height
    double rotatedWidth = (size.width * cos(rotationRad)).abs() + (size.height * sin(rotationRad)).abs();
    double rotatedHeight = (size.width * sin(rotationRad)).abs() + (size.height * cos(rotationRad)).abs();

    return Size(rotatedWidth, rotatedHeight);
  }

}