import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/biometric_authentication_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/device_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/geo_location_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/localization_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/location_search_history_service.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/search_history_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/vmi_service_interface.dart';

abstract class ICoreServiceProvider {
  IAppConfigurationService getAppConfigurationService();
  IBiometricAuthenticationService getBiometricAuthenticationService();
  IContentConfigurationService getContentConfigurationService();
  IDeviceService getDeviceService();
  // IFlashlightService getFlashlightService();
  IGeoLocationService getGeoLocationService();
  // IHapticFeedbackService getHapticFeedbackService();
  // IKeyboardService getKeyboardService();
  ILocalizationService getLocalizationService();
  ILocationSearchHistoryService getLocationSearchHistoryService();
  // ILocatorService getLocatorService();
  // IMapService getMapService();
  // IPermissionsService getPermissionsService();
  // IPhoneDialerService getPhoneDialerService();
  // IPlatformService getPlatformService();
  ISearchHistoryService getSearchHistoryService();
  IVmiService getVmiService();
  // INavigationState getNavigationState();
  // IOptiLogger getOptiLogger();
}
