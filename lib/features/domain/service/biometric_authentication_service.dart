import 'package:commerce_flutter_app/features/domain/service/interfaces/biometric_authentication_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BiometricAuthenticationService
    implements IBiometricAuthenticationService {
  String get _domainStorageKey => "domain";
  String get _userNameStorageKey => "userName";
  String get _passwordStorageKey => "password";
  String get _biometricOptionUserKeyPrefix => "biometricOption";

  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;

  BiometricAuthenticationService({
    required ICommerceAPIServiceProvider commerceAPIServiceProvider,
  }) : _commerceAPIServiceProvider = commerceAPIServiceProvider;

  @override
  Future<bool> authenticate(String password) async {
    final userName = _commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.userName;

    if (userName.isNullorWhitespace) {
      return false;
    }

    final response = await _commerceAPIServiceProvider
        .getAuthenticationService()
        .logInAsync(userName!, password);

    switch (response) {
      case Success(value: bool? value):
        return value ?? false;

      case Failure():
        return false;
    }
  }

  @override
  Future<bool> disableBiometricAuthentication() async {
    final isDomainRemoved = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .remove(_domainStorageKey);
    final isUserNameRemoved = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .remove(_userNameStorageKey);
    final isPasswordRemoved = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .remove(_passwordStorageKey);

    return isDomainRemoved && isUserNameRemoved && isPasswordRemoved;
  }

  @override
  Future<bool> enableBiometricAuthentication(String password) async {
    final userName = _commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.userName;

    final domain = _commerceAPIServiceProvider.getClientService().host;

    if (userName.isNullorWhitespace || domain.isNullorWhitespace) {
      return false;
    }

    return (await _commerceAPIServiceProvider
            .getSecureStorageService()
            .save(_domainStorageKey, domain!)) &&
        (await _commerceAPIServiceProvider
            .getSecureStorageService()
            .save(_userNameStorageKey, userName!)) &&
        (await _commerceAPIServiceProvider
            .getSecureStorageService()
            .save(_passwordStorageKey, password));
  }

  @override
  Future<bool> hasCurrentUserSeenEnableBiometricOptionView() async {
    final domain = _commerceAPIServiceProvider.getClientService().host;
    final userName = _commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.userName;

    if (domain.isNullorWhitespace || userName.isNullorWhitespace) {
      return false;
    }

    final key = _biometricOptionUserKeyPrefix + domain! + userName!;
    final value =
        await _commerceAPIServiceProvider.getLocalStorageService().load(key);

    return !value.isNullOrEmpty;
  }

  @override
  Future<bool> hasStoredCredentialsForCurrentDomain() async {
    final domain = _commerceAPIServiceProvider.getClientService().host;
    final storedDomain = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .load(_domainStorageKey);

    if (storedDomain.isNullorWhitespace || storedDomain != domain) {
      return false;
    }

    return !(await _commerceAPIServiceProvider
                .getSecureStorageService()
                .load(_userNameStorageKey))
            .isNullOrEmpty &&
        !(await _commerceAPIServiceProvider
                .getSecureStorageService()
                .load(_passwordStorageKey))
            .isNullOrEmpty;
  }

  @override
  Future<bool> isBiometricAuthenticationEnableForCurrentUser() async {
    if (!(await hasStoredCredentialsForCurrentDomain())) {
      return false;
    }

    final userName = _commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.userName;
    final storedUserName = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .load(_userNameStorageKey);

    return userName == storedUserName;
  }

  @override
  Future<bool> logInWithStoredCredentials() async {
    final userName = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .load(_userNameStorageKey);
    final password = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .load(_passwordStorageKey);

    if (userName.isNullorWhitespace || password.isNullorWhitespace) {
      return false;
    }

    final response = await _commerceAPIServiceProvider
        .getAuthenticationService()
        .logInAsync(userName!, password!);

    switch (response) {
      case Success(value: bool? value):
        return value ?? false;

      case Failure():
        return false;
    }
  }

  @override
  Future<void> logoutWithStoredCredentials() async {
    final userName = _commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.userName;
    final storedUserName = await _commerceAPIServiceProvider
        .getSecureStorageService()
        .load(_userNameStorageKey);

    if (!userName.isNullorWhitespace &&
        !storedUserName.isNullorWhitespace &&
        userName == storedUserName) {
      await _commerceAPIServiceProvider
          .getSecureStorageService()
          .remove(_domainStorageKey);
      await _commerceAPIServiceProvider
          .getSecureStorageService()
          .remove(_userNameStorageKey);
      await _commerceAPIServiceProvider
          .getSecureStorageService()
          .remove(_passwordStorageKey);
    }
  }

  @override
  Future<void> markCurrentUserAsSeenEnableBiometricOptionView() async {
    final domain = _commerceAPIServiceProvider.getClientService().host;
    final userName = _commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.userName;

    if (domain.isNullorWhitespace || userName.isNullorWhitespace) {
      return;
    }

    final key = _biometricOptionUserKeyPrefix + domain! + userName!;
    await _commerceAPIServiceProvider
        .getLocalStorageService()
        .save(key, userName);
  }
}
