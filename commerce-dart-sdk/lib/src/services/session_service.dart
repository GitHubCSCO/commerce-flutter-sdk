import 'dart:async';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SessionService extends ServiceBase implements ISessionService {
  SessionService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  }) {
    clientService.authStatusStream.listen((event) async {
      if (event == AuthSDKStatus.loggedOut) {
        await deleteCurrentSession();
      }
    });
  }

  @override
  void deleteCachedCurrentSession() {
    _cachedCurrentSession = null;
  }

  @override
  Future<Result<bool, ErrorResponse>> deleteCurrentSession() async {
    _cachedCurrentSession = null;
    var response = await deleteAsync(CommerceAPIConstants.currentSessionUrl);

    switch (response) {
      case Success(value: final value):
        {
          return Success(
              value != null && StatusCodeExtension.isSuccessStatusCode(value));
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<Session, ErrorResponse>> getCachedOrCurrentSession() async {
    var cachedSession = getCachedCurrentSession();
    if (cachedSession == null) {
      return getCurrentSession();
    } else {
      return Success(cachedSession);
    }
  }

  @override
  Future<Result<Session, ErrorResponse>> getCurrentSession({
    bool shouldCacheSessionTemp = true,
  }) async {
    var result = await getAsyncNoCache<Session>(
        CommerceAPIConstants.currentSessionUrl, Session.fromJson);

    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            if (_cachedCurrentSession != null) {
              if ((_cachedCurrentSession?.persona != value.persona) ||
                  !(_cachedCurrentSession?.personas != null &&
                      value.personas != null)) {
                /// TODO - Notify Session Changed
              }
            }

            await clientService.storeSessionState(currentSession: value);
            if (shouldCacheSessionTemp) {
              _cachedCurrentSession = value;
            }
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<Session, ErrorResponse>> patchCustomerSession(
    Session session, {
    bool shouldCacheSessionTemp = true,
  }) async {
    var data = session.toJson();
    var response = await patchAsyncNoCache<Session>(
      CommerceAPIConstants.currentSessionUrl,
      data,
      Session.fromJson,
    );

    switch (response) {
      case Success(value: final value):
        {
          if (value != null) {
            if (session.shipTo?.id != value.shipTo?.id) {
              value.shipTo = session.shipTo;
              clientService.storeSessionState(currentSession: value);
            }

            // If value != null then patch worked, but we have to call getCurrentSession
            // to get the most up to date version of the session
            // TODO - This needs more investigation
            // After patch session in web current returns the updated pathed session
            // If we log out and login we get the previous session before the patch
            var sessionResponse = await getCurrentSession();
            switch (sessionResponse) {
              case Success(value: final vl):
                {
                  if (shouldCacheSessionTemp) {
                    _cachedCurrentSession = vl;
                  }
                  return Success(vl);
                }
              case Failure(errorResponse: final errorResponse):
                {
                  return Failure(errorResponse);
                }
            }
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<Session, ErrorResponse>> patchSession(
    Session session, {
    bool shouldCacheSessionTemp = true,
  }) async {
    var jsonData = serialize(session, (Session session) => session.toJson());
    var result = await patchAsyncNoCache<Session>(
        CommerceAPIConstants.currentSessionUrl, jsonData, Session.fromJson);

    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            await clientService.storeSessionState(currentSession: value);

            deleteCachedCurrentSession();

            var sessionResponse = await getCurrentSession();

            switch (sessionResponse) {
              case Success(value: final value):
                {
                  if (shouldCacheSessionTemp) {
                    _cachedCurrentSession = value;
                  }
                  return Success(value);
                }
              case Failure(errorResponse: final errorResponse):
                {
                  return Failure(errorResponse);
                }
            }
          }
          return Success(value);
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<Session, ErrorResponse>> postSession(
    Session session, {
    bool shouldCacheSessionTemp = true,
  }) async {
    var jsonData = serialize(session, (Session session) => session.toJson());
    var result = await postAsyncNoCache<Session>(
        CommerceAPIConstants.postSessionUrl, jsonData, Session.fromJson);

    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            await clientService.storeSessionState(currentSession: value);
            if (shouldCacheSessionTemp) {
              _cachedCurrentSession = value;
            }
          }

          return Success(value);
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<Session, ErrorResponse>> forgotPassword(String userName) async {
    final session = Session(resetPassword: true, userName: userName);
    final jsonData = serialize(session, (Session session) => session.toJson());

    final result = await patchAsyncNoCache(
      CommerceAPIConstants.currentSessionUrl,
      jsonData,
      Session.fromJson,
    );

    return result;
  }

  //We should utlize getCachedCurrentSession instead of calling getCurrentSession in every subsequent call
  //To reduce number of api call
  @override
  Session? getCachedCurrentSession() {
    return _cachedCurrentSession;
  }

  Session? _cachedCurrentSession;
}
