import 'dart:typed_data';

import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PrintUseCase extends BaseUseCase {
  PrintUseCase() : super();

  Future<Result<Uint8List, ErrorResponse>> getPdf(String printPath) async {
    return commerceAPIServiceProvider.getPrintService().getPdf(printPath);
  }
}
