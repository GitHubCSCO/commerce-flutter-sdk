import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/content_management_usecase/cms_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AccountUseCase extends CmsUseCase {
  AccountUseCase({super.contentType});

  @override
  PageContentType get contentType => PageContentType.account;

  Future<Result<List<WidgetEntity>, ErrorResponse>> loadData() async {
    var result = await super.getCMSData();
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  String? get firstName =>
      commerceAPIServiceProvider.getAccountService().currentAccount?.firstName;

  String? get lastName =>
      commerceAPIServiceProvider.getAccountService().currentAccount?.lastName;

  String? get email =>
      commerceAPIServiceProvider.getAccountService().currentAccount?.email;

  String? get getAppVersionAndBuildNumber =>
      coreServiceProvider.getDeviceService().currentVersion;

  String? get userName =>
      commerceAPIServiceProvider.getAccountService().currentAccount?.userName;
}
