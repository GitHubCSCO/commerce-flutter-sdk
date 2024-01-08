import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CmsUseCase {
  late PageContentType contentType;

  final IContentConfigurationService _contentConfigurationService;

  CmsUseCase(this._contentConfigurationService,
      {PageContentType? contentType}) {
    this.contentType = contentType ?? PageContentType.account;
  }

  void loadData() {
    // TODO: Implement the logic to load data from CMS
    print('CmsUseCase loaddata');

    final result =
        _contentConfigurationService.loadPreviewContentManagement(contentType);

    switch (result) {
      case Success(value: final value):
        {
          print(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          print(errorResponse);
        }
    }
  }
}
