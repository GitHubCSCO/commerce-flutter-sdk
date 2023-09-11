import 'dart:convert';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_dart_sdk/src/models/session.dart';
import 'package:http/http.dart' as http;

class SessionService extends ISessionService {
  SessionService({required this.clientService});

  IClientService clientService;

  @override
  Future<http.BaseResponse> deleteCurrentSession() async {
    currentSession = null;
    var bearerToken = await clientService.getAccessToken();

    var headers = {
      'Authorization': 'Bearer $bearerToken',
    };

    var request = http.Request(
        'DELETE', Uri.parse('${ClientConfig.hostUrl}/api/v1/sessions/current'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  @override
  Future<ServiceResponse<Session>> getCurrentSession() async {
    try {
      var bearerToken = await clientService.getAccessToken();
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };

      var request = http.Request(
          'GET', Uri.parse('${ClientConfig.hostUrl}/api/v1/sessions/current'));

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      var sessionResponse = ServiceResponse<Session>(
          statusCode: response.statusCode,
          model: Session.fromJson(json.decode(responseStr)));

      currentSession = sessionResponse.model;
      return sessionResponse;
    } catch (e) {
      return ServiceResponse<Session>(exception: e as Exception);
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
      var bearerToken = await clientService.getAccessToken();
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };

      var request = http.Request(
          'PATCH', Uri.parse('${ClientConfig.hostUrl}/api/v1/sessions'));

      request.body = json.encode(currentSession?.toJson());

      request.headers.addAll(headers);
      await request.send();

      var sessionResponse = await getCurrentSession();
      currentSession = sessionResponse.model;

      return sessionResponse;
    } catch (e) {
      return ServiceResponse<Session>(exception: e as Exception);
    }
  }

  @override
  Future<ServiceResponse<Session>> postSession(Session session) async {
    try {
      var bearerToken = await clientService.getAccessToken();
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };

      var request = http.Request(
          'POST', Uri.parse('${ClientConfig.hostUrl}/api/v1/sessions/current'));

      request.body = json.encode(currentSession?.toJson());

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      var sessionResponse = ServiceResponse<Session>(
          statusCode: response.statusCode,
          model: Session.fromJson(json.decode(responseStr)));

      if (sessionResponse.model != null) {
        currentSession = sessionResponse.model;
      }

      return sessionResponse;
    } catch (e) {
      return ServiceResponse<Session>(exception: e as Exception);
    }
  }
}
