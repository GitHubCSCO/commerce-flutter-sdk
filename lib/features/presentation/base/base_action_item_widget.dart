import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:flutter/material.dart';

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
        return LocalizationConstants.ShopCategories;
      case ActionType.brands:
        return LocalizationConstants.ShopBrands;
      case ActionType.quickOrder:
        return LocalizationConstants.QuickOrder;
      case ActionType.orderHistory:
        return LocalizationConstants.Orders;
      case ActionType.showHidePricing:
        return LocalizationConstants.ShowHidePricing;
      case ActionType.showHideInventory:
        return LocalizationConstants.ShowHideInventory;
      case ActionType.orderApproval:
        return LocalizationConstants.OrderApproval;
      case ActionType.lists:
        return LocalizationConstants.Lists;
      case ActionType.savedOrders:
        return LocalizationConstants.SavedOrders;
      case ActionType.locationFinder:
        return LocalizationConstants.LocationFinder;
      case ActionType.settings:
        return LocalizationConstants.Settings;
      case ActionType.changeCustomer:
      // return this.hasWillCall ? LocalizationConstants.ChangeCustomerWillCall : LocalizationConstants.ChangeCustomer;
        return LocalizationConstants.ChangeCustomer;
      case ActionType.signOut:
        return LocalizationConstants.SignOut;
      case ActionType.viewAccountOnWebsite:
        return LocalizationConstants.ViewAccountOnWebsite;
      case ActionType.search:
        return LocalizationConstants.Search;
      case ActionType.forceCrash:
        return "Force Crash";
      case ActionType.toggleLogging:
      // return Logger.IsAllLogsEnabled ? "Disable logging" : "Enable logging";
      case ActionType.invoices:
        return LocalizationConstants.InvoiceHistory;
      case ActionType.savedPayments:
        return LocalizationConstants.MySavedPayments;
      case ActionType.quotes:
        return LocalizationConstants.MyQuotes;
      case ActionType.vmi:
        return LocalizationConstants.VendorManagedInventory;
      case ActionType.countInventory:
        return LocalizationConstants.CountInventory;
      case ActionType.createOrder:
        return LocalizationConstants.CreateOrder;
      case ActionType.custom:
        return actionLink.text!;
      case ActionType.unknown:
      default:
        return actionLink.text ?? "";
    }
  }
}
