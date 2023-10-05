import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

class SessionService extends ServiceBase implements ISessionService {
  SessionService({required IClientService clientService})
      : super(clientService: clientService);

  @override
  Future<ServiceResponse<Session>> deleteCurrentSession() async {
    currentSession = null;
    var response =
        await deleteAsync<Session>(CommerceAPIConstants.currentSessionUrl);
    return ServiceResponse<Session>(statusCode: response.statusCode);
  }

  @override
  Future<ServiceResponse<Session>> getCurrentSession() async {
    try {
      var result = await getAsyncNoCache<Session>(
          CommerceAPIConstants.currentSessionUrl, Session.fromJson);
      if (result.model != null) {
        if (currentSession != null) {
          if ((currentSession?.persona != result.model?.persona) ||
              !(currentSession?.personas != null &&
                  result.model?.personas != null)) {
            /// TODO - Notify Session Changed
          }
        }

        await clientService.storeSessionState(currentSession: result.model);
        currentSession = result.model;
      }

      return result;
    } catch (e) {
      return ServiceResponse<Session>(exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<Session>> patchCustomerSession(Session session) {
    // TODO: implement patchCustomerSession
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<Session>> patchSession(Session session) async {
    try {
      var jsonData = await serializeToJson<Session>(
          session, (Session session) => session.toJson());
      var result = await patchAsyncNoCache<Session>(
          CommerceAPIConstants.currentSessionUrl, jsonData, Session.fromJson);

      if (result.model != null) {
        var sessionResponse = await getCurrentSession();
        currentSession = sessionResponse.model;

        return sessionResponse;
      }

      return ServiceResponse<Session>(
        model: currentSession,
        error: result.error,
        exception: result.exception,
        statusCode: result.statusCode,
        isCached: result.isCached,
      );
    } catch (e) {
      return ServiceResponse<Session>(exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<Session>> postSession(Session session) async {
    try {
      var jsonData = await serializeToJson<Session>(
          session, (Session session) => session.toJson());
      var result = await postAsyncNoCache<Session>(
          CommerceAPIConstants.postSessionUrl, jsonData, Session.fromJson);

      if (result.model != null) {
        await clientService.storeSessionState(currentSession: result.model);
        currentSession = result.model;
      }

      return result;
    } catch (e) {
      return ServiceResponse<Session>(exception: Exception(e.toString()));
    }
  }

  @override
  Session? currentSession;
}
