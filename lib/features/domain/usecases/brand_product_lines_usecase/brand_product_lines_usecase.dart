import 'package:commerce_flutter_sdk/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandProductLinesUseCase extends BaseUseCase {
  Future<List<BrandProductLine>?> getBrandProductLines(Brand brand) async {
    final productLinesQueryParameters =
        ProductLinesQueryParameters(brandId: brand.id);
    final brandProductLinesResultResponse = await commerceAPIServiceProvider
        .getBrandService()
        .getBrandProductLines(productLinesQueryParameters);
    final brandProductLines =
        brandProductLinesResultResponse.getResultSuccessValue();

    return brandProductLines?.productLines;
  }
}
