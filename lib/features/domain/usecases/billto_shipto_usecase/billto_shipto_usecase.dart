import 'package:commerce_flutter_app/features/domain/enums/fullfillment_method_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillToShipToUseCase extends BaseUseCase {
  Future<Session?> getCurrentSession() async {
    Session? cachedCurrentSession = 
            commerceAPIServiceProvider
                .getSessionService()
                .getCachedCurrentSession();
                
    if(cachedCurrentSession==null){
      final result = await commerceAPIServiceProvider
          .getSessionService()
          .getCurrentSession();
      Session? currentSession = result is Success ? (result as Success).value : null;
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

    Session newSession = Session(
      activateAccount: currentSession.activateAccount,
      billTo: billToAddress ?? currentSession.billTo,
      currency: currentSession.currency,
      customLandingPage: currentSession.customLandingPage,
      customerWasUpdated: currentSession.customerWasUpdated,
      dashboardIsHomepage: currentSession.dashboardIsHomepage,
      deviceType: currentSession.deviceType,
      displayChangeCustomerLink: currentSession.displayChangeCustomerLink,
      displayPricingAndInventory: currentSession.displayPricingAndInventory,
      email: currentSession.email,
      firstName: currentSession.firstName,
      fulfillmentMethod: (willCall && selectedShippingMethod != null)
          ? (selectedShippingMethod.name)
          : currentSession.fulfillmentMethod,
      hasDefaultCustomer: currentSession.hasDefaultCustomer,
      hasRfqUpdates: currentSession.hasRfqUpdates,
      isAuthenticated: currentSession.isAuthenticated,
      isGuest: currentSession.isGuest,
      isRestrictedProductRemovedFromCart:
          currentSession.isRestrictedProductRemovedFromCart,
      isSalesPerson: currentSession.isSalesPerson,
      language: currentSession.language,
      lastName: currentSession.lastName,
      newPassword: currentSession.newPassword,
      password: currentSession.password,
      persona: currentSession.persona,
      personas: currentSession.personas,
      pickUpWarehouse: pickUpWarehouse ?? currentSession.pickUpWarehouse,
      redirectToChangeCustomerPageOnSignIn:
          currentSession.redirectToChangeCustomerPageOnSignIn,
      rememberMe: currentSession.rememberMe,
      resetPassword: currentSession.resetPassword,
      resetToken: currentSession.resetToken,
      shipTo: shipToRecipientAddress ?? currentSession.shipTo,
      userLabel: currentSession.userLabel,
      userName: currentSession.userName,
      userProfileId: currentSession.userProfileId,
      userRoles: currentSession.userRoles,
    );

    final result = await commerceAPIServiceProvider
        .getSessionService()
        .patchCustomerSession(newSession);
    //TODO we need to make it better:
    //TODO follow webflow
    if(result is Success){
        commerceAPIServiceProvider.getCacheService().clearAllCaches();
        Session patchedSession = (result as Success).value as Session;
        // commerceAPIServiceProvider.getSessionService().currentSession = patchedSession;
        return patchedSession;
    }else{
      return null;
    }
  }

  Future<bool> hasWillCall() async {
    return await coreServiceProvider.getAppConfigurationService().hasWillCall();
  }
}
