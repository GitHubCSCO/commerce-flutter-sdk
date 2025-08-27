import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/models/user_event.dart';

class MobileSpireContentService extends ServiceBase
    implements IMobileSpireContentService {
  MobileSpireContentService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<PageContentManagement, ErrorResponse>>
      getPageContenManagmentSpire(
    String pageName,
  ) async {
    if (pageName.isEmpty) {
      return Failure(ErrorResponse(message: 'pageName is required'));
    }

    var urlString = '${CommerceAPIConstants.contentUrl}$pageName';

    return await getAsyncNoCache<PageContentManagement>(
        urlString, PageContentManagement.fromJson);
  }
}
