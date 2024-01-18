import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/usecases/content_management_usecase/cms_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchUseCase extends CmsUseCase {
  SearchUseCase(IContentConfigurationService contentConfigurationService,
      ISessionService sessionService, {PageContentType? contentType})
      : super(contentConfigurationService, sessionService,
      contentType: contentType);

  @override
  PageContentType get contentType => PageContentType.searchLanding;

  Future<Result<List<WidgetEntity>, ErrorResponse>> loadData() async {
    print('SearchUseCase loaddata');
    var result = await super.getCMSData();
    switch (result) {
      case Success(value: final data):
        print(data);
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

}