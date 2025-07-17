import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PushNotificationService extends ServiceBase
    implements IPushNotificationService {
  PushNotificationService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<DeviceTokenResponse, ErrorResponse>> registerDeviceToken(
    DeviceTokenRegistrationParameters deviceTokenRegistrationRequest,
  ) async {
    final data = deviceTokenRegistrationRequest.toJson();

    final response = await postAsyncNoCache<DeviceTokenResponse>(
      CommerceAPIConstants.registerDeviceTokenUrl,
      data,
      DeviceTokenResponse.fromJson,
    );

    return response;
  }
}
