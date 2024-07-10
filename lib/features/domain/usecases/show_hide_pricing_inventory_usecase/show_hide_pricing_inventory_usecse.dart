import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class ShowHidePricingInventoryUseCase extends BaseUseCase {

  void setHidePricingEnable(bool enable) {
    coreServiceProvider.getAppConfigurationService().setHidePricingEnable(enable);
  }

  bool getHidePricingEnable() {
    return coreServiceProvider.getAppConfigurationService().showHidePricingEnable ?? false;
  }

  void setHideInventoryEnable(bool enable) {
    coreServiceProvider.getAppConfigurationService().setHideInventoryEnable(enable);
  }

  bool getHideInventoryEnable() {
    return coreServiceProvider.getAppConfigurationService().showHidePricingEnable ?? false;
  }

}