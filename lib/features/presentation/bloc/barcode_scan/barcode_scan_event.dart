part of 'barcode_scan_bloc.dart';

abstract class BarcodeScanEvent {}

class ScannerFlashOnOffEvent extends BarcodeScanEvent {
  final bool cameraFlash;
  ScannerFlashOnOffEvent(this.cameraFlash);
}

class ScannerScanEvent extends BarcodeScanEvent {
  final bool canProcess;
  ScannerScanEvent(this.canProcess);
}

class ScannerResetEvent extends BarcodeScanEvent {}

class ScannerProductFoundEvent extends BarcodeScanEvent {}

class ScannerProductNotFoundEvent extends BarcodeScanEvent {}
