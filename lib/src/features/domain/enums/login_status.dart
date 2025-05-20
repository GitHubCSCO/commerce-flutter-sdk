enum LoginStatus {
  loginSuccess, // successful, show previous screen
  loginSuccessBiometric, // successful, show biometric options
  loginSuccessBillToShipTo, // successful, show bill to ship to
  loginErrorOffline, // unsuccessful, offline
  loginErrorUnsuccessful, // unsuccessful, online
  loginErrorUnknown,
  loginFailed, // unsuccessful, unknown
}
