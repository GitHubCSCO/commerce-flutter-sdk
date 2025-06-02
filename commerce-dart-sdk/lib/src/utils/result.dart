import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

sealed class Result<S, E> {
  const Result();
}

class Success<S, E> extends Result<S, E> {
  const Success(this.value, {this.statusCode});
  final S? value;
  final int? statusCode;
}

class Failure<S, E> extends Result<S, E> {
  const Failure(this.errorResponse);
  final E errorResponse;
}

typedef ApiResult<S> = Future<Result<S, ErrorResponse>>;
