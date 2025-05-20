import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DashboardPanelsService extends ServiceBase
    implements IDashboardPanelsService {
  DashboardPanelsService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<DashboardPanelsResult, ErrorResponse>>
      getDashboardPanelsAsync() async {
    return await getAsyncNoCache(
      CommerceAPIConstants.dashboardPanelUrl,
      DashboardPanelsResult.fromJson,
    );
  }
}
