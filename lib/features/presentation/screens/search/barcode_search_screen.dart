import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/barcode_scanner_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeSearchScreen extends StatelessWidget {
  const BarcodeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BarcodeScanBloc>(),
      child: BarcodeScannerView(
          callback: _handleBarcodeValue, barcodeFullView: true),
    );
  }

  _handleBarcodeValue(BuildContext context,
      {String? resultText, BarcodeFormat? format}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted || resultText == null || format == null) {
      return;
    }
    Navigator.of(context).pop((resultText, format));
  }
}
