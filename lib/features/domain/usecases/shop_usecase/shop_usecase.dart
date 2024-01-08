import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/content_management_usecase/cms_usecase.dart';

class ShopUseCase extends CmsUseCase {
  ShopUseCase(super.contentConfigurationService);

  @override
  PageContentType get contentType => PageContentType.shop;

  @override
  void loadData() {
    super.loadData();
    print('ShopUseCase loaddata');
  }
}
