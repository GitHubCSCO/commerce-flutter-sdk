abstract class IBiometricAuthenticationService {
  Future<bool> hasCurrentUserSeenEnableBiometricOptionView();

  Future<void> markCurrentUserAsSeenEnableBiometricOptionView();

  Future<bool> hasStoredCredentialsForCurrentDomain();

  Future<bool> isBiometricAuthenticationEnableForCurrentUser();

  Future<bool> authenticate(String password);

  Future<bool> enableBiometricAuthentication(String password);

  Future<bool> disableBiometricAuthentication();

  Future<bool> logInWithStoredCredentials();

  Future<void> logoutWithStoredCredentials();
}
