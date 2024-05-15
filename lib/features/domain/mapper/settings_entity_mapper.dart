import 'package:commerce_flutter_app/features/domain/entity/settings/account_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListSettingsEntityMapper {
  static WishListSettingsEntity toEntity(WishListSettings model) {
    return WishListSettingsEntity(
      allowMultipleWishLists: model.allowMultipleWishLists,
      allowEditingOfWishLists: model.allowEditingOfWishLists,
      allowWishListsByCustomer: model.allowWishListsByCustomer,
      allowListSharing: model.allowListSharing,
      productsPerPage: model.productsPerPage,
      enableWishListReminders: model.enableWishListReminders,
    );
  }

  static WishListSettings toModel(WishListSettingsEntity entity) {
    return WishListSettings(
      allowMultipleWishLists: entity.allowMultipleWishLists,
      allowEditingOfWishLists: entity.allowEditingOfWishLists,
      allowWishListsByCustomer: entity.allowWishListsByCustomer,
      allowListSharing: entity.allowListSharing,
      productsPerPage: entity.productsPerPage,
      enableWishListReminders: entity.enableWishListReminders,
    );
  }
}

class AccountSettingsMapper {
  static AccountSettingsEntity toEntity(AccountSettings model) {
    return AccountSettingsEntity(
      allowCreateAccount: model.allowCreateAccount,
      allowGuestCheckout: model.allowGuestCheckout,
      allowSubscribeToNewsLetter: model.allowSubscribeToNewsLetter,
      requireSelectCustomerOnSignIn: model.requireSelectCustomerOnSignIn,
      passwordMinimumLength: model.passwordMinimumLength,
      passwordMinimumRequiredLength: model.passwordMinimumRequiredLength,
      passwordRequiresSpecialCharacter: model.passwordRequiresSpecialCharacter,
      passwordRequiresUppercase: model.passwordRequiresUppercase,
      passwordRequiresLowercase: model.passwordRequiresLowercase,
      rememberMe: model.rememberMe,
      passwordRequiresDigit: model.passwordRequiresDigit,
      daysToRetainUser: model.daysToRetainUser,
      useEmailAsUserName: model.useEmailAsUserName,
      enableWarehousePickup: model.enableWarehousePickup,
      logOutUserAfterPasswordChange: model.logOutUserAfterPasswordChange,
    );
  }

  static AccountSettings toModel(AccountSettingsEntity entity) {
    return AccountSettings(
      allowCreateAccount: entity.allowCreateAccount,
      allowGuestCheckout: entity.allowGuestCheckout,
      allowSubscribeToNewsLetter: entity.allowSubscribeToNewsLetter,
      requireSelectCustomerOnSignIn: entity.requireSelectCustomerOnSignIn,
      passwordMinimumLength: entity.passwordMinimumLength,
      passwordMinimumRequiredLength: entity.passwordMinimumRequiredLength,
      passwordRequiresSpecialCharacter: entity.passwordRequiresSpecialCharacter,
      passwordRequiresUppercase: entity.passwordRequiresUppercase,
      passwordRequiresLowercase: entity.passwordRequiresLowercase,
      rememberMe: entity.rememberMe,
      passwordRequiresDigit: entity.passwordRequiresDigit,
      daysToRetainUser: entity.daysToRetainUser,
      useEmailAsUserName: entity.useEmailAsUserName,
      enableWarehousePickup: entity.enableWarehousePickup,
      logOutUserAfterPasswordChange: entity.logOutUserAfterPasswordChange,
    );
  }
}
