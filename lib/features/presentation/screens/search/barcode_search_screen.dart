import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/barcode_scanner_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  _handleBarcodeValue(BuildContext context, String rawValue) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;
    Navigator.of(context).pop(rawValue);
  }

}