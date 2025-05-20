import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AccountService extends ServiceBase implements IAccountService {
  AccountService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  Account? _currentAccount;

  @override
  Account? get currentAccount => _currentAccount;

  set currentAccount(Account? value) {
    _currentAccount = value;
    if (!(currentAccount == null || currentAccount!.id.isNullOrEmpty)) {
      // this.TrackingService.SetUserID(currentAccount.Id);
    }
  }

  @override
  Future<Result<Account, ErrorResponse>>
      getCachedOrCurrentAccountAsync() async {
    if (currentAccount == null) {
      return getCurrentAccountAsync();
    } else {
      return Success(currentAccount);
    }
  }

  //DELETE:: /api/v1/accounts/current/paymentprofiles/{AccountPaymentProfileId}
  @override
  Future<Result<bool, ErrorResponse>> deleteCurrentAccountPaymentProfileIdAsync(
    String accountPaymentProfileId,
  ) async {
    var urlString =
        '${CommerceAPIConstants.accountUrl}${CommerceAPIConstants.currentPaymentProfiles}$accountPaymentProfileId';

    final result = await deleteAsync(urlString);
    switch (result) {
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
  Future<Result<bool, ErrorResponse>> deletePaymentProfile(
      String accountPaymentProfileId) async {
    if (accountPaymentProfileId.isEmpty) {
      return Failure(
          ErrorResponse(message: 'accountPaymentProfileId is empty'));
    }

    var urlString =
        '${CommerceAPIConstants.paymentProfileUrl}/$accountPaymentProfileId';

    final result = await deleteAsync(urlString);
    switch (result) {
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

  //GET:: /api/v1/accounts/{accountId}
  @override
  Future<Result<Account, ErrorResponse>> getAccountIdAsync(
      String accountId) async {
    var urlString = '${CommerceAPIConstants.accountUrl}/$accountId';
    return await getAsyncNoCache<Account>(urlString, Account.fromJson);
  }

  //GET:: /api/v1/accounts
  @override
  Future<Result<AccountResult, ErrorResponse>> getAccountsAsync() async {
    return await getAsyncNoCache<AccountResult>(
        CommerceAPIConstants.accountUrl, AccountResult.fromJson);
  }

  @override
  Future<Result<Account, ErrorResponse>> getCurrentAccountAsync() async {
    final result = await getAsyncNoCache<Account>(
      '${CommerceAPIConstants.accountUrl}/current',
      Account.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            currentAccount = value;
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
  Future<Result<Account, ErrorResponse>>
      getCurrentAccountPaymentProfileAsync() async {
    var urlString =
        '${CommerceAPIConstants.accountUrl}${CommerceAPIConstants.currentPaymentProfiles}';

    final result = await getAsyncNoCache<Account>(
      urlString,
      Account.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            currentAccount = value;
          }

          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  //GET:: /api/v1/accounts/current/paymentprofiles/{AccountPaymentProfileId}
  @override
  Future<Result<Account, ErrorResponse>> getCurrentAccountPaymentProfileIdAsync(
    String accountPaymentProfileId,
  ) async {
    var urlString =
        '${CommerceAPIConstants.accountUrl}${CommerceAPIConstants.currentPaymentProfiles}$accountPaymentProfileId';

    final result = await getAsyncNoCache<Account>(
      urlString,
      Account.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            currentAccount = value;
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
  Future<Result<AccountPaymentProfile, ErrorResponse>> getPaymentProfile(
    String accountPaymentProfileId,
  ) async {
    if (accountPaymentProfileId.isNullOrEmpty) {
      throw Exception('accountPaymentProfileId is null or empty');
    }

    var urlString =
        '${CommerceAPIConstants.paymentProfileUrl}/$accountPaymentProfileId';

    final result = await getAsyncNoCache<AccountPaymentProfile>(
      urlString,
      AccountPaymentProfile.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (result) {
      case Success(value: final value):
        {
          if (value == null) {
            return Failure(ErrorResponse(
                message:
                    'The account payment profile requested cannot be found.'));
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
  Future<Result<AccountPaymentProfileCollectionResult, ErrorResponse>>
      getPaymentProfiles({
    PaymentProfileQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.paymentProfileUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache<AccountPaymentProfileCollectionResult>(
      url.toString(),
      AccountPaymentProfileCollectionResult.fromJson,
    );
  }

  //GET:: /api/v1/accounts/{AccountId}/shiptos
  @override
  Future<Result<ShipTo, ErrorResponse>> getShipToAddressAsync(
    String accountId,
  ) async {
    var urlString = '${CommerceAPIConstants.accountUrl}/$accountId/shiptos';
    return await getAsyncNoCache<ShipTo>(urlString, ShipTo.fromJson);
  }

  @override
  Future<Result<Account, ErrorResponse>> patchAccountAsync(
      Account account) async {
    var urlString = '${CommerceAPIConstants.accountUrl}/current';
    final data = account.toJson();
    return await patchAsyncNoCache<Account>(
      urlString,
      data,
      Account.fromJson,
    );
  }

  //PATCH:: /api/v1/accounts/{accountId}
  @override
  Future<Result<Account, ErrorResponse>> patchAccountIdAsync(
    String accountId,
  ) async {
    // try {
    //   var urlString = '${CommerceAPIConstants.accountUrl}/$accountId';
    //   final data =
    //   var result = await PatchAsyncNoCache<Account>(url, stringContent);

    //   return result;
    // } catch (e) {
    //   return ServiceResponse<Account>(exception: Exception(e.toString()));
    // }

    // TODO: implement patchAccountIdAsync
    throw UnimplementedError();
  }

  //PATCH:: /api/v1/accounts/vmi/{vmiUserId}
  @override
  Future<Result<Account, ErrorResponse>> patchAccountsVmiAsync(
    String vmiUserId,
    Account account,
  ) async {
    var urlString = '${CommerceAPIConstants.accountUrl}/vmi/$vmiUserId';
    final data = account.toJson();
    return await patchAsyncNoCache<Account>(
      urlString,
      data,
      Account.fromJson,
    );
  }

  //PATCH:: /api/v1/accounts/current/paymentprofiles/{accountPaymentProfileId}
  @override
  Future<Result<Account, ErrorResponse>>
      patchCurrentAccountPaymentProfileIdAsync(
    String accountPaymentProfileId,
    Account account,
  ) async {
    var urlString =
        '${CommerceAPIConstants.accountUrl}${CommerceAPIConstants.currentPaymentProfiles}$accountPaymentProfileId';
    final data = account.toJson();
    final result = await patchAsyncNoCache<Account>(
      urlString,
      data,
      Account.fromJson,
    );

    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            currentAccount = value;
          }

          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  //PATCH:: /api/v1/accounts/{accountId}/shiptos
  @override
  Future<Result<Account, ErrorResponse>> patchShipToAddressAsync(
      String accountId) {
    // TODO: implement patchShipToAddressAsync
    throw UnimplementedError();
  }

  //POST:: /api/v1/accounts
  @override
  Future<Result<Account, ErrorResponse>> postAccountsAsync(
      Account account) async {
    var urlString = CommerceAPIConstants.accountUrl;
    final data = account.toJson();

    return await postAsyncNoCache<Account>(
      urlString,
      data,
      Account.fromJson,
    );
  }

  //POST:: /api/v1/accounts/vmi/import
  @override
  Future<Result<Account, ErrorResponse>> postAccountsVmiAsync(
    Account account,
  ) async {
    var urlString = '${CommerceAPIConstants.accountUrl}/vmi/import';
    final data = account.toJson();

    return await postAsyncNoCache<Account>(
      urlString,
      data,
      Account.fromJson,
    );
  }

  //POST:: /api/v1/accounts/current/paymentprofiles
  @override
  Future<Result<Account, ErrorResponse>> postCurrentAccountPaymentProfileAsync(
    Account account,
  ) async {
    var urlString =
        '${CommerceAPIConstants.accountUrl}${CommerceAPIConstants.currentPaymentProfiles}';

    final data = account.toJson();
    final result = await postAsyncNoCache<Account>(
      urlString,
      data,
      Account.fromJson,
    );
    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            currentAccount = value;
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
  Future<Result<AccountPaymentProfile, ErrorResponse>> savePaymentProfile(
    AccountPaymentProfile accountPaymentProfile,
  ) async {
    final data = accountPaymentProfile.toJson();

    if (accountPaymentProfile.id.isNullOrEmpty) {
      accountPaymentProfile.id = '';
    }

    if (accountPaymentProfile.id == '') {
      return await postAsyncNoCache<AccountPaymentProfile>(
        CommerceAPIConstants.paymentProfileUrl,
        data,
        AccountPaymentProfile.fromJson,
      );
    } else {
      return await patchAsyncNoCache<AccountPaymentProfile>(
        '${CommerceAPIConstants.paymentProfileUrl}/${accountPaymentProfile.id}',
        data,
        AccountPaymentProfile.fromJson,
      );
    }
  }
}
