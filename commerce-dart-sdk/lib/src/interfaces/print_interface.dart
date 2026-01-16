import 'dart:typed_data';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IPrintService {
  Future<Result<Uint8List, ErrorResponse>> getPdf(String printPath);
}
