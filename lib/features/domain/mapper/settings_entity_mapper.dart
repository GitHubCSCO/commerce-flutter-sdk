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
