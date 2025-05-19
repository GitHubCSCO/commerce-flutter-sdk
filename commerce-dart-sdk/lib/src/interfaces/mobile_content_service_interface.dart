import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IMobileContentService {
  Future<Result<PageContentManagement, ErrorResponse>>
      getPageContentManagementClassic(String pageName);
}
