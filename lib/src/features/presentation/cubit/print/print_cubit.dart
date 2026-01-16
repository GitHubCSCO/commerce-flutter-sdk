import 'dart:typed_data';

import 'package:commerce_flutter_sdk/src/features/domain/usecases/print_usecase/print_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'print_state.dart';

class PrintCubit extends Cubit<PrintState> {
  final PrintUseCase _printUseCase;

  PrintCubit({required PrintUseCase printUseCase})
      : _printUseCase = printUseCase,
        super(PrintInitial());

  Future<void> loadPdf(String printPath) async {
    emit(PrintLoading());

    final result = await _printUseCase.getPdf(printPath);

    switch (result) {
      case Success(value: final data):
        if (data != null) {
          emit(PrintLoaded(data));
        } else {
          emit(const PrintError('PDF data is null'));
        }
      case Failure(errorResponse: final error):
        emit(PrintError(error.message ?? 'Failed to load PDF'));
    }
  }

  void reset() {
    emit(PrintInitial());
  }
}
