import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IDashboardPanelsService {
  Future<Result<DashboardPanelsResult, ErrorResponse>>
      getDashboardPanelsAsync();
}
