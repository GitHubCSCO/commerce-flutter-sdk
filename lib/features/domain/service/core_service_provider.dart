import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/biometric_authentication_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/device_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/geo_location_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/location_search_history_service.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/search_history_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/tracking_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/vmi_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/search_history_service.dart';

class CoreServiceProvider implements ICoreServiceProvider {
  @override
  IContentConfigurationService getContentConfigurationService() =>
      sl<IContentConfigurationService>();

  @override
  IAppConfigurationService getAppConfigurationService() =>
      sl<IAppConfigurationService>();

  @override
  IBiometricAuthenticationService getBiometricAuthenticationService() =>
      sl<IBiometricAuthenticationService>();

  @override
  IDeviceService getDeviceService() => sl<IDeviceService>();

  @override
  IVmiService getVmiService() => sl<IVmiService>();

  @override
  getGeoLocationService() => sl<IGeoLocationService>();

  @override
  ILocationSearchHistoryService getLocationSearchHistoryService() =>
      sl<ILocationSearchHistoryService>();

  @override
  ISearchHistoryService getSearchHistoryService() => sl<SearchHistoryService>();

    @override
  ITrackingService getTrackingService() => sl<ITrackingService>();
}
