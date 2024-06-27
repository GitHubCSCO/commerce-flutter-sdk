import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ActionLinkUseCase extends BaseUseCase {

  Future<List<ActionLinkEntity>> getViewableActions(List<ActionLinkEntity>? actions) async {
    List<ActionLinkEntity> list = [];

    var session = commerceAPIServiceProvider.getSessionService().getCachedCurrentSession();
    var authentication = await commerceAPIServiceProvider.getAuthenticationService().isAuthenticatedAsync();

    bool? isAuthenticated = switch (authentication) {
      Success(value: final data) => Success(data).value,
      Failure() => false
    };

    if(session == null) {
      final Result<Session, ErrorResponse> currentSession = await commerceAPIServiceProvider.getSessionService().getCurrentSession();
      session = switch(currentSession) {
        Success(value: final data) => Success(data).value,
        Failure() => null
      };
    }

    for (var action in actions ?? []) {
      final actionRequiresAuthentication = _actionRequiresAuth(action);
      if (actionRequiresAuthentication) {
        if (!isAuthenticated!) {
          continue;
        } else {
          if (session == null || (session.isRequisitioner && !(action.type == ActionType.lists || action.type == ActionType.signOut))) {
            continue;
          }
          if (action.type == ActionType.vmi && !session.isVMIUser) {
            continue;
          }
          if (action.type == ActionType.orderApproval && !session.isOrderApprovalApplicableUser) {
            continue;
          }
          if (action.type == ActionType.showHidePricing && !session.displayPricingAndInventory!) {
            continue;
          }
          if (action.type == ActionType.showHideInventory && !session.displayPricingAndInventory!) {
            continue;
          }
        }
      }

      list.add(action);
    }
    return list;
  }

  bool _actionRequiresAuth(ActionLinkEntity action) {
    switch (action.type) {
      case ActionType.orderHistory:
      case ActionType.lists:
      case ActionType.savedOrders:
      case ActionType.orderApproval:
      case ActionType.changeCustomer:
      case ActionType.signOut:
      case ActionType.invoices:
      case ActionType.savedPayments:
      case ActionType.quotes:
      case ActionType.vmi:
      case ActionType.createOrder:
      case ActionType.countInventory:
      case ActionType.showHidePricing:
      case ActionType.showHideInventory:
        return true;
      case ActionType.categories:
      case ActionType.brands:
      case ActionType.quickOrder:
      case ActionType.search:
      case ActionType.viewAccountOnWebsite:
      case ActionType.settings:
      case ActionType.forceCrash:
      case ActionType.toggleLogging:
      case ActionType.locationFinder:
        return false;
      case ActionType.custom:
        return action.requiresAuth ?? false;
      case ActionType.unknown:
      default:
        return false;
    }
  }

}