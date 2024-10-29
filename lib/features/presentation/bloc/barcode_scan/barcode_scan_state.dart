part of 'barcode_scan_bloc.dart';

abstract class BarcodeScanState {}

class BarcodeScanInitialState extends BarcodeScanState {}

class ScannerFlashOnOffState extends BarcodeScanState {
  final bool cameraFlash;
  ScannerFlashOnOffState(this.cameraFlash);
}

class ScannerScanState extends BarcodeScanState {
  final bool canProcess;
  ScannerScanState(this.canProcess);
}

class ScannerProductFoundState extends BarcodeScanState {}

class ScannerProductNotFoundState extends BarcodeScanState {}
