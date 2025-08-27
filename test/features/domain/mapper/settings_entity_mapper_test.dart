import 'package:commerce_flutter_sdk/src/features/domain/entity/settings/account_settings_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/settings/order_settings_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/settings_entity_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('Settings Entity Mappers', () {
    group('WishListSettingsEntityMapper', () {
      test('should correctly map WishListSettings to WishListSettingsEntity',
          () {
        // Arrange
        final model = WishListSettings(
          allowMultipleWishLists: true,
          allowEditingOfWishLists: true,
          allowWishListsByCustomer: false,
          allowListSharing: true,
          productsPerPage: 20,
          enableWishListReminders: false,
        );

        // Act
        final result = WishListSettingsEntityMapper.toEntity(model);

        // Assert
        expect(result.allowMultipleWishLists, model.allowMultipleWishLists);
        expect(result.allowEditingOfWishLists, model.allowEditingOfWishLists);
        expect(result.allowWishListsByCustomer, model.allowWishListsByCustomer);
        expect(result.allowListSharing, model.allowListSharing);
        expect(result.productsPerPage, model.productsPerPage);
        expect(result.enableWishListReminders, model.enableWishListReminders);
      });

      test('should correctly map WishListSettingsEntity to WishListSettings',
          () {
        // Arrange
        const entity = WishListSettingsEntity(
          allowMultipleWishLists: false,
          allowEditingOfWishLists: true,
          allowWishListsByCustomer: true,
          allowListSharing: false,
          productsPerPage: 15,
          enableWishListReminders: true,
        );

        // Act
        final result = WishListSettingsEntityMapper.toModel(entity);

        // Assert
        expect(result.allowMultipleWishLists, entity.allowMultipleWishLists);
        expect(result.allowEditingOfWishLists, entity.allowEditingOfWishLists);
        expect(
            result.allowWishListsByCustomer, entity.allowWishListsByCustomer);
        expect(result.allowListSharing, entity.allowListSharing);
        expect(result.productsPerPage, entity.productsPerPage);
        expect(result.enableWishListReminders, entity.enableWishListReminders);
      });

      test(
          'should handle null values correctly when mapping to WishListSettingsEntity',
          () {
        // Arrange
        final model = WishListSettings(
          allowMultipleWishLists: null,
          allowEditingOfWishLists: null,
          allowWishListsByCustomer: null,
          allowListSharing: null,
          productsPerPage: null,
          enableWishListReminders: null,
        );

        // Act
        final result = WishListSettingsEntityMapper.toEntity(model);

        // Assert
        // Note: WishListSettings constructor sets default values for some fields when null is passed
        expect(result.allowMultipleWishLists, true); // Default value
        expect(result.allowEditingOfWishLists, true); // Default value
        expect(result.allowWishListsByCustomer, false); // Default value
        expect(result.allowListSharing, true); // Default value
        expect(result.productsPerPage, isNull); // No default value
        expect(result.enableWishListReminders, isNull); // No default value
      });

      test('should maintain data integrity in roundtrip conversion', () {
        // Arrange
        final originalModel = WishListSettings(
          allowMultipleWishLists: true,
          allowEditingOfWishLists: false,
          allowWishListsByCustomer: true,
          allowListSharing: true,
          productsPerPage: 25,
          enableWishListReminders: false,
        );

        // Act
        final entity = WishListSettingsEntityMapper.toEntity(originalModel);
        final resultModel = WishListSettingsEntityMapper.toModel(entity);

        // Assert
        expect(resultModel.allowMultipleWishLists,
            originalModel.allowMultipleWishLists);
        expect(resultModel.allowEditingOfWishLists,
            originalModel.allowEditingOfWishLists);
        expect(resultModel.allowWishListsByCustomer,
            originalModel.allowWishListsByCustomer);
        expect(resultModel.allowListSharing, originalModel.allowListSharing);
        expect(resultModel.productsPerPage, originalModel.productsPerPage);
        expect(resultModel.enableWishListReminders,
            originalModel.enableWishListReminders);
      });
    });

    group('AccountSettingsMapper', () {
      test('should correctly map AccountSettings to AccountSettingsEntity', () {
        // Arrange
        final model = AccountSettings(
          allowCreateAccount: true,
          allowGuestCheckout: false,
          allowSubscribeToNewsLetter: true,
          requireSelectCustomerOnSignIn: false,
          passwordMinimumLength: 8,
          passwordMinimumRequiredLength: 12,
          passwordRequiresSpecialCharacter: true,
          passwordRequiresUppercase: true,
          passwordRequiresLowercase: true,
          rememberMe: true,
          passwordRequiresDigit: true,
          daysToRetainUser: 30,
          useEmailAsUserName: true,
          enableWarehousePickup: false,
          logOutUserAfterPasswordChange: true,
        );

        // Act
        final result = AccountSettingsMapper.toEntity(model);

        // Assert
        expect(result.allowCreateAccount, model.allowCreateAccount);
        expect(result.allowGuestCheckout, model.allowGuestCheckout);
        expect(result.allowSubscribeToNewsLetter,
            model.allowSubscribeToNewsLetter);
        expect(result.requireSelectCustomerOnSignIn,
            model.requireSelectCustomerOnSignIn);
        expect(result.passwordMinimumLength, model.passwordMinimumLength);
        expect(result.passwordMinimumRequiredLength,
            model.passwordMinimumRequiredLength);
        expect(result.passwordRequiresSpecialCharacter,
            model.passwordRequiresSpecialCharacter);
        expect(
            result.passwordRequiresUppercase, model.passwordRequiresUppercase);
        expect(
            result.passwordRequiresLowercase, model.passwordRequiresLowercase);
        expect(result.rememberMe, model.rememberMe);
        expect(result.passwordRequiresDigit, model.passwordRequiresDigit);
        expect(result.daysToRetainUser, model.daysToRetainUser);
        expect(result.useEmailAsUserName, model.useEmailAsUserName);
        expect(result.enableWarehousePickup, model.enableWarehousePickup);
        expect(result.logOutUserAfterPasswordChange,
            model.logOutUserAfterPasswordChange);
      });

      test('should correctly map AccountSettingsEntity to AccountSettings', () {
        // Arrange
        const entity = AccountSettingsEntity(
          allowCreateAccount: false,
          allowGuestCheckout: true,
          allowSubscribeToNewsLetter: false,
          requireSelectCustomerOnSignIn: true,
          passwordMinimumLength: 10,
          passwordMinimumRequiredLength: 15,
          passwordRequiresSpecialCharacter: false,
          passwordRequiresUppercase: false,
          passwordRequiresLowercase: true,
          rememberMe: false,
          passwordRequiresDigit: false,
          daysToRetainUser: 60,
          useEmailAsUserName: false,
          enableWarehousePickup: true,
          logOutUserAfterPasswordChange: false,
        );

        // Act
        final result = AccountSettingsMapper.toModel(entity);

        // Assert
        expect(result.allowCreateAccount, entity.allowCreateAccount);
        expect(result.allowGuestCheckout, entity.allowGuestCheckout);
        expect(result.allowSubscribeToNewsLetter,
            entity.allowSubscribeToNewsLetter);
        expect(result.requireSelectCustomerOnSignIn,
            entity.requireSelectCustomerOnSignIn);
        expect(result.passwordMinimumLength, entity.passwordMinimumLength);
        expect(result.passwordMinimumRequiredLength,
            entity.passwordMinimumRequiredLength);
        expect(result.passwordRequiresSpecialCharacter,
            entity.passwordRequiresSpecialCharacter);
        expect(
            result.passwordRequiresUppercase, entity.passwordRequiresUppercase);
        expect(
            result.passwordRequiresLowercase, entity.passwordRequiresLowercase);
        expect(result.rememberMe, entity.rememberMe);
        expect(result.passwordRequiresDigit, entity.passwordRequiresDigit);
        expect(result.daysToRetainUser, entity.daysToRetainUser);
        expect(result.useEmailAsUserName, entity.useEmailAsUserName);
        expect(result.enableWarehousePickup, entity.enableWarehousePickup);
        expect(result.logOutUserAfterPasswordChange,
            entity.logOutUserAfterPasswordChange);
      });

      test(
          'should handle null values correctly when mapping to AccountSettingsEntity',
          () {
        // Arrange
        final model = AccountSettings(
          allowCreateAccount: null,
          allowGuestCheckout: null,
          allowSubscribeToNewsLetter: null,
          requireSelectCustomerOnSignIn: null,
          passwordMinimumLength: null,
          passwordMinimumRequiredLength: null,
          passwordRequiresSpecialCharacter: null,
          passwordRequiresUppercase: null,
          passwordRequiresLowercase: null,
          rememberMe: null,
          passwordRequiresDigit: null,
          daysToRetainUser: null,
          useEmailAsUserName: null,
          enableWarehousePickup: null,
          logOutUserAfterPasswordChange: null,
        );

        // Act
        final result = AccountSettingsMapper.toEntity(model);

        // Assert
        expect(result.allowCreateAccount, isNull);
        expect(result.allowGuestCheckout, isNull);
        expect(result.allowSubscribeToNewsLetter, isNull);
        expect(result.requireSelectCustomerOnSignIn, isNull);
        expect(result.passwordMinimumLength, isNull);
        expect(result.passwordMinimumRequiredLength, isNull);
        expect(result.passwordRequiresSpecialCharacter, isNull);
        expect(result.passwordRequiresUppercase, isNull);
        expect(result.passwordRequiresLowercase, isNull);
        expect(result.rememberMe, isNull);
        expect(result.passwordRequiresDigit, isNull);
        expect(result.daysToRetainUser, isNull);
        expect(result.useEmailAsUserName, isNull);
        expect(result.enableWarehousePickup, isNull);
        expect(result.logOutUserAfterPasswordChange, isNull);
      });

      test('should maintain data integrity in roundtrip conversion', () {
        // Arrange
        final originalModel = AccountSettings(
          allowCreateAccount: true,
          allowGuestCheckout: true,
          allowSubscribeToNewsLetter: false,
          requireSelectCustomerOnSignIn: true,
          passwordMinimumLength: 6,
          passwordMinimumRequiredLength: 10,
          passwordRequiresSpecialCharacter: false,
          passwordRequiresUppercase: true,
          passwordRequiresLowercase: true,
          rememberMe: false,
          passwordRequiresDigit: true,
          daysToRetainUser: 45,
          useEmailAsUserName: false,
          enableWarehousePickup: true,
          logOutUserAfterPasswordChange: false,
        );

        // Act
        final entity = AccountSettingsMapper.toEntity(originalModel);
        final resultModel = AccountSettingsMapper.toModel(entity);

        // Assert
        expect(
            resultModel.allowCreateAccount, originalModel.allowCreateAccount);
        expect(
            resultModel.allowGuestCheckout, originalModel.allowGuestCheckout);
        expect(resultModel.allowSubscribeToNewsLetter,
            originalModel.allowSubscribeToNewsLetter);
        expect(resultModel.requireSelectCustomerOnSignIn,
            originalModel.requireSelectCustomerOnSignIn);
        expect(resultModel.passwordMinimumLength,
            originalModel.passwordMinimumLength);
        expect(resultModel.passwordMinimumRequiredLength,
            originalModel.passwordMinimumRequiredLength);
        expect(resultModel.passwordRequiresSpecialCharacter,
            originalModel.passwordRequiresSpecialCharacter);
        expect(resultModel.passwordRequiresUppercase,
            originalModel.passwordRequiresUppercase);
        expect(resultModel.passwordRequiresLowercase,
            originalModel.passwordRequiresLowercase);
        expect(resultModel.rememberMe, originalModel.rememberMe);
        expect(resultModel.passwordRequiresDigit,
            originalModel.passwordRequiresDigit);
        expect(resultModel.daysToRetainUser, originalModel.daysToRetainUser);
        expect(
            resultModel.useEmailAsUserName, originalModel.useEmailAsUserName);
        expect(resultModel.enableWarehousePickup,
            originalModel.enableWarehousePickup);
        expect(resultModel.logOutUserAfterPasswordChange,
            originalModel.logOutUserAfterPasswordChange);
      });
    });

    group('OrderSettingsEntityMapper', () {
      test('should correctly map OrderSettings to OrderSettingsEntity', () {
        // Arrange
        final model = OrderSettings(
          allowCancellationRequest: true,
          allowQuickOrder: true,
          canReorderItems: false,
          canOrderUpload: true,
          allowRma: false,
          showCostCode: true,
          showPoNumber: true,
          showTermsCode: false,
          showErpOrderNumber: true,
          showWebOrderNumber: true,
          showOrderStatus: true,
          showOrders: true,
          lookBackDays: 90,
          vmiEnabled: false,
        );

        // Act
        final result = OrderSettingsEntityMapper.toEntity(model);

        // Assert
        expect(result.allowCancellationRequest, model.allowCancellationRequest);
        expect(result.allowQuickOrder, model.allowQuickOrder);
        expect(result.canReorderItems, model.canReorderItems);
        expect(result.canOrderUpload, model.canOrderUpload);
        expect(result.allowRma, model.allowRma);
        expect(result.showCostCode, model.showCostCode);
        expect(result.showPoNumber, model.showPoNumber);
        expect(result.showTermsCode, model.showTermsCode);
        expect(result.showErpOrderNumber, model.showErpOrderNumber);
        expect(result.showWebOrderNumber, model.showWebOrderNumber);
        expect(result.showOrderStatus, model.showOrderStatus);
        expect(result.showOrders, model.showOrders);
        expect(result.lookBackDays, model.lookBackDays);
        expect(result.vmiEnabled, model.vmiEnabled);
      });

      test('should correctly map OrderSettingsEntity to OrderSettings', () {
        // Arrange
        const entity = OrderSettingsEntity(
          allowCancellationRequest: false,
          allowQuickOrder: false,
          canReorderItems: true,
          canOrderUpload: false,
          allowRma: true,
          showCostCode: false,
          showPoNumber: false,
          showTermsCode: true,
          showErpOrderNumber: false,
          showWebOrderNumber: false,
          showOrderStatus: false,
          showOrders: false,
          lookBackDays: 180,
          vmiEnabled: true,
        );

        // Act
        final result = OrderSettingsEntityMapper.toModel(entity);

        // Assert
        expect(
            result.allowCancellationRequest, entity.allowCancellationRequest);
        expect(result.allowQuickOrder, entity.allowQuickOrder);
        expect(result.canReorderItems, entity.canReorderItems);
        expect(result.canOrderUpload, entity.canOrderUpload);
        expect(result.allowRma, entity.allowRma);
        expect(result.showCostCode, entity.showCostCode);
        expect(result.showPoNumber, entity.showPoNumber);
        expect(result.showTermsCode, entity.showTermsCode);
        expect(result.showErpOrderNumber, entity.showErpOrderNumber);
        expect(result.showWebOrderNumber, entity.showWebOrderNumber);
        expect(result.showOrderStatus, entity.showOrderStatus);
        expect(result.showOrders, entity.showOrders);
        expect(result.lookBackDays, entity.lookBackDays);
        expect(result.vmiEnabled, entity.vmiEnabled);
      });

      test(
          'should handle null values correctly when mapping to OrderSettingsEntity',
          () {
        // Arrange
        final model = OrderSettings(
          allowCancellationRequest: null,
          allowQuickOrder: null,
          canReorderItems: null,
          canOrderUpload: null,
          allowRma: null,
          showCostCode: null,
          showPoNumber: null,
          showTermsCode: null,
          showErpOrderNumber: null,
          showWebOrderNumber: null,
          showOrderStatus: null,
          showOrders: null,
          lookBackDays: null,
          vmiEnabled: null,
        );

        // Act
        final result = OrderSettingsEntityMapper.toEntity(model);

        // Assert
        expect(result.allowCancellationRequest, isNull);
        expect(result.allowQuickOrder, isNull);
        expect(result.canReorderItems, isNull);
        expect(result.canOrderUpload, isNull);
        expect(result.allowRma, isNull);
        expect(result.showCostCode, isNull);
        expect(result.showPoNumber, isNull);
        expect(result.showTermsCode, isNull);
        expect(result.showErpOrderNumber, isNull);
        expect(result.showWebOrderNumber, isNull);
        expect(result.showOrderStatus, isNull);
        expect(result.showOrders, isNull);
        expect(result.lookBackDays, isNull);
        expect(result.vmiEnabled, isNull);
      });

      test('should maintain data integrity in roundtrip conversion', () {
        // Arrange
        final originalModel = OrderSettings(
          allowCancellationRequest: true,
          allowQuickOrder: false,
          canReorderItems: true,
          canOrderUpload: true,
          allowRma: false,
          showCostCode: true,
          showPoNumber: false,
          showTermsCode: true,
          showErpOrderNumber: true,
          showWebOrderNumber: false,
          showOrderStatus: true,
          showOrders: true,
          lookBackDays: 365,
          vmiEnabled: true,
        );

        // Act
        final entity = OrderSettingsEntityMapper.toEntity(originalModel);
        final resultModel = OrderSettingsEntityMapper.toModel(entity);

        // Assert
        expect(resultModel.allowCancellationRequest,
            originalModel.allowCancellationRequest);
        expect(resultModel.allowQuickOrder, originalModel.allowQuickOrder);
        expect(resultModel.canReorderItems, originalModel.canReorderItems);
        expect(resultModel.canOrderUpload, originalModel.canOrderUpload);
        expect(resultModel.allowRma, originalModel.allowRma);
        expect(resultModel.showCostCode, originalModel.showCostCode);
        expect(resultModel.showPoNumber, originalModel.showPoNumber);
        expect(resultModel.showTermsCode, originalModel.showTermsCode);
        expect(
            resultModel.showErpOrderNumber, originalModel.showErpOrderNumber);
        expect(
            resultModel.showWebOrderNumber, originalModel.showWebOrderNumber);
        expect(resultModel.showOrderStatus, originalModel.showOrderStatus);
        expect(resultModel.showOrders, originalModel.showOrders);
        expect(resultModel.lookBackDays, originalModel.lookBackDays);
        expect(resultModel.vmiEnabled, originalModel.vmiEnabled);
      });

      test('should handle realistic order settings configurations', () {
        // Test different common configurations
        final configurations = [
          {
            'name': 'Enterprise Configuration',
            'settings': OrderSettings(
              allowCancellationRequest: true,
              allowQuickOrder: true,
              canReorderItems: true,
              canOrderUpload: true,
              allowRma: true,
              showCostCode: true,
              showPoNumber: true,
              showTermsCode: true,
              showErpOrderNumber: true,
              showWebOrderNumber: true,
              showOrderStatus: true,
              showOrders: true,
              lookBackDays: 365,
              vmiEnabled: true,
            ),
          },
          {
            'name': 'Basic Configuration',
            'settings': OrderSettings(
              allowCancellationRequest: false,
              allowQuickOrder: false,
              canReorderItems: true,
              canOrderUpload: false,
              allowRma: false,
              showCostCode: false,
              showPoNumber: false,
              showTermsCode: false,
              showErpOrderNumber: false,
              showWebOrderNumber: true,
              showOrderStatus: true,
              showOrders: true,
              lookBackDays: 30,
              vmiEnabled: false,
            ),
          },
        ];

        for (final config in configurations) {
          final settings = config['settings'] as OrderSettings;

          // Act
          final entity = OrderSettingsEntityMapper.toEntity(settings);
          final resultModel = OrderSettingsEntityMapper.toModel(entity);

          // Assert
          expect(resultModel.allowCancellationRequest,
              settings.allowCancellationRequest,
              reason: 'Failed for ${config['name']}');
          expect(resultModel.allowQuickOrder, settings.allowQuickOrder,
              reason: 'Failed for ${config['name']}');
          expect(resultModel.canReorderItems, settings.canReorderItems,
              reason: 'Failed for ${config['name']}');
          expect(resultModel.canOrderUpload, settings.canOrderUpload,
              reason: 'Failed for ${config['name']}');
          expect(resultModel.allowRma, settings.allowRma,
              reason: 'Failed for ${config['name']}');
          expect(resultModel.lookBackDays, settings.lookBackDays,
              reason: 'Failed for ${config['name']}');
          expect(resultModel.vmiEnabled, settings.vmiEnabled,
              reason: 'Failed for ${config['name']}');
        }
      });
    });
  });
}
