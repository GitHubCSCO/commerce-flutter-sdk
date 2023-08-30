import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

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

class ErrorResponse {
  ErrorResponse({
    this.error,
    this.errorDescription,
    this.message,
  });

  String? message;

  String? error;

  // [JsonProperty("error_description")]
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
}

class ServiceBase {}
