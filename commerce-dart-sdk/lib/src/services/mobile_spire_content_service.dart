import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/models/user_event.dart';

class MobileSpireContentService extends ServiceBase
    implements IMobileSpireContentService {
  MobileSpireContentService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<PageContentManagement, ErrorResponse>>
      getPageContenManagmentSpire(
    String pageName,
  ) async {
    if (pageName.isEmpty) {
      return Failure(ErrorResponse(message: 'pageName is required'));
    }

    var urlString = '${CommerceAPIConstants.contentUrl}$pageName';

    var urlStringTelemetry = '${CommerceAPIConstants.telemetryUrl}';

    var event = UserEvent(
        emailAddress: "hello@gmail.com",
        eventName: "Mobile Event",
        properties: EventProperties(appVersion: "213.123"),
        fullName: "Nothing");

    var reseponse = await postAsyncNoCache<UserEvent>(urlStringTelemetry, event.toJson(),UserEvent.fromJson);

    return await getAsyncNoCache<PageContentManagement>(
        urlString, PageContentManagement.fromJson);
  }
}
