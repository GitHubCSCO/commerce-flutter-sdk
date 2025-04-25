import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';

class ShowHidePricingInventoryUseCase extends BaseUseCase {
  void setHidePricingEnable(bool enable) {
    coreServiceProvider
        .getAppConfigurationService()
        .setHidePricingEnable(enable);
  }

  bool getHidePricingEnable() {
    return coreServiceProvider.getAppConfigurationService().hidePricingEnable ??
        false;
  }

  void setHideInventoryEnable(bool enable) {
    coreServiceProvider
        .getAppConfigurationService()
        .setHideInventoryEnable(enable);
  }

  bool getHideInventoryEnable() {
    return coreServiceProvider.getAppConfigurationService().hidePricingEnable ??
        false;
  }
}
