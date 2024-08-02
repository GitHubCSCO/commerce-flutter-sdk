import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/enums/fullfillment_method_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillToShipToUseCase extends BaseUseCase {
  Future<Session?> getCurrentSession() async {
    Session? cachedCurrentSession = commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();

    if (cachedCurrentSession == null) {
      final result = await commerceAPIServiceProvider
          .getSessionService()
          .getCurrentSession();
      Session? currentSession =
          result is Success ? (result as Success).value : null;
      return Future.value(currentSession);
    }

    return Future.value(cachedCurrentSession);
  }

  Future<Session?> updateCurrentSession(
      {BillTo? billToAddress,
      ShipTo? shipToRecipientAddress,
      Warehouse? pickUpWarehouse,
      FulfillmentMethodType? selectedShippingMethod}) async {
    Session? curSession = await getCurrentSession();
    if (curSession?.isAuthenticated != true) {
      return null;
    }

    Session currentSession = curSession!;

    bool willCall = await hasWillCall();

    if (willCall) {
      currentSession.fulfillmentMethod = selectedShippingMethod?.name;
    }
    currentSession.billTo = billToAddress;

    if (selectedShippingMethod == FulfillmentMethodType.PickUp) {
      currentSession.shipTo = shipToRecipientAddress;
    } else if (selectedShippingMethod == FulfillmentMethodType.Ship) {
      currentSession.shipTo = shipToRecipientAddress;
    }

    currentSession.pickUpWarehouse = pickUpWarehouse;

    final result = await commerceAPIServiceProvider
        .getSessionService()
        .patchCustomerSession(currentSession);
    //TODO we need to make it better:
    //TODO follow webflow
    if (result is Success) {
      commerceAPIServiceProvider.getCacheService().clearAllCaches();
      Session patchedSession = (result as Success).value as Session;
      return patchedSession;
    } else {
      return null;
    }
  }

  Future<void> updateDefaultCustomerIfNeeded(
      bool isDefaultEnable,
      bool isDefaultCustomer,
      FulfillmentMethodType selectedShippingMethod,
      bool wasShipToUpdated) async {
    final session = (await commerceAPIServiceProvider
            .getSessionService()
            .getCurrentSession())
        .getResultSuccessValue();
    final willCall = await hasWillCall();

    var willUpdateDefaultCustomer = !isDefaultCustomer && isDefaultEnable;
    willUpdateDefaultCustomer |= isDefaultCustomer && !isDefaultEnable;

    if (willUpdateDefaultCustomer) {
      final currentAccount =
          commerceAPIServiceProvider.getAccountService().currentAccount;
      if (session == null || currentAccount == null) {
        return;
      }

      currentAccount.setDefaultCustomer = true;
      var isFulfillmentMethodPickUpSetAsDefault = willCall &&
          selectedShippingMethod == FulfillmentMethodType.PickUp &&
          isDefaultEnable;
      currentAccount.defaultWarehouseId = isFulfillmentMethodPickUpSetAsDefault
          ? session.pickUpWarehouse?.id.toString()
          : null;
      currentAccount.defaultWarehouse = isFulfillmentMethodPickUpSetAsDefault
          ? session.pickUpWarehouse
          : null;

      currentAccount.defaultFulfillmentMethod = selectedShippingMethod.name;
      currentAccount.defaultCustomerId =
          isDefaultEnable ? session.shipTo?.id : null;

      final accountPatchResultResponse = (await commerceAPIServiceProvider
              .getAccountService()
              .patchAccountAsync(currentAccount))
          .getResultSuccessValue();

      if (accountPatchResultResponse == null) {
        return;
      }
    }
  }

  Future<bool> isDefaultCustomerSelected(
      FulfillmentMethodType selectedShippingMethod,
      bool wasShipToUpdated) async {
    final session = (await commerceAPIServiceProvider
            .getSessionService()
            .getCurrentSession())
        .getResultSuccessValue();
    if (session?.shipTo == null) {
      return false;
    } else {
      final currentAccount =
          commerceAPIServiceProvider.getAccountService().currentAccount;

      if (currentAccount?.defaultFulfillmentMethod != null &&
          !(currentAccount?.defaultFulfillmentMethod ==
              selectedShippingMethod.name)) {
        return false;
      } else {
        if (wasShipToUpdated) {
          return session?.shipTo?.isDefault ?? false;
        } else {
          return !(session?.redirectToChangeCustomerPageOnSignIn ?? false);
        }
      }
    }
  }

  Future<bool> hasWillCall() async {
    return await coreServiceProvider.getAppConfigurationService().hasWillCall();
  }
}
