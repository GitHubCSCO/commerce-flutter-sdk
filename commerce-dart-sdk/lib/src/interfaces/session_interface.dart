import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class ISessionService {
  Session? getCachedCurrentSession();

  Future<Result<Session, ErrorResponse>> getCachedOrCurrentSession();

  Future<Result<Session, ErrorResponse>> postSession(
    Session session, {
    bool shouldCacheSessionTemp = true,
  });

  Future<Result<Session, ErrorResponse>> patchSession(
    Session session, {
    bool shouldCacheSessionTemp = true,
  });

  Future<Result<Session, ErrorResponse>> patchCustomerSession(
    Session session, {
    bool shouldCacheSessionTemp = true,
  });

  Future<Result<Session, ErrorResponse>> getCurrentSession({
    bool shouldCacheSessionTemp = true,
  });

  Future<Result<bool, ErrorResponse>> deleteCurrentSession();

  Future<Result<Session, ErrorResponse>> forgotPassword(String userName);

  void deleteCachedCurrentSession();
}
