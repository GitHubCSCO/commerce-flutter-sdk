import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CatalogpagesService extends ServiceBase implements ICatalogpagesService {
  CatalogpagesService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<CatalogPage, ErrorResponse>> getProductCatalogInformation(
      String productPath) async {
    var url = Uri.parse('${CommerceAPIConstants.catalogPageUrl}$productPath');
    return await getAsyncNoCache(
      url.toString(),
      CatalogPage.fromJson,
    );
  }
}
