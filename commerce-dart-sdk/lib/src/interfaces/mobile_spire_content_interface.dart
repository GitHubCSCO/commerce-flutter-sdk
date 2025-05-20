import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// A service which fetches various page content management data.
abstract class IMobileSpireContentService {
  /// Load from server page content management data.
  ///
  /// [pageName] Used for specifying the desired page content management data (shop, search landing, etc...).
  ///
  /// Returns Fetched page content management JSON string
  Future<Result<PageContentManagement, ErrorResponse>>
      getPageContenManagmentSpire(String pageName);
}
