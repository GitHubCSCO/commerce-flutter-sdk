import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';

part 'service_base.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  ErrorResponse(
      {this.error, this.errorDescription, this.message, this.exception});

  @JsonKey(includeFromJson: false, includeToJson: false)
  Exception? exception;

  String? message;

  String? error;

  @JsonKey(name: 'error_description')
  String? errorDescription;

  static ErrorResponse empty() {
    return ErrorResponse();
  }

  String? extractErrorMessage() {
    if (message != null && message!.isNotEmpty) {
      return message;
    }

    return errorDescription;
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

class ServiceBase {
  ServiceBase({
    required this.clientService,
    required this.cacheService,
    required this.networkService,
  });

  IClientService clientService;
  ICacheService cacheService;
  INetworkService networkService;

  static const Duration defaultRequestTimeout = Duration(seconds: 60);

  T deserializeFromResponse<T>(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    var jsonMap = response.data;
    return deserialize<T>(jsonMap as Map<String, dynamic>, fromJson);
  }

  T deserialize<T>(
      Map<String, dynamic> jsonMap, T Function(Map<String, dynamic>) fromJson) {
    return fromJson(jsonMap);
  }

  Map<String, dynamic> serialize<T>(
      T model, Map<String, dynamic> Function(T model) toJson) {
    return toJson(model);
  }

  ApiResult<T> getAsyncNoCache<T>(
      String path, T Function(Map<String, dynamic>) fromJson,
      {Duration? timeout, CancelToken? cancelToken}) async {
    bool isOnline = await networkService.isOnline();
    if (isOnline) {
      var response = await clientService.getAsync(
        path,
        timeout: timeout,
        cancelToken: cancelToken,
      );

      switch (response) {
        case Success(value: final value):
          {
            var model = deserialize<T>(value?.data, fromJson);
            return Success(model);
          }
        case Failure(errorResponse: final errorResponse):
          {
            return Failure(errorResponse);
          }
      }
    } else {
      return Failure(
        ErrorResponse(
          error: "No internet found",
          exception: NoInternetFoundException(),
        ),
      );
    }
  }

  ApiResult<T> postAsyncNoCache<T>(
    String path,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson, {
    Duration? timeout,
    CancelToken? cancelToken,
  }) async {
    bool isOnline = await networkService.isOnline();
    if (isOnline) {
      var response = await clientService.postAsync(
        path,
        data,
        timeout: timeout,
        cancelToken: cancelToken,
      );

      switch (response) {
        case Success(value: final value):
          {
            if (path.contains('/wishlistlines/batch') ||
                path.contains('/shareinvoice')) {
              // returns empty response
              var model = deserialize<T>({}, fromJson);
              return Success(model);
            }
            var model = deserialize<T>(value?.data, fromJson);
            return Success(model);
          }
        case Failure(errorResponse: final errorResponse):
          {
            return Failure(errorResponse);
          }
      }
    } else {
      return Failure(
        ErrorResponse(
          error: "No internet found",
          exception: NoInternetFoundException(),
        ),
      );
    }
  }

  ApiResult<T> patchAsyncNoCache<T>(
    String path,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson, {
    Duration? timeout,
    CancelToken? cancelToken,
  }) async {
    bool isOnline = await networkService.isOnline();
    if (isOnline) {
      var response = await clientService.patchAsync(
        path,
        data,
        timeout: timeout,
        cancelToken: cancelToken,
      );

      switch (response) {
        case Success(value: final value):
          {
            var model = deserialize<T>(value?.data, fromJson);
            return Success(model);
          }
        case Failure(errorResponse: final errorResponse):
          {
            return Failure(errorResponse);
          }
      }
    } else {
      return Failure(
        ErrorResponse(
          error: "No internet found",
          exception: NoInternetFoundException(),
        ),
      );
    }
  }

  ApiResult<int> deleteAsync(String path,
      {Duration? timeout, CancelToken? cancelToken}) async {
    bool isOnline = await networkService.isOnline();
    if (isOnline) {
      var response = await clientService.deleteAsync(path,
          timeout: timeout, cancelToken: cancelToken);

      switch (response) {
        case Success(value: final value):
          {
            return Success(value?.statusCode);
          }
        case Failure(errorResponse: final errorResponse):
          {
            return Failure(errorResponse);
          }
      }
    } else {
      return Failure(
        ErrorResponse(
          error: "No internet found",
          exception: NoInternetFoundException(),
        ),
      );
    }
  }

  ApiResult<String> getAsyncStringResultNoCache(
    String path, {
    Duration? timeout,
    CancelToken? cancelToken,
  }) async {
    bool isOnline = await networkService.isOnline();
    if (isOnline) {
      var response = await clientService.getAsync(
        path,
        timeout: timeout,
        cancelToken: cancelToken,
        responseType: ResponseType.plain,
      );

      switch (response) {
        case Success(value: final value):
          {
            var model = value?.data;
            return Success(model);
          }
        case Failure(errorResponse: final errorResponse):
          {
            return Failure(errorResponse);
          }
      }
    } else {
      return Failure(
        ErrorResponse(
          error: "No internet found",
          exception: NoInternetFoundException(),
        ),
      );
    }
  }
}
