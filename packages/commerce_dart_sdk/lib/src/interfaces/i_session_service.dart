import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_dart_sdk/src/models/session.dart';
import 'package:http/http.dart' as http;

abstract class ISessionService {
  Session? currentSession;

  Future<ServiceResponse<Session>> postSession(Session session);

  Future<ServiceResponse<Session>> patchSession(Session session);

  Future<ServiceResponse<Session>> patchCustomerSession(Session session);

  Future<ServiceResponse<Session>> getCurrentSession();

  Future<http.BaseResponse> deleteCurrentSession();
}
