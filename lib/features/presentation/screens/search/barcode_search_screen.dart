import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/barcode_scanner_view.dart';
import 'package:flutter/cupertino.dart';

class BarcodeSearchScreen extends StatelessWidget {

  const BarcodeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BarcodeScannerView(callback: _handleBarcodeValue, canProcess: false, cameraFlash: false, barcodeFullView: true);
  }

  _handleBarcodeValue(BuildContext context, String? rawValue) {
    Navigator.of(context).pop(rawValue);
  }

}