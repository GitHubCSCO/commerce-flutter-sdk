import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/usecases/content_management_usecase/cms_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ShopUseCase extends CmsUseCase {

  final ICacheService _cacheService;

  ShopUseCase(IContentConfigurationService contentConfigurationService,
      ISessionService sessionService, this._cacheService, {PageContentType? contentType})
      : super(contentConfigurationService, sessionService,
            contentType: contentType);

  @override
  PageContentType get contentType => PageContentType.shop;

  Future<Result<List<WidgetEntity>, ErrorResponse>> loadData() async {
    print('ShopUseCase loaddata');
    var result = await super.getCMSData();
    switch (result) {
      case Success(value: final data):
        print(data);
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  void addFakeSearchHistory() async {
    final list = ["stapler", "tools", "battery"];
    _cacheService.persistData<List<String>>("search_history", list);
  }

}
