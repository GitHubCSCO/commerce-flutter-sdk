import 'package:flutter_bloc/flutter_bloc.dart';

part 'barcode_scan_event.dart';
part 'barcode_scan_state.dart';

class BarcodeScanBloc extends Bloc<BarcodeScanEvent, BarcodeScanState> {
  BarcodeScanBloc() : super(BarcodeScanInitialState()) {
    on<ScannerFlashOnOffEvent>(_onScannerFlashOnOffEvent);
    on<ScannerScanEvent>(_onScannerScanEvent);
    on<ScannerResetEvent>(_onScannerResetEvent);
    on<ScannerProductFoundEvent>(_onScannerProductFoundEvent);
    on<ScannerProductNotFoundEvent>(_onScannerProductNotFoundEvent);
  }

  Future<void> _onScannerFlashOnOffEvent(
      ScannerFlashOnOffEvent event, Emitter<BarcodeScanState> emit) async {
    emit(ScannerFlashOnOffState(event.cameraFlash));
  }

  Future<void> _onScannerScanEvent(
      ScannerScanEvent event, Emitter<BarcodeScanState> emit) async {
    emit(ScannerScanState(event.canProcess));
  }

  Future<void> _onScannerResetEvent(
      ScannerResetEvent event, Emitter<BarcodeScanState> emit) async {
    emit(ScannerResetState());
  }

  Future<void> _onScannerProductFoundEvent(
      ScannerProductFoundEvent event, Emitter<BarcodeScanState> emit) async {
    emit(ScannerProductFoundState());
  }

  Future<void> _onScannerProductNotFoundEvent(
      ScannerProductNotFoundEvent event, Emitter<BarcodeScanState> emit) async {
    emit(ScannerProductNotFoundState());
  }
}
