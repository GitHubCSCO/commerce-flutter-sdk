import 'dart:typed_data';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PrintService extends ServiceBase implements IPrintService {
  PrintService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<Uint8List, ErrorResponse>> getPdf(String printPath) async {
    var url = Uri.parse('/$printPath');
    return await getAsyncBinaryDataNoCache(
      url.toString(),
    );
  }
}
