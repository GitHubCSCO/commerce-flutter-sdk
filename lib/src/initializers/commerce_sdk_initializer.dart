import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/core/config/prod_config_constants.dart';

class CommerceSdkInitializer {
  void init() {
    ClientConfig.hostUrl = null;
    ClientConfig.clientId = ProdConfigConstants.clientId;
    ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
  }
}
