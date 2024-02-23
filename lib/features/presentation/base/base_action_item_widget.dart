import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseActionItemWidget extends StatelessWidget {
  const BaseActionItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  String getActionIconPath(ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.categories:
        return "assets/images/icon_shop_categories.svg";
      case ActionType.brands:
        return "assets/images/icon_shop_brands.svg";
      case ActionType.quickOrder:
        return "assets/images/icon_quick_orders.svg";
      case ActionType.orderHistory:
        return "assets/images/icon_orders.svg";
      case ActionType.lists:
        return "assets/images/icon_lists.svg";
      case ActionType.locationFinder:
        return "assets/images/icon_location_finder.svg";
      case ActionType.settings:
        return "assets/images/icon_setting.svg";
      case ActionType.changeCustomer:
        return "assets/images/icon_change_customer.svg";
      case ActionType.signOut:
        return "assets/images/icon_sign_out.svg";
      case ActionType.viewAccountOnWebsite:
        return "assets/images/icon_view_account.svg";
      case ActionType.search:
        return "assets/images/icon_search.svg";
      default:
        return "assets/images/icon_view_account.svg";
    }
  }

  String getActionTitle(ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.categories:
        return LocalizationConstants.shopCategories;
      case ActionType.brands:
        return LocalizationConstants.shopBrands;
      case ActionType.quickOrder:
        return LocalizationConstants.quickOrder;
      case ActionType.orderHistory:
        return LocalizationConstants.orders;
      case ActionType.showHidePricing:
        return LocalizationConstants.showHidePricing;
      case ActionType.showHideInventory:
        return LocalizationConstants.showHideInventory;
      case ActionType.orderApproval:
        return LocalizationConstants.orderApproval;
      case ActionType.lists:
        return LocalizationConstants.lists;
      case ActionType.savedOrders:
        return LocalizationConstants.savedOrders;
      case ActionType.locationFinder:
        return LocalizationConstants.locationFinder;
      case ActionType.settings:
        return LocalizationConstants.settings;
      case ActionType.changeCustomer:
        // return this.hasWillCall ? LocalizationConstants.ChangeCustomerWillCall : LocalizationConstants.ChangeCustomer;
        return LocalizationConstants.changeCustomer;
      case ActionType.signOut:
        return LocalizationConstants.signOut;
      case ActionType.viewAccountOnWebsite:
        return LocalizationConstants.viewAccountOnWebsite;
      case ActionType.search:
        return LocalizationConstants.search;
      case ActionType.forceCrash:
        return "Force Crash";
      case ActionType.toggleLogging:
      // return Logger.IsAllLogsEnabled ? "Disable logging" : "Enable logging";
      case ActionType.invoices:
        return LocalizationConstants.invoiceHistory;
      case ActionType.savedPayments:
        return LocalizationConstants.mySavedPayments;
      case ActionType.quotes:
        return LocalizationConstants.myQuotes;
      case ActionType.vmi:
        return LocalizationConstants.vendorManagedInventory;
      case ActionType.countInventory:
        return LocalizationConstants.countInventory;
      case ActionType.createOrder:
        return LocalizationConstants.createOrder;
      case ActionType.custom:
        return actionLink.text!;
      case ActionType.unknown:
      default:
        return actionLink.text ?? "";
    }
  }

  Function() onActionNavigationCommand(
      BuildContext context, ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.signOut:
        return () {
          signOut(context);
        };
      case ActionType.settings:
        return () {
          navigateToSettings(context);
        };
      default:
        return () {};
    }
  }

  void signOut(BuildContext context) {
    context.read<LogoutCubit>().logout();
  }

  void navigateToSettings(BuildContext context) {
    /// TODO - implement
    throw UnimplementedError();
  }
}
