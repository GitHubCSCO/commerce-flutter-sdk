import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_dart_sdk/src/services/client_service.dart';
import 'package:dio/dio.dart';

part 'service_base.g.dart';

class ServiceResponse<T> {
  ServiceResponse({
    this.error,
    this.model,
    this.exception,
    this.statusCode,
    this.isCached,
  });

  ErrorResponse? error;

  T? model;

  Exception? exception;

  // HttpStatusCode? statusCode;
  int? statusCode;

  bool? isCached = false;
}

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  ErrorResponse({
    this.error,
    this.errorDescription,
    this.message,
  });

  String? message;

  String? error;

  @JsonKey(name: 'error_description')
  String? errorDescription;

  static ErrorResponse empty() {
    return ErrorResponse();
  }

  String? extractErrorMessage() {
    if (!message!.isNullOrEmpty) {
      return message;
    }

    return errorDescription;
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

class ServiceBase {
  ServiceBase({required this.clientService});

  IClientService clientService;

  T deserializeFromResponse<T>(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    var jsonData = response.data;
    return deserializeFromMap(jsonData, fromJson);
  }

  T deserializeFromString<T>(
      String jsonString, T Function(Map<String, dynamic>) fromJson) {
    var jsonMap = jsonDecode(jsonString);
    var x = fromJson(jsonMap);
    return x;
  }

  T deserializeFromMap<T>(
      Map<String, dynamic> jsonMap, T Function(Map<String, dynamic>) fromJson) {
    return fromJson(jsonMap);
  }

  Map<String, dynamic> serializeToJson<T>(
      T model, Map<String, dynamic> Function(T model) toJson) {
    return toJson(model);
  }

  String serializeToString<T>(T model) {
    return jsonEncode(model);
  }

  Future<ServiceResponse<T>> getAsyncNoCache<T>(
      String path, T Function(Map<String, dynamic>) fromJson,
      {Duration? timeout}) async {
    var response = await clientService.getAsync(path, timeout: timeout);
    if (response.statusCode == HttpStatus.ok) {
      var model = deserializeFromMap(response.data, fromJson);
      return ServiceResponse<T>(model: model, statusCode: response.statusCode);
    } else {
      ErrorResponse errorResponse =
          deserializeFromResponse(response, ErrorResponse.fromJson);
      return ServiceResponse<T>(
        error: errorResponse,
        statusCode: response.statusCode,
      );
    }
  }
}
