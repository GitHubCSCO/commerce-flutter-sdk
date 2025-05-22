import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MobileContentService extends ServiceBase
    implements IMobileContentService {
  MobileContentService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<PageContentManagement, ErrorResponse>>
      getPageContentManagementClassic(String pageName) async {
    if (pageName.isEmpty) {
      return Failure(ErrorResponse(message: 'pageName is required'));
    }

    var urlString = Uri.parse(CommerceAPIConstants.mobileContentUrlFormat
        .replaceAll('{0}', pageName));

    return await getAsyncNoCache<PageContentManagement>(
        urlString.toString(), PageContentManagement.fromJson);
  }
}
