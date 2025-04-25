import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/content_management_usecase/cms_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMIMainUseCase extends CmsUseCase {
  VMIMainUseCase({PageContentType? contentType})
      : super(contentType: contentType);

  @override
  PageContentType get contentType => PageContentType.vmiMain;

  Future<Result<List<WidgetEntity>, ErrorResponse>> loadData() async {
    var result = await super.getCMSData();
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<void> getClosestVmiLocation() async {
    VmiLocationModel? vmiLocation =
        await coreServiceProvider.getVmiService().getClosestVmiLocation();
    if (vmiLocation != null) {
      coreServiceProvider.getVmiService().saveCurrentVmiLocation(vmiLocation);
    }
  }
}
