import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/biometric_authentication_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/device_interface.dart';

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
}
