import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// A service which fetches the user account.
abstract class IAccountService {
  Account? get currentAccount;

  Future<Result<Account, ErrorResponse>> getCachedOrCurrentAccountAsync();

  Future<Result<AccountResult, ErrorResponse>> getAccountsAsync();

  Future<Result<Account, ErrorResponse>> getCurrentAccountAsync();

  Future<Result<Account, ErrorResponse>> patchAccountAsync(Account account);

  Future<Result<Account, ErrorResponse>> getAccountIdAsync(String accountId);

  Future<Result<Account, ErrorResponse>> postAccountsAsync(Account account);

  Future<Result<Account, ErrorResponse>> patchAccountIdAsync(String accountId);

  Future<Result<Account, ErrorResponse>> patchShipToAddressAsync(
      String accountId);

  Future<Result<ShipTo, ErrorResponse>> getShipToAddressAsync(String accountId);

  Future<Result<Account, ErrorResponse>> getCurrentAccountPaymentProfileAsync();

  Future<Result<Account, ErrorResponse>> postCurrentAccountPaymentProfileAsync(
      Account account);

  Future<Result<Account, ErrorResponse>>
      patchCurrentAccountPaymentProfileIdAsync(
          String accountPaymentProfileId, Account account);

  Future<Result<Account, ErrorResponse>> getCurrentAccountPaymentProfileIdAsync(
      String accountPaymentProfileId);

  Future<Result<bool, ErrorResponse>> deleteCurrentAccountPaymentProfileIdAsync(
      String accountPaymentProfileId);

  Future<Result<Account, ErrorResponse>> patchAccountsVmiAsync(
      String vmiUserId, Account account);

  Future<Result<Account, ErrorResponse>> postAccountsVmiAsync(Account account);

  /// A service which manages the account payment profile.
  Future<Result<AccountPaymentProfileCollectionResult, ErrorResponse>>
      getPaymentProfiles({PaymentProfileQueryParameters? parameters});

  Future<Result<AccountPaymentProfile, ErrorResponse>> getPaymentProfile(
      String accountPaymentProfileId);

  Future<Result<AccountPaymentProfile, ErrorResponse>> savePaymentProfile(
      AccountPaymentProfile accountPaymentProfile);

  Future<Result<bool, ErrorResponse>> deletePaymentProfile(
      String accountPaymentProfileId);
}
