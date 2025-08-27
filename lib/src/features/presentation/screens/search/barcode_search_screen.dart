import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/barcode_scanner/barcode_scanner_view.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeSearchScreen extends BaseStatelessWidget {
  const BarcodeSearchScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BarcodeScanBloc>(),
      child: BarcodeScannerView(
          callback: _handleBarcodeValue, barcodeFullView: true),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewBarcode,
        AnalyticsConstants.screenNameSearch,
      );

  _handleBarcodeValue(BuildContext context,
      {String? resultText, BarcodeFormat? format}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted || resultText == null || format == null) {
      return;
    }
    Navigator.of(context).pop((resultText, format));
  }

  @override
  TelemetryEvent getTelemetryScreenEvent() =>
      TelemetryEvent(screenName: AnalyticsConstants.screenNameSearch);
}
