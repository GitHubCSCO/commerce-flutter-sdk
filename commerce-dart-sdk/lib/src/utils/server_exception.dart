import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

enum ServerExceptionType {
  requestCancelled,

  badCertificate,

  unauthorisedRequest,

  connectionError,

  badRequest,

  notFound,

  requestTimeout,

  sendTimeout,

  recieveTimeout,

  conflict,

  internalServerError,

  notImplemented,

  serviceUnavailable,

  socketException,

  formatException,

  unableToProcess,

  defaultError,

  unexpectedError,

  cloudflareGatewayTimeout,
}

class ServerException extends Equatable implements Exception {
  final String name, message;
  final int? statusCode;
  final ServerExceptionType exceptionType;

  ServerException._({
    required this.message,
    this.exceptionType = ServerExceptionType.unexpectedError,
    this.statusCode,
  }) : name = exceptionType.name;

  factory ServerException(dynamic error) {
    late ServerException serverException;
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          serverException = ServerException._(
              exceptionType: ServerExceptionType.requestCancelled,
              statusCode: error.response?.statusCode,
              message: 'Request to the server has been canceled');
          break;

        case DioExceptionType.connectionTimeout:
          serverException = ServerException._(
              exceptionType: ServerExceptionType.requestTimeout,
              statusCode: error.response?.statusCode,
              message: 'Connection timeout');
          break;

        case DioExceptionType.receiveTimeout:
          serverException = ServerException._(
              exceptionType: ServerExceptionType.recieveTimeout,
              statusCode: error.response?.statusCode,
              message: 'Receive timeout');
          break;

        case DioExceptionType.sendTimeout:
          serverException = ServerException._(
              exceptionType: ServerExceptionType.sendTimeout,
              statusCode: error.response?.statusCode,
              message: 'Send timeout');
          break;

        case DioExceptionType.connectionError:
          serverException = ServerException._(
              exceptionType: ServerExceptionType.connectionError,
              statusCode: error.response?.statusCode,
              message: 'Connection error');
          break;

        case DioExceptionType.badCertificate:
          serverException = ServerException._(
              exceptionType: ServerExceptionType.badCertificate,
              statusCode: error.response?.statusCode,
              message: 'Bad certificate');
          break;

        case DioExceptionType.unknown:
          if (error.error
              .toString()
              .contains(ServerExceptionType.socketException.name)) {
            serverException = ServerException._(
                statusCode: error.response?.statusCode,
                message: 'Verify your internet connection');
          } else {
            serverException = ServerException._(
                exceptionType: ServerExceptionType.unexpectedError,
                statusCode: error.response?.statusCode,
                message: 'Unexpected error');
          }
          break;

        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case 400:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.badRequest,
                  statusCode: error.response?.statusCode,
                  message: 'Bad request.');
              break;
            case 401:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.unauthorisedRequest,
                  statusCode: error.response?.statusCode,
                  message: 'Authentication failure');
              break;
            case 403:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.unauthorisedRequest,
                  statusCode: error.response?.statusCode,
                  message: 'User is not authorized to access API');
              break;
            case 404:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.notFound,
                  statusCode: error.response?.statusCode,
                  message: 'Request ressource does not exist');
              break;
            case 405:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.unauthorisedRequest,
                  statusCode: error.response?.statusCode,
                  message: 'Operation not allowed');
              break;
            case 415:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.notImplemented,
                  statusCode: error.response?.statusCode,
                  message: 'Media type unsupported');
              break;
            case 422:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.unableToProcess,
                  statusCode: error.response?.statusCode,
                  message: 'validation data failure');
              break;
            case 429:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.conflict,
                  statusCode: error.response?.statusCode,
                  message: 'too much requests');
              break;
            case 500:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.internalServerError,
                  statusCode: error.response?.statusCode,
                  message: 'Internal server error');
              break;
            case 503:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.serviceUnavailable,
                  statusCode: error.response?.statusCode,
                  message: 'Service unavailable');
              break;
            case 504:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.serviceUnavailable,
                  statusCode: error.response?.statusCode,
                  message: 'Gateway timeout');
              break;
            case 524:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.cloudflareGatewayTimeout,
                  statusCode: error.response?.statusCode,
                  message: 'Cloudflare gateway timeout');
              break;
            default:
              serverException = ServerException._(
                  exceptionType: ServerExceptionType.unexpectedError,
                  statusCode: error.response?.statusCode,
                  message: 'Unexpected error');
          }
          break;
      }
    } else if (error is FormatException) {
      serverException = ServerException._(
          exceptionType: ServerExceptionType.formatException,
          message: 'Format error');
    } else {
      serverException = ServerException._(
          exceptionType: ServerExceptionType.unexpectedError,
          message: 'Unexpected error');
    }
    return serverException;
  }

  @override
  List<Object?> get props => [name, statusCode, exceptionType];
}
