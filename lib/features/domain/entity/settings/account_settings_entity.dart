import 'package:equatable/equatable.dart';

class AccountSettingsEntity extends Equatable {
  final bool? allowCreateAccount;
  final bool? allowGuestCheckout;
  final bool? allowSubscribeToNewsLetter;
  final bool? requireSelectCustomerOnSignIn;
  final int? passwordMinimumLength;
  final int? passwordMinimumRequiredLength;
  final bool? passwordRequiresSpecialCharacter;
  final bool? passwordRequiresUppercase;
  final bool? passwordRequiresLowercase;
  final bool? rememberMe;
  final bool? passwordRequiresDigit;
  final int? daysToRetainUser;
  final bool? useEmailAsUserName;
  final bool? enableWarehousePickup;
  final bool? logOutUserAfterPasswordChange;

  const AccountSettingsEntity({
    this.allowCreateAccount,
    this.allowGuestCheckout,
    this.allowSubscribeToNewsLetter,
    this.requireSelectCustomerOnSignIn,
    this.passwordMinimumLength,
    this.passwordMinimumRequiredLength,
    this.passwordRequiresSpecialCharacter,
    this.passwordRequiresUppercase,
    this.passwordRequiresLowercase,
    this.rememberMe,
    this.passwordRequiresDigit,
    this.daysToRetainUser,
    this.useEmailAsUserName,
    this.enableWarehousePickup,
    this.logOutUserAfterPasswordChange,
  });

  @override
  List<Object?> get props => [
        allowCreateAccount,
        allowGuestCheckout,
        allowSubscribeToNewsLetter,
        requireSelectCustomerOnSignIn,
        passwordMinimumLength,
        passwordMinimumRequiredLength,
        passwordRequiresSpecialCharacter,
        passwordRequiresUppercase,
        passwordRequiresLowercase,
        rememberMe,
        passwordRequiresDigit,
        daysToRetainUser,
        useEmailAsUserName,
        enableWarehousePickup,
        logOutUserAfterPasswordChange,
      ];

  AccountSettingsEntity copyWith({
    bool? allowCreateAccount,
    bool? allowGuestCheckout,
    bool? allowSubscribeToNewsLetter,
    bool? requireSelectCustomerOnSignIn,
    int? passwordMinimumLength,
    int? passwordMinimumRequiredLength,
    bool? passwordRequiresSpecialCharacter,
    bool? passwordRequiresUppercase,
    bool? passwordRequiresLowercase,
    bool? rememberMe,
    bool? passwordRequiresDigit,
    int? daysToRetainUser,
    bool? useEmailAsUserName,
    bool? enableWarehousePickup,
    bool? logOutUserAfterPasswordChange,
  }) {
    return AccountSettingsEntity(
      allowCreateAccount: allowCreateAccount ?? this.allowCreateAccount,
      allowGuestCheckout: allowGuestCheckout ?? this.allowGuestCheckout,
      allowSubscribeToNewsLetter:
          allowSubscribeToNewsLetter ?? this.allowSubscribeToNewsLetter,
      requireSelectCustomerOnSignIn:
          requireSelectCustomerOnSignIn ?? this.requireSelectCustomerOnSignIn,
      passwordMinimumLength:
          passwordMinimumLength ?? this.passwordMinimumLength,
      passwordMinimumRequiredLength:
          passwordMinimumRequiredLength ?? this.passwordMinimumRequiredLength,
      passwordRequiresSpecialCharacter: passwordRequiresSpecialCharacter ??
          this.passwordRequiresSpecialCharacter,
      passwordRequiresUppercase:
          passwordRequiresUppercase ?? this.passwordRequiresUppercase,
      passwordRequiresLowercase:
          passwordRequiresLowercase ?? this.passwordRequiresLowercase,
      rememberMe: rememberMe ?? this.rememberMe,
      passwordRequiresDigit:
          passwordRequiresDigit ?? this.passwordRequiresDigit,
      daysToRetainUser: daysToRetainUser ?? this.daysToRetainUser,
      useEmailAsUserName: useEmailAsUserName ?? this.useEmailAsUserName,
      enableWarehousePickup:
          enableWarehousePickup ?? this.enableWarehousePickup,
      logOutUserAfterPasswordChange:
          logOutUserAfterPasswordChange ?? this.logOutUserAfterPasswordChange,
    );
  }
}
